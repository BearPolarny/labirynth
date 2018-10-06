class Population {
  ArrayList<Rocket> parents;
  Rocket[] rockets;
  int population = 200;
  Population() {
    rockets = new Rocket[population];
    for (int i = 0; i< population; i++) {
      rockets[i] = new Rocket();
    }
  }

  void show() {
    for (int i = 0; i< population; i++) {
      rockets[i].update();
    }
  }

  void newPopulation() {
    parents = new ArrayList();
    float maxFitness = 0;
    for (int i=0; i < population; i++) {
      rockets[i].fitness = rockets[i].fitness();
      if (rockets[i].fitness > maxFitness) maxFitness = rockets[i].fitness;
    }
    for (int i=0; i < population; i++) {
      rockets[i].fitness /= maxFitness;
    }

    for (int i = 0; i < population; i++) {
      int n = int(rockets[i].fitness * 10);
      for (int j = 0; j<n; j++) {
        parents.add(rockets[i]);
      }
    }

    for (int i=0; i < population; i++) {
      int a,b;
      a = int(random(parents.size()));
      b = int(random(parents.size()));
      rockets[i] = parents.get(a).crossover(parents.get(b));
      //println(parents.size() + " " + a + " " + b);
    }
    for (int i=0; i < population; i++) {
      rockets[i].mutate();
    }
  }
}
