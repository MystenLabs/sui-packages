module 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population {
    struct IndividualKey has copy, drop, store {
        index: u64,
    }

    struct Population has store, key {
        id: 0x2::object::UID,
        architecture: vector<u64>,
        size: u64,
        max_size: u64,
        generation: u64,
        fitness_scores: vector<u64>,
        best_fitness_ever: u64,
        best_individual_idx: u64,
        config: 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::EvolutionConfig,
        name: vector<u8>,
        total_evaluations: u64,
    }

    struct PopulationStats has copy, drop, store {
        size: u64,
        generation: u64,
        best_fitness: u64,
        worst_fitness: u64,
        average_fitness: u64,
        fitness_std_dev: u64,
        total_evaluations: u64,
    }

    struct GenerationSummary has copy, drop, store {
        generation: u64,
        best_fitness: u64,
        worst_fitness: u64,
        average_fitness: u64,
        improvements: u64,
    }

    struct PopulationCreated has copy, drop {
        population_id: 0x2::object::ID,
        architecture: vector<u64>,
        max_size: u64,
    }

    struct GenerationComplete has copy, drop {
        population_id: 0x2::object::ID,
        generation: u64,
        best_fitness: u64,
        average_fitness: u64,
    }

    struct NewBestFound has copy, drop {
        population_id: 0x2::object::ID,
        network_id: 0x2::object::ID,
        fitness: u64,
        generation: u64,
    }

    struct IndividualAdded has copy, drop {
        population_id: 0x2::object::ID,
        network_id: 0x2::object::ID,
        index: u64,
    }

    public fun architecture(arg0: &Population) : vector<u64> {
        arg0.architecture
    }

    public fun id(arg0: &Population) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun add_individual(arg0: &mut Population, arg1: 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork) {
        assert!(arg0.size < arg0.max_size, 400);
        assert!(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::architecture(&arg1) == arg0.architecture, 403);
        let v0 = arg0.size;
        let v1 = IndividualKey{index: v0};
        0x2::dynamic_object_field::add<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v1, arg1);
        0x1::vector::push_back<u64>(&mut arg0.fitness_scores, 0);
        arg0.size = arg0.size + 1;
        let v2 = IndividualAdded{
            population_id : 0x2::object::uid_to_inner(&arg0.id),
            network_id    : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::id(&arg1),
            index         : v0,
        };
        0x2::event::emit<IndividualAdded>(v2);
    }

    public fun best_fitness_ever(arg0: &Population) : u64 {
        arg0.best_fitness_ever
    }

    public fun config(arg0: &Population) : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::EvolutionConfig {
        arg0.config
    }

    public fun create_population(arg0: vector<u64>, arg1: u64, arg2: vector<u8>, arg3: 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::EvolutionConfig, arg4: &mut 0x2::tx_context::TxContext) : Population {
        assert!(arg1 <= 100, 400);
        let v0 = Population{
            id                  : 0x2::object::new(arg4),
            architecture        : arg0,
            size                : 0,
            max_size            : arg1,
            generation          : 0,
            fitness_scores      : 0x1::vector::empty<u64>(),
            best_fitness_ever   : 0,
            best_individual_idx : 0,
            config              : arg3,
            name                : arg2,
            total_evaluations   : 0,
        };
        let v1 = PopulationCreated{
            population_id : 0x2::object::uid_to_inner(&v0.id),
            architecture  : v0.architecture,
            max_size      : arg1,
        };
        0x2::event::emit<PopulationCreated>(v1);
        v0
    }

    public fun create_population_random(arg0: vector<u64>, arg1: u64, arg2: vector<u8>, arg3: 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::EvolutionConfig, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) : Population {
        let v0 = create_population(arg0, arg1, arg2, arg3, arg5);
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = arg4 * 6364136223846793005 + 1442695040888963407;
            arg4 = v2;
            let v3 = b"individual_";
            0x1::vector::append<u8>(&mut v3, u64_to_bytes(v1));
            let v4 = &mut v0;
            add_individual(v4, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::create_network_random(v0.architecture, v3, v2, arg5));
            v1 = v1 + 1;
        };
        v0
    }

    public fun destroy_population(arg0: Population) {
        let v0 = 0;
        while (v0 < arg0.size) {
            let v1 = IndividualKey{index: v0};
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::destroy_network(0x2::dynamic_object_field::remove<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v1));
            v0 = v0 + 1;
        };
        let Population {
            id                  : v2,
            architecture        : _,
            size                : _,
            max_size            : _,
            generation          : _,
            fitness_scores      : _,
            best_fitness_ever   : _,
            best_individual_idx : _,
            config              : _,
            name                : _,
            total_evaluations   : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun evolve_generation(arg0: &mut Population, arg1: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::RNG, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.size >= 2, 404);
        let v0 = arg0.config;
        let v1 = arg0.size;
        let v2 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::config_elite_count(&v0);
        let v3 = find_top_n(&arg0.fitness_scores, v2);
        let v4 = 0x1::vector::empty<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>();
        let v5 = 0;
        while (v5 < v2 && v5 < 0x1::vector::length<u64>(&v3)) {
            let v6 = b"elite_gen";
            0x1::vector::append<u8>(&mut v6, u64_to_bytes(arg0.generation + 1));
            0x1::vector::append<u8>(&mut v6, b"_");
            0x1::vector::append<u8>(&mut v6, u64_to_bytes(v5));
            0x1::vector::push_back<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut v4, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::clone_network(get_individual(arg0, *0x1::vector::borrow<u64>(&v3, v5)), v6, arg2));
            v5 = v5 + 1;
        };
        let v7 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::config_tournament_size(&v0);
        while (0x1::vector::length<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&v4) < v1) {
            let v8 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::tournament_select(&arg0.fitness_scores, v7, arg1);
            let v9 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::tournament_select(&arg0.fitness_scores, v7, arg1);
            let v10 = b"child_gen";
            0x1::vector::append<u8>(&mut v10, u64_to_bytes(arg0.generation + 1));
            0x1::vector::append<u8>(&mut v10, b"_");
            0x1::vector::append<u8>(&mut v10, u64_to_bytes(0x1::vector::length<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&v4)));
            let v11 = if (0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::config_use_crossover(&v0) && v8 != v9) {
                0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::crossover_uniform(get_individual(arg0, v8), get_individual(arg0, v9), v10, arg1, arg2)
            } else {
                0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::clone_network(get_individual(arg0, v8), v10, arg2)
            };
            let v12 = v11;
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::mutate_network(&mut v12, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::config_mutation_count(&v0), arg1);
            0x1::vector::push_back<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut v4, v12);
        };
        let v13 = 0;
        while (v13 < v1) {
            let v14 = IndividualKey{index: v13};
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::destroy_network(0x2::dynamic_object_field::remove<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v14));
            v13 = v13 + 1;
        };
        arg0.size = 0;
        arg0.fitness_scores = 0x1::vector::empty<u64>();
        let v15 = 0;
        while (v15 < 0x1::vector::length<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&v4)) {
            let v16 = IndividualKey{index: arg0.size};
            0x2::dynamic_object_field::add<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v16, 0x1::vector::pop_back<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut v4));
            0x1::vector::push_back<u64>(&mut arg0.fitness_scores, 0);
            arg0.size = arg0.size + 1;
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(v4);
        arg0.generation = arg0.generation + 1;
        arg0.best_individual_idx = 0;
        let v17 = GenerationComplete{
            population_id   : 0x2::object::uid_to_inner(&arg0.id),
            generation      : arg0.generation,
            best_fitness    : arg0.best_fitness_ever,
            average_fitness : 0,
        };
        0x2::event::emit<GenerationComplete>(v17);
    }

    fun find_top_n(arg0: &vector<u64>, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = if (arg1 > v0) {
            v0
        } else {
            arg1
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0;
        while (v4 < v0) {
            0x1::vector::push_back<bool>(&mut v3, false);
            v4 = v4 + 1;
        };
        let v5 = 0;
        while (v5 < v1) {
            let v6 = 0;
            let v7 = false;
            let v8 = 0;
            while (v8 < v0) {
                if (!*0x1::vector::borrow<bool>(&v3, v8)) {
                    if (!v7 || *0x1::vector::borrow<u64>(arg0, v8) > 0) {
                        v7 = true;
                    };
                };
                v8 = v8 + 1;
            };
            if (v7) {
                0x1::vector::push_back<u64>(&mut v2, v6);
                *0x1::vector::borrow_mut<bool>(&mut v3, v6) = true;
                v5 = v5 + 1;
            } else {
                break
            };
        };
        v2
    }

    public fun generation(arg0: &Population) : u64 {
        arg0.generation
    }

    public fun get_all_fitness(arg0: &Population) : vector<u64> {
        arg0.fitness_scores
    }

    public fun get_best_fitness(arg0: &Population) : u64 {
        if (arg0.size == 0) {
            return 0
        };
        *0x1::vector::borrow<u64>(&arg0.fitness_scores, arg0.best_individual_idx)
    }

    public fun get_best_individual(arg0: &Population) : &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork {
        assert!(arg0.size > 0, 401);
        get_individual(arg0, arg0.best_individual_idx)
    }

    public fun get_fitness(arg0: &Population, arg1: u64) : u64 {
        assert!(arg1 < arg0.size, 402);
        *0x1::vector::borrow<u64>(&arg0.fitness_scores, arg1)
    }

    public fun get_individual(arg0: &Population, arg1: u64) : &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork {
        assert!(arg1 < arg0.size, 402);
        let v0 = IndividualKey{index: arg1};
        0x2::dynamic_object_field::borrow<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&arg0.id, v0)
    }

    public fun get_individual_mut(arg0: &mut Population, arg1: u64) : &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork {
        assert!(arg1 < arg0.size, 402);
        let v0 = IndividualKey{index: arg1};
        0x2::dynamic_object_field::borrow_mut<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v0)
    }

    public fun get_stats(arg0: &Population) : PopulationStats {
        let v0 = arg0.size;
        if (v0 == 0) {
            return PopulationStats{
                size              : 0,
                generation        : arg0.generation,
                best_fitness      : 0,
                worst_fitness     : 0,
                average_fitness   : 0,
                fitness_std_dev   : 0,
                total_evaluations : arg0.total_evaluations,
            }
        };
        let v1 = 0;
        let v2 = v1;
        let v3 = 18446744073709551615;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<u64>(&arg0.fitness_scores, v6);
            if (v7 > v1) {
                v2 = v7;
            };
            if (v7 < v3) {
                v4 = v7;
            };
            v5 = v5 + (v7 as u128);
            v6 = v6 + 1;
        };
        let v8 = ((v5 / (v0 as u128)) as u64);
        let v9 = 0;
        let v10 = 0;
        while (v10 < v0) {
            let v11 = *0x1::vector::borrow<u64>(&arg0.fitness_scores, v10);
            let v12 = if (v11 > v8) {
                v11 - v8
            } else {
                v8 - v11
            };
            v9 = v9 + (v12 as u128) * (v12 as u128);
            v10 = v10 + 1;
        };
        PopulationStats{
            size              : v0,
            generation        : arg0.generation,
            best_fitness      : v2,
            worst_fitness     : v4,
            average_fitness   : v8,
            fitness_std_dev   : (sqrt_u128(v9 / (v0 as u128)) as u64),
            total_evaluations : arg0.total_evaluations,
        }
    }

    public fun max_size(arg0: &Population) : u64 {
        arg0.max_size
    }

    public fun name(arg0: &Population) : vector<u8> {
        arg0.name
    }

    public fun remove_individual(arg0: &mut Population, arg1: u64) : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork {
        assert!(arg1 < arg0.size, 402);
        0x1::vector::remove<u64>(&mut arg0.fitness_scores, arg1);
        let v0 = IndividualKey{index: arg1};
        while (arg1 < arg0.size - 1) {
            let v1 = IndividualKey{index: arg1 + 1};
            let v2 = IndividualKey{index: arg1};
            0x2::dynamic_object_field::add<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v2, 0x2::dynamic_object_field::remove<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v1));
            arg1 = arg1 + 1;
        };
        arg0.size = arg0.size - 1;
        if (arg0.best_individual_idx >= arg0.size && arg0.size > 0) {
            arg0.best_individual_idx = arg0.size - 1;
        };
        0x2::dynamic_object_field::remove<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v0)
    }

    public fun replace_individual(arg0: &mut Population, arg1: u64, arg2: 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork) : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork {
        assert!(arg1 < arg0.size, 402);
        assert!(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::architecture(&arg2) == arg0.architecture, 403);
        let v0 = IndividualKey{index: arg1};
        let v1 = IndividualKey{index: arg1};
        0x2::dynamic_object_field::add<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v1, arg2);
        *0x1::vector::borrow_mut<u64>(&mut arg0.fitness_scores, arg1) = 0;
        0x2::dynamic_object_field::remove<IndividualKey, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork>(&mut arg0.id, v0)
    }

    public fun set_fitness(arg0: &mut Population, arg1: u64, arg2: u64) {
        assert!(arg1 < arg0.size, 402);
        *0x1::vector::borrow_mut<u64>(&mut arg0.fitness_scores, arg1) = arg2;
        arg0.total_evaluations = arg0.total_evaluations + 1;
        if (arg2 > arg0.best_fitness_ever) {
            arg0.best_fitness_ever = arg2;
            arg0.best_individual_idx = arg1;
            let v0 = NewBestFound{
                population_id : 0x2::object::uid_to_inner(&arg0.id),
                network_id    : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::id(get_individual(arg0, arg1)),
                fitness       : arg2,
                generation    : arg0.generation,
            };
            0x2::event::emit<NewBestFound>(v0);
        };
        if (arg2 > *0x1::vector::borrow<u64>(&arg0.fitness_scores, arg0.best_individual_idx)) {
            arg0.best_individual_idx = arg1;
        };
    }

    public fun share_population(arg0: Population) {
        0x2::transfer::share_object<Population>(arg0);
    }

    public fun size(arg0: &Population) : u64 {
        arg0.size
    }

    fun sqrt_u128(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun transfer_population(arg0: Population, arg1: address) {
        0x2::transfer::transfer<Population>(arg0, arg1);
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        v1
    }

    // decompiled from Move bytecode v6
}

