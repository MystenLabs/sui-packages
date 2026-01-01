module 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::evolution {
    struct RNG has copy, drop, store {
        state: u256,
    }

    struct EvolutionConfig has copy, drop, store {
        mutation_count: u64,
        tournament_size: u64,
        use_crossover: bool,
        elite_count: u64,
    }

    struct EvolutionRecord has store, key {
        id: 0x2::object::UID,
        network_id: 0x2::object::ID,
        generation_before: u64,
        generation_after: u64,
        mutations_applied: u64,
        fitness_before: u64,
        fitness_after: 0x1::option::Option<u64>,
        crossover_parent: 0x1::option::Option<0x2::object::ID>,
        timestamp: u64,
    }

    struct MutationApplied has copy, drop {
        network_id: 0x2::object::ID,
        layer_index: u64,
        neuron_index: u64,
        weight_index: u64,
    }

    struct CrossoverPerformed has copy, drop {
        parent1_id: 0x2::object::ID,
        parent2_id: 0x2::object::ID,
        child_id: 0x2::object::ID,
        crossover_points: u64,
    }

    struct SelectionPerformed has copy, drop {
        winner_id: 0x2::object::ID,
        winner_fitness: u64,
        tournament_size: u64,
    }

    public fun config_elite_count(arg0: &EvolutionConfig) : u64 {
        arg0.elite_count
    }

    public fun config_mutation_count(arg0: &EvolutionConfig) : u64 {
        arg0.mutation_count
    }

    public fun config_tournament_size(arg0: &EvolutionConfig) : u64 {
        arg0.tournament_size
    }

    public fun config_use_crossover(arg0: &EvolutionConfig) : bool {
        arg0.use_crossover
    }

    public fun create_config(arg0: u64, arg1: u64, arg2: bool, arg3: u64) : EvolutionConfig {
        assert!(arg0 <= 100, 301);
        EvolutionConfig{
            mutation_count  : arg0,
            tournament_size : arg1,
            use_crossover   : arg2,
            elite_count     : arg3,
        }
    }

    public fun create_record(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : EvolutionRecord {
        EvolutionRecord{
            id                : 0x2::object::new(arg7),
            network_id        : arg0,
            generation_before : arg1,
            generation_after  : arg2,
            mutations_applied : arg3,
            fitness_before    : arg4,
            fitness_after     : 0x1::option::none<u64>(),
            crossover_parent  : arg5,
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        }
    }

    public fun create_rng(arg0: u256) : RNG {
        RNG{state: arg0}
    }

    public fun create_rng_from_clock(arg0: &0x2::clock::Clock) : RNG {
        RNG{state: (0x2::clock::timestamp_ms(arg0) as u256) * 6364136223846793005 + 1442695040888963407}
    }

    public fun crossover_single_point(arg0: &0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork, arg1: &0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork, arg2: vector<u8>, arg3: &mut RNG, arg4: &mut 0x2::tx_context::TxContext) : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork {
        assert!(0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::architecture(arg0) == 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::architecture(arg1), 300);
        let v0 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::clone_network(arg0, arg2, arg4);
        let v1 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::num_layers(&v0);
        let v2 = next_u64_range(arg3, v1);
        while (v2 < v1) {
            let v3 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::get_layer(arg1, v2);
            let v4 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::get_layer_mut(&mut v0, v2);
            let v5 = 0;
            while (v5 < 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::output_size(v3)) {
                0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::set_neuron_weights(v4, v5, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::get_neuron_weights(v3, v5));
                0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::set_threshold(v4, v5, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::get_threshold(v3, v5));
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
        };
        0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::set_parent(&mut v0, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::id(arg0));
        let v6 = CrossoverPerformed{
            parent1_id       : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::id(arg0),
            parent2_id       : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::id(arg1),
            child_id         : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::id(&v0),
            crossover_points : 1,
        };
        0x2::event::emit<CrossoverPerformed>(v6);
        v0
    }

    public fun crossover_uniform(arg0: &0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork, arg1: &0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork, arg2: vector<u8>, arg3: &mut RNG, arg4: &mut 0x2::tx_context::TxContext) : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork {
        assert!(0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::architecture(arg0) == 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::architecture(arg1), 300);
        let v0 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::clone_network(arg0, arg2, arg4);
        let v1 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::num_layers(&v0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::get_layer(arg0, v2);
            let v4 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::get_layer(arg1, v2);
            let v5 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::get_layer_mut(&mut v0, v2);
            0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::input_size(v3);
            let v6 = 0;
            while (v6 < 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::output_size(v3)) {
                if (next_bool_prob(arg3, 5000)) {
                    0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::set_neuron_weights(v5, v6, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::get_neuron_weights(v4, v6));
                    0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::set_threshold(v5, v6, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::get_threshold(v4, v6));
                };
                v6 = v6 + 1;
            };
            v2 = v2 + 1;
        };
        0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::set_parent(&mut v0, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::id(arg0));
        let v7 = CrossoverPerformed{
            parent1_id       : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::id(arg0),
            parent2_id       : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::id(arg1),
            child_id         : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::id(&v0),
            crossover_points : v1,
        };
        0x2::event::emit<CrossoverPerformed>(v7);
        v0
    }

    public fun default_config() : EvolutionConfig {
        EvolutionConfig{
            mutation_count  : 10,
            tournament_size : 3,
            use_crossover   : true,
            elite_count     : 2,
        }
    }

    public fun destroy_record(arg0: EvolutionRecord) {
        let EvolutionRecord {
            id                : v0,
            network_id        : _,
            generation_before : _,
            generation_after  : _,
            mutations_applied : _,
            fitness_before    : _,
            fitness_after     : _,
            crossover_parent  : _,
            timestamp         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun generate_mutations(arg0: &0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork, arg1: u64, arg2: &mut RNG) : vector<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::Mutation> {
        let v0 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::architecture(arg0);
        let v1 = 0x1::vector::empty<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::Mutation>();
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = next_u64_range(arg2, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::num_layers(arg0));
            let v4 = next_u64_range(arg2, *0x1::vector::borrow<u64>(&v0, v3 + 1));
            0x1::vector::push_back<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::Mutation>(&mut v1, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::create_mutation(v3, v4, next_u64_range(arg2, *0x1::vector::borrow<u64>(&v0, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun mutate_network(arg0: &mut 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork, arg1: u64, arg2: &mut RNG) {
        let v0 = generate_mutations(arg0, arg1, arg2);
        0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::apply_mutations(arg0, &v0);
    }

    public fun mutate_network_targeted(arg0: &mut 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::BinaryNetwork, arg1: u64, arg2: &vector<u64>, arg3: &mut RNG) {
        let v0 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::architecture(arg0);
        let v1 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::num_layers(arg0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(arg2, v3);
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::Mutation>();
        let v5 = 0;
        while (v5 < arg1) {
            let v6 = next_u64_range(arg3, v2);
            let v7 = 0;
            let v8 = 0;
            let v9 = 0;
            while (v9 < v1) {
                v7 = v7 + *0x1::vector::borrow<u64>(arg2, v9);
                if (v6 < v7) {
                    v8 = v9;
                    break
                };
                v9 = v9 + 1;
            };
            let v10 = next_u64_range(arg3, *0x1::vector::borrow<u64>(&v0, v8 + 1));
            0x1::vector::push_back<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::Mutation>(&mut v4, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::create_mutation(v8, v10, next_u64_range(arg3, *0x1::vector::borrow<u64>(&v0, v8))));
            v5 = v5 + 1;
        };
        0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network::apply_mutations(arg0, &v4);
    }

    public fun next_bool_prob(arg0: &mut RNG, arg1: u64) : bool {
        next_u64_range(arg0, 10000) < arg1
    }

    public fun next_u256(arg0: &mut RNG) : u256 {
        arg0.state = arg0.state * 6364136223846793005 + 1442695040888963407;
        arg0.state
    }

    public fun next_u64_range(arg0: &mut RNG, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        ((next_u256(arg0) % (arg1 as u256)) as u64)
    }

    public fun rank_select(arg0: &vector<u64>, arg1: &mut RNG) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u64>(&mut v1, v2);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < v0) {
            let v4 = v3 + 1;
            while (v4 < v0) {
                if (*0x1::vector::borrow<u64>(arg0, *0x1::vector::borrow<u64>(&v1, v4)) > *0x1::vector::borrow<u64>(arg0, *0x1::vector::borrow<u64>(&v1, v3))) {
                    *0x1::vector::borrow_mut<u64>(&mut v1, v3) = *0x1::vector::borrow<u64>(&v1, v4);
                    *0x1::vector::borrow_mut<u64>(&mut v1, v4) = *0x1::vector::borrow<u64>(&v1, v3);
                };
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < v0) {
            v5 = v5 + v0 - v6;
            if (next_u64_range(arg1, v0 * (v0 + 1) / 2) < v5) {
                return *0x1::vector::borrow<u64>(&v1, v6)
            };
            v6 = v6 + 1;
        };
        *0x1::vector::borrow<u64>(&v1, v0 - 1)
    }

    public fun roulette_select(arg0: &vector<u64>, arg1: &mut RNG) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v2);
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return next_u64_range(arg1, v0)
        };
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = v3 + *0x1::vector::borrow<u64>(arg0, v4);
            v3 = v5;
            if (next_u64_range(arg1, v1) < v5) {
                return v4
            };
            v4 = v4 + 1;
        };
        v0 - 1
    }

    public fun tournament_select(arg0: &vector<u64>, arg1: u64, arg2: &mut RNG) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(arg1 >= 2, 302);
        assert!(arg1 <= v0, 302);
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0;
        while (v4 < arg1) {
            let v5 = next_u64_range(arg2, v0);
            let v6 = *0x1::vector::borrow<u64>(arg0, v5);
            if (v6 > v2 || v4 == 0) {
                v3 = v6;
                v1 = v5;
            };
            v4 = v4 + 1;
        };
        let v7 = SelectionPerformed{
            winner_id       : 0x2::object::id_from_address(@0x0),
            winner_fitness  : v3,
            tournament_size : arg1,
        };
        0x2::event::emit<SelectionPerformed>(v7);
        v1
    }

    public fun transfer_record(arg0: EvolutionRecord, arg1: address) {
        0x2::transfer::transfer<EvolutionRecord>(arg0, arg1);
    }

    public fun update_record_fitness(arg0: &mut EvolutionRecord, arg1: u64) {
        arg0.fitness_after = 0x1::option::some<u64>(arg1);
    }

    // decompiled from Move bytecode v6
}

