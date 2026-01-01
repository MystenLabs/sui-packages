module 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::entry {
    struct InferenceRun has copy, drop {
        network_id: 0x2::object::ID,
        predicted_class: u64,
        input_hash: u256,
    }

    struct TrainStepComplete has copy, drop {
        population_id: 0x2::object::ID,
        generation: u64,
        best_fitness: u64,
    }

    public entry fun clone_network(arg0: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::clone_network(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_network(arg0: vector<u64>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::create_network(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_network_random(arg0: vector<u64>, arg1: vector<u8>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::create_network_random(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun destroy_network(arg0: 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::destroy_network(arg0);
    }

    public entry fun flip_weight(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork, arg1: u64, arg2: u64, arg3: u64) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::flip_weight(arg0, arg1, arg2, arg3);
    }

    public entry fun add_sample(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset, arg1: vector<u256>, arg2: u64) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::add_sample(arg0, arg1, arg2);
    }

    public entry fun add_sample_bools(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset, arg1: vector<bool>, arg2: u64) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::add_sample_from_bools(arg0, &arg1, arg2);
    }

    public entry fun create_dataset(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::create_dataset(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun create_dataset_shared(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::share_dataset(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::create_dataset(arg0, arg1, arg2, arg3, arg4));
    }

    public entry fun create_network_shared(arg0: vector<u64>, arg1: vector<u8>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::share_network(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::create_network_random(arg0, arg1, arg2, arg3));
    }

    public entry fun create_parity_dataset(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::create_parity_dataset(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun create_parity_dataset_shared(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::share_dataset(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::create_parity_dataset(arg0, arg1));
    }

    public entry fun create_population(arg0: vector<u64>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::create_population_random(arg0, arg1, arg2, 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_config(arg3, arg4, true, arg5), arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun create_population_shared(arg0: vector<u64>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: &mut 0x2::tx_context::TxContext) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::share_population(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::create_population_random(arg0, arg1, arg2, 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_config(arg3, arg4, true, arg5), arg6, arg7));
    }

    public entry fun create_xor_dataset(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::create_xor_dataset(arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun create_xor_dataset_shared(arg0: &mut 0x2::tx_context::TxContext) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::share_dataset(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::create_xor_dataset(arg0));
    }

    public entry fun demo_train_parity(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::create_parity_dataset(arg0, arg5);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg0);
        0x1::vector::push_back<u64>(v2, arg1);
        0x1::vector::push_back<u64>(v2, 2);
        let v3 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::create_population_random(v1, arg2, b"Parity_Population", 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_config(10, 3, true, 2), arg4, arg5);
        let v4 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_rng(arg4 + 12345);
        let v5 = 0;
        while (v5 < arg3) {
            0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population(&mut v3, &v0);
            0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::evolve_generation(&mut v3, &mut v4, arg5);
            v5 = v5 + 1;
        };
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population(&mut v3, &v0);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::destroy_population(v3);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::destroy_dataset(v0);
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::clone_network(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::get_best_individual(&v3), b"Trained_Parity", arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun demo_train_xor(arg0: u64, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::create_xor_dataset(arg2);
        let v1 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::create_population_random(vector[2, 4, 2], 10, b"XOR_Population", 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_config(5, 3, true, 2), arg1, arg2);
        let v2 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_rng(arg1 + 12345);
        let v3 = 0;
        while (v3 < arg0) {
            0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population(&mut v1, &v0);
            0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::evolve_generation(&mut v1, &mut v2, arg2);
            v3 = v3 + 1;
        };
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population(&mut v1, &v0);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::destroy_population(v1);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::destroy_dataset(v0);
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::clone_network(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::get_best_individual(&v1), b"Trained_XOR", arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun destroy_dataset(arg0: 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::destroy_dataset(arg0);
    }

    public entry fun destroy_population(arg0: 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::destroy_population(arg0);
    }

    public entry fun evaluate_population(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population, arg1: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population(arg0, arg1);
    }

    public entry fun evaluate_population_batch(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population, arg1: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset, arg2: u64, arg3: u256) {
        let v0 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_rng(arg3);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population_batch(arg0, arg1, arg2, &mut v0);
    }

    public entry fun evolve_population(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_rng(arg1);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::evolve_generation(arg0, &mut v0, arg2);
        let v1 = TrainStepComplete{
            population_id : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::id(arg0),
            generation    : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::generation(arg0),
            best_fitness  : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::best_fitness_ever(arg0),
        };
        0x2::event::emit<TrainStepComplete>(v1);
    }

    public entry fun extract_best_network(arg0: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork>(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::clone_network(0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::get_best_individual(arg0), arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun mutate_network(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork, arg1: u64, arg2: u256) {
        let v0 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_rng(arg2);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::mutate_network(arg0, arg1, &mut v0);
    }

    public entry fun run_inference(arg0: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork, arg1: vector<u256>, arg2: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg1)) {
            v0 = v0 ^ *0x1::vector::borrow<u256>(&arg1, v1);
            v1 = v1 + 1;
        };
        let v2 = InferenceRun{
            network_id      : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::id(arg0),
            predicted_class : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::predict_class(arg0, 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_layer::create_activation(arg1, arg2)),
            input_hash      : v0,
        };
        0x2::event::emit<InferenceRun>(v2);
    }

    public entry fun run_inference_bools(arg0: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::BinaryNetwork, arg1: vector<bool>) {
        let v0 = InferenceRun{
            network_id      : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::id(arg0),
            predicted_class : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_network::predict_class(arg0, 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::binary_layer::activation_from_bools(&arg1)),
            input_hash      : 0,
        };
        0x2::event::emit<InferenceRun>(v0);
    }

    public entry fun train_multiple_steps(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population, arg1: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset, arg2: u64, arg3: u64, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_rng(arg4);
        let v1 = 0;
        while (v1 < arg2) {
            0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population_batch(arg0, arg1, arg3, &mut v0);
            0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::evolve_generation(arg0, &mut v0, arg5);
            v1 = v1 + 1;
        };
        let v2 = TrainStepComplete{
            population_id : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::id(arg0),
            generation    : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::generation(arg0),
            best_fitness  : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::get_best_fitness(arg0),
        };
        0x2::event::emit<TrainStepComplete>(v2);
    }

    public entry fun train_step(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population, arg1: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population(arg0, arg1);
        let v0 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_rng(arg2);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::evolve_generation(arg0, &mut v0, arg3);
        let v1 = TrainStepComplete{
            population_id : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::id(arg0),
            generation    : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::generation(arg0),
            best_fitness  : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::get_best_fitness(arg0),
        };
        0x2::event::emit<TrainStepComplete>(v1);
    }

    public entry fun train_step_batch(arg0: &mut 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::Population, arg1: &0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::Dataset, arg2: u64, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::evolution::create_rng(arg3);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::training::evaluate_population_batch(arg0, arg1, arg2, &mut v0);
        0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::evolve_generation(arg0, &mut v0, arg4);
        let v1 = TrainStepComplete{
            population_id : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::id(arg0),
            generation    : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::generation(arg0),
            best_fitness  : 0x310a202eb4288219eb33966867aecf5e7142022c54f5a34310e1dadd91af8fa1::population::get_best_fitness(arg0),
        };
        0x2::event::emit<TrainStepComplete>(v1);
    }

    // decompiled from Move bytecode v6
}

