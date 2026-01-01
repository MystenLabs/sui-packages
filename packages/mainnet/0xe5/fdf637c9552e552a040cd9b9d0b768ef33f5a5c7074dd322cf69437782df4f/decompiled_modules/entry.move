module 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::entry {
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

    public entry fun clone_network(arg0: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::clone_network(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_network(arg0: vector<u64>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::create_network(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_network_random(arg0: vector<u64>, arg1: vector<u8>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::create_network_random(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun destroy_network(arg0: 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::destroy_network(arg0);
    }

    public entry fun flip_weight(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork, arg1: u64, arg2: u64, arg3: u64) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::flip_weight(arg0, arg1, arg2, arg3);
    }

    public entry fun add_sample(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset, arg1: vector<u256>, arg2: u64) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::add_sample(arg0, arg1, arg2);
    }

    public entry fun add_sample_bools(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset, arg1: vector<bool>, arg2: u64) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::add_sample_from_bools(arg0, &arg1, arg2);
    }

    public entry fun create_dataset(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::create_dataset(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun create_dataset_shared(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::share_dataset(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::create_dataset(arg0, arg1, arg2, arg3, arg4));
    }

    public entry fun create_network_shared(arg0: vector<u64>, arg1: vector<u8>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::share_network(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::create_network_random(arg0, arg1, arg2, arg3));
    }

    public entry fun create_parity_dataset(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::create_parity_dataset(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun create_parity_dataset_shared(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::share_dataset(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::create_parity_dataset(arg0, arg1));
    }

    public entry fun create_population(arg0: vector<u64>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::create_population_random(arg0, arg1, arg2, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_config(arg3, arg4, true, arg5), arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun create_population_shared(arg0: vector<u64>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: &mut 0x2::tx_context::TxContext) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::share_population(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::create_population_random(arg0, arg1, arg2, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_config(arg3, arg4, true, arg5), arg6, arg7));
    }

    public entry fun create_xor_dataset(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::create_xor_dataset(arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun create_xor_dataset_shared(arg0: &mut 0x2::tx_context::TxContext) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::share_dataset(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::create_xor_dataset(arg0));
    }

    public entry fun demo_train_parity(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::create_parity_dataset(arg0, arg5);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg0);
        0x1::vector::push_back<u64>(v2, arg1);
        0x1::vector::push_back<u64>(v2, 2);
        let v3 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::create_population_random(v1, arg2, b"Parity_Population", 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_config(10, 3, true, 2), arg4, arg5);
        let v4 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_rng(arg4 + 12345);
        let v5 = 0;
        while (v5 < arg3) {
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population(&mut v3, &v0);
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::evolve_generation(&mut v3, &mut v4, arg5);
            v5 = v5 + 1;
        };
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population(&mut v3, &v0);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::destroy_population(v3);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::destroy_dataset(v0);
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::clone_network(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_best_individual(&v3), b"Trained_Parity", arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun demo_train_xor(arg0: u64, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::create_xor_dataset(arg2);
        let v1 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::create_population_random(vector[2, 4, 2], 10, b"XOR_Population", 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_config(5, 3, true, 2), arg1, arg2);
        let v2 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_rng(arg1 + 12345);
        let v3 = 0;
        while (v3 < arg0) {
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population(&mut v1, &v0);
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::evolve_generation(&mut v1, &mut v2, arg2);
            v3 = v3 + 1;
        };
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population(&mut v1, &v0);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::destroy_population(v1);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::destroy_dataset(v0);
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::clone_network(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_best_individual(&v1), b"Trained_XOR", arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun destroy_dataset(arg0: 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::destroy_dataset(arg0);
    }

    public entry fun destroy_population(arg0: 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::destroy_population(arg0);
    }

    public entry fun evaluate_population(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population(arg0, arg1);
    }

    public entry fun evaluate_population_batch(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset, arg2: u64, arg3: u256) {
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_rng(arg3);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population_batch(arg0, arg1, arg2, &mut v0);
    }

    public entry fun evolve_population(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_rng(arg1);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::evolve_generation(arg0, &mut v0, arg2);
        let v1 = TrainStepComplete{
            population_id : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::id(arg0),
            generation    : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::generation(arg0),
            best_fitness  : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::best_fitness_ever(arg0),
        };
        0x2::event::emit<TrainStepComplete>(v1);
    }

    public entry fun extract_best_network(arg0: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::clone_network(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_best_individual(arg0), arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun mutate_network(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork, arg1: u64, arg2: u256) {
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_rng(arg2);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::mutate_network(arg0, arg1, &mut v0);
    }

    public entry fun run_inference(arg0: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork, arg1: vector<u256>, arg2: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg1)) {
            v0 = v0 ^ *0x1::vector::borrow<u256>(&arg1, v1);
            v1 = v1 + 1;
        };
        let v2 = InferenceRun{
            network_id      : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::id(arg0),
            predicted_class : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::predict_class(arg0, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_layer::create_activation(arg1, arg2)),
            input_hash      : v0,
        };
        0x2::event::emit<InferenceRun>(v2);
    }

    public entry fun run_inference_bools(arg0: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork, arg1: vector<bool>) {
        let v0 = InferenceRun{
            network_id      : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::id(arg0),
            predicted_class : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::predict_class(arg0, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_layer::activation_from_bools(&arg1)),
            input_hash      : 0,
        };
        0x2::event::emit<InferenceRun>(v0);
    }

    public entry fun train_multiple_steps(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset, arg2: u64, arg3: u64, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_rng(arg4);
        let v1 = 0;
        while (v1 < arg2) {
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population_batch(arg0, arg1, arg3, &mut v0);
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::evolve_generation(arg0, &mut v0, arg5);
            v1 = v1 + 1;
        };
        let v2 = TrainStepComplete{
            population_id : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::id(arg0),
            generation    : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::generation(arg0),
            best_fitness  : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_best_fitness(arg0),
        };
        0x2::event::emit<TrainStepComplete>(v2);
    }

    public entry fun train_step(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population(arg0, arg1);
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_rng(arg2);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::evolve_generation(arg0, &mut v0, arg3);
        let v1 = TrainStepComplete{
            population_id : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::id(arg0),
            generation    : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::generation(arg0),
            best_fitness  : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_best_fitness(arg0),
        };
        0x2::event::emit<TrainStepComplete>(v1);
    }

    public entry fun train_step_batch(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::Dataset, arg2: u64, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::create_rng(arg3);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training::evaluate_population_batch(arg0, arg1, arg2, &mut v0);
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::evolve_generation(arg0, &mut v0, arg4);
        let v1 = TrainStepComplete{
            population_id : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::id(arg0),
            generation    : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::generation(arg0),
            best_fitness  : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_best_fitness(arg0),
        };
        0x2::event::emit<TrainStepComplete>(v1);
    }

    // decompiled from Move bytecode v6
}

