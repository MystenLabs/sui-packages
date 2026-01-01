module 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::training {
    struct SampleKey has copy, drop, store {
        index: u64,
    }

    struct Sample has copy, drop, store {
        features: vector<u256>,
        num_features: u64,
        label: u64,
    }

    struct Dataset has store, key {
        id: 0x2::object::UID,
        num_features: u64,
        num_classes: u64,
        size: u64,
        max_size: u64,
        name: vector<u8>,
        class_counts: vector<u64>,
    }

    struct SampleResult has copy, drop, store {
        predicted: u64,
        actual: u64,
        correct: bool,
        confidence: u64,
    }

    struct EvaluationResult has copy, drop, store {
        total: u64,
        correct: u64,
        accuracy_bps: u64,
        class_accuracies: vector<u64>,
        confusion_matrix: vector<u64>,
    }

    struct TrainingConfig has copy, drop, store {
        num_generations: u64,
        eval_batch_size: u64,
        use_full_dataset: bool,
        early_stop_threshold: u64,
    }

    struct TrainingSession has store, key {
        id: 0x2::object::UID,
        population_id: 0x2::object::ID,
        dataset_id: 0x2::object::ID,
        config: TrainingConfig,
        current_generation: u64,
        target_generations: u64,
        best_accuracy: u64,
        best_generation: u64,
        history: vector<u64>,
        complete: bool,
        started_at: u64,
        ended_at: u64,
    }

    struct DatasetCreated has copy, drop {
        dataset_id: 0x2::object::ID,
        num_features: u64,
        num_classes: u64,
    }

    struct SampleAdded has copy, drop {
        dataset_id: 0x2::object::ID,
        sample_index: u64,
        label: u64,
    }

    struct EvaluationComplete has copy, drop {
        network_id: 0x2::object::ID,
        accuracy_bps: u64,
        total_samples: u64,
    }

    struct TrainingStarted has copy, drop {
        session_id: 0x2::object::ID,
        population_id: 0x2::object::ID,
        dataset_id: 0x2::object::ID,
        target_generations: u64,
    }

    struct TrainingProgress has copy, drop {
        session_id: 0x2::object::ID,
        generation: u64,
        best_accuracy: u64,
    }

    struct TrainingComplete has copy, drop {
        session_id: 0x2::object::ID,
        final_accuracy: u64,
        total_generations: u64,
    }

    public fun add_sample(arg0: &mut Dataset, arg1: vector<u256>, arg2: u64) {
        assert!(arg0.size < arg0.max_size, 500);
        assert!(arg2 < arg0.num_classes, 502);
        assert!(0x1::vector::length<u256>(&arg1) == 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_math::chunks_needed(arg0.num_features), 503);
        let v0 = Sample{
            features     : arg1,
            num_features : arg0.num_features,
            label        : arg2,
        };
        let v1 = arg0.size;
        let v2 = SampleKey{index: v1};
        0x2::dynamic_field::add<SampleKey, Sample>(&mut arg0.id, v2, v0);
        let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.class_counts, arg2);
        *v3 = *v3 + 1;
        arg0.size = arg0.size + 1;
        let v4 = SampleAdded{
            dataset_id   : 0x2::object::uid_to_inner(&arg0.id),
            sample_index : v1,
            label        : arg2,
        };
        0x2::event::emit<SampleAdded>(v4);
    }

    public fun add_sample_from_bools(arg0: &mut Dataset, arg1: &vector<bool>, arg2: u64) {
        assert!(0x1::vector::length<bool>(arg1) == arg0.num_features, 503);
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_math::create_zero_chunks(arg0.num_features);
        let v1 = 0;
        while (v1 < arg0.num_features) {
            if (*0x1::vector::borrow<bool>(arg1, v1)) {
                0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_math::set_bit(&mut v0, v1, true);
            };
            v1 = v1 + 1;
        };
        add_sample(arg0, v0, arg2);
    }

    public fun calculate_fitness(arg0: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork, arg1: &Dataset) : u64 {
        let v0 = evaluate_network(arg0, arg1);
        v0.accuracy_bps
    }

    public fun create_and_dataset(arg0: &mut 0x2::tx_context::TxContext) : Dataset {
        let v0 = create_dataset(2, 2, 4, b"AND", arg0);
        let v1 = &mut v0;
        let v2 = vector[false, false];
        add_sample_from_bools(v1, &v2, 0);
        let v3 = &mut v0;
        let v4 = vector[false, true];
        add_sample_from_bools(v3, &v4, 0);
        let v5 = &mut v0;
        let v6 = vector[true, false];
        add_sample_from_bools(v5, &v6, 0);
        let v7 = &mut v0;
        let v8 = vector[true, true];
        add_sample_from_bools(v7, &v8, 1);
        v0
    }

    public fun create_dataset(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : Dataset {
        assert!(arg0 <= 1024, 501);
        assert!(arg1 <= 64, 502);
        assert!(arg2 <= 1000, 500);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = Dataset{
            id           : 0x2::object::new(arg4),
            num_features : arg0,
            num_classes  : arg1,
            size         : 0,
            max_size     : arg2,
            name         : arg3,
            class_counts : v0,
        };
        let v3 = DatasetCreated{
            dataset_id   : 0x2::object::uid_to_inner(&v2.id),
            num_features : arg0,
            num_classes  : arg1,
        };
        0x2::event::emit<DatasetCreated>(v3);
        v2
    }

    public fun create_or_dataset(arg0: &mut 0x2::tx_context::TxContext) : Dataset {
        let v0 = create_dataset(2, 2, 4, b"OR", arg0);
        let v1 = &mut v0;
        let v2 = vector[false, false];
        add_sample_from_bools(v1, &v2, 0);
        let v3 = &mut v0;
        let v4 = vector[false, true];
        add_sample_from_bools(v3, &v4, 1);
        let v5 = &mut v0;
        let v6 = vector[true, false];
        add_sample_from_bools(v5, &v6, 1);
        let v7 = &mut v0;
        let v8 = vector[true, true];
        add_sample_from_bools(v7, &v8, 1);
        v0
    }

    public fun create_parity_dataset(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Dataset {
        assert!(arg0 <= 10, 501);
        let v0 = 1 << (arg0 as u8);
        let v1 = create_dataset(arg0, 2, v0, b"PARITY", arg1);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::empty<bool>();
            let v4 = 0;
            let v5 = 0;
            while (v5 < arg0) {
                let v6 = v2 >> (v5 as u8) & 1 == 1;
                0x1::vector::push_back<bool>(&mut v3, v6);
                if (v6) {
                    v4 = v4 + 1;
                };
                v5 = v5 + 1;
            };
            let v7 = &mut v1;
            add_sample_from_bools(v7, &v3, v4 % 2);
            v2 = v2 + 1;
        };
        v1
    }

    public fun create_training_config(arg0: u64, arg1: u64, arg2: bool, arg3: u64) : TrainingConfig {
        TrainingConfig{
            num_generations      : arg0,
            eval_batch_size      : arg1,
            use_full_dataset     : arg2,
            early_stop_threshold : arg3,
        }
    }

    public fun create_training_session(arg0: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: &Dataset, arg2: TrainingConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : TrainingSession {
        let v0 = TrainingSession{
            id                 : 0x2::object::new(arg4),
            population_id      : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::id(arg0),
            dataset_id         : 0x2::object::uid_to_inner(&arg1.id),
            config             : arg2,
            current_generation : 0,
            target_generations : arg2.num_generations,
            best_accuracy      : 0,
            best_generation    : 0,
            history            : 0x1::vector::empty<u64>(),
            complete           : false,
            started_at         : 0x2::clock::timestamp_ms(arg3),
            ended_at           : 0,
        };
        let v1 = TrainingStarted{
            session_id         : 0x2::object::uid_to_inner(&v0.id),
            population_id      : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::id(arg0),
            dataset_id         : 0x2::object::uid_to_inner(&arg1.id),
            target_generations : arg2.num_generations,
        };
        0x2::event::emit<TrainingStarted>(v1);
        v0
    }

    public fun create_xor_dataset(arg0: &mut 0x2::tx_context::TxContext) : Dataset {
        let v0 = create_dataset(2, 2, 4, b"XOR", arg0);
        let v1 = &mut v0;
        let v2 = vector[false, false];
        add_sample_from_bools(v1, &v2, 0);
        let v3 = &mut v0;
        let v4 = vector[false, true];
        add_sample_from_bools(v3, &v4, 1);
        let v5 = &mut v0;
        let v6 = vector[true, false];
        add_sample_from_bools(v5, &v6, 1);
        let v7 = &mut v0;
        let v8 = vector[true, true];
        add_sample_from_bools(v7, &v8, 0);
        v0
    }

    public fun dataset_class_counts(arg0: &Dataset) : vector<u64> {
        arg0.class_counts
    }

    public fun dataset_id(arg0: &Dataset) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun dataset_name(arg0: &Dataset) : vector<u8> {
        arg0.name
    }

    public fun dataset_num_classes(arg0: &Dataset) : u64 {
        arg0.num_classes
    }

    public fun dataset_num_features(arg0: &Dataset) : u64 {
        arg0.num_features
    }

    public fun dataset_size(arg0: &Dataset) : u64 {
        arg0.size
    }

    public fun default_training_config() : TrainingConfig {
        TrainingConfig{
            num_generations      : 100,
            eval_batch_size      : 100,
            use_full_dataset     : false,
            early_stop_threshold : 9500,
        }
    }

    public fun destroy_dataset(arg0: Dataset) {
        let v0 = 0;
        while (v0 < arg0.size) {
            let v1 = SampleKey{index: v0};
            0x2::dynamic_field::remove<SampleKey, Sample>(&mut arg0.id, v1);
            v0 = v0 + 1;
        };
        let Dataset {
            id           : v2,
            num_features : _,
            num_classes  : _,
            size         : _,
            max_size     : _,
            name         : _,
            class_counts : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun destroy_session(arg0: TrainingSession) {
        let TrainingSession {
            id                 : v0,
            population_id      : _,
            dataset_id         : _,
            config             : _,
            current_generation : _,
            target_generations : _,
            best_accuracy      : _,
            best_generation    : _,
            history            : _,
            complete           : _,
            started_at         : _,
            ended_at           : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun evaluate_network(arg0: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork, arg1: &Dataset) : EvaluationResult {
        assert!(arg1.size > 0, 504);
        assert!(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::input_size(arg0) == arg1.num_features, 503);
        assert!(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::output_size(arg0) == arg1.num_classes, 503);
        let v0 = 0;
        let v1 = arg1.num_classes;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < v1 * v1) {
            0x1::vector::push_back<u64>(&mut v2, 0);
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        while (v5 < v1) {
            0x1::vector::push_back<u64>(&mut v4, 0);
            v5 = v5 + 1;
        };
        let v6 = 0;
        while (v6 < arg1.size) {
            let v7 = get_sample(arg1, v6);
            let v8 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::predict_class(arg0, sample_to_activation(&v7));
            let v9 = v7.label;
            let v10 = 0x1::vector::borrow_mut<u64>(&mut v2, v9 * v1 + v8);
            *v10 = *v10 + 1;
            if (v8 == v9) {
                v0 = v0 + 1;
                let v11 = 0x1::vector::borrow_mut<u64>(&mut v4, v9);
                *v11 = *v11 + 1;
            };
            v6 = v6 + 1;
        };
        let v12 = 0x1::vector::empty<u64>();
        let v13 = 0;
        while (v13 < v1) {
            let v14 = *0x1::vector::borrow<u64>(&arg1.class_counts, v13);
            let v15 = if (v14 > 0) {
                *0x1::vector::borrow<u64>(&v4, v13) * 10000 / v14
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v12, v15);
            v13 = v13 + 1;
        };
        let v16 = v0 * 10000 / arg1.size;
        let v17 = EvaluationComplete{
            network_id    : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::id(arg0),
            accuracy_bps  : v16,
            total_samples : arg1.size,
        };
        0x2::event::emit<EvaluationComplete>(v17);
        EvaluationResult{
            total            : arg1.size,
            correct          : v0,
            accuracy_bps     : v16,
            class_accuracies : v12,
            confusion_matrix : v2,
        }
    }

    public fun evaluate_network_batch(arg0: &0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::BinaryNetwork, arg1: &Dataset, arg2: u64, arg3: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::RNG) : EvaluationResult {
        assert!(arg1.size > 0, 504);
        assert!(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::input_size(arg0) == arg1.num_features, 503);
        let v0 = if (arg2 > arg1.size) {
            arg1.size
        } else {
            arg2
        };
        let v1 = 0;
        let v2 = arg1.num_classes;
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < v2 * v2) {
            0x1::vector::push_back<u64>(&mut v3, 0);
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        while (v7 < v2) {
            0x1::vector::push_back<u64>(&mut v5, 0);
            0x1::vector::push_back<u64>(&mut v6, 0);
            v7 = v7 + 1;
        };
        let v8 = 0;
        while (v8 < v0) {
            let v9 = get_sample(arg1, 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::next_u64_range(arg3, arg1.size));
            let v10 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_network::predict_class(arg0, sample_to_activation(&v9));
            let v11 = v9.label;
            let v12 = 0x1::vector::borrow_mut<u64>(&mut v3, v11 * v2 + v10);
            *v12 = *v12 + 1;
            let v13 = 0x1::vector::borrow_mut<u64>(&mut v6, v11);
            *v13 = *v13 + 1;
            if (v10 == v11) {
                v1 = v1 + 1;
                let v14 = 0x1::vector::borrow_mut<u64>(&mut v5, v11);
                *v14 = *v14 + 1;
            };
            v8 = v8 + 1;
        };
        let v15 = 0x1::vector::empty<u64>();
        let v16 = 0;
        while (v16 < v2) {
            let v17 = *0x1::vector::borrow<u64>(&v6, v16);
            let v18 = if (v17 > 0) {
                *0x1::vector::borrow<u64>(&v5, v16) * 10000 / v17
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v15, v18);
            v16 = v16 + 1;
        };
        EvaluationResult{
            total            : v0,
            correct          : v1,
            accuracy_bps     : v1 * 10000 / v0,
            class_accuracies : v15,
            confusion_matrix : v3,
        }
    }

    public fun evaluate_population(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: &Dataset) {
        let v0 = 0;
        while (v0 < 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::size(arg0)) {
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::set_fitness(arg0, v0, calculate_fitness(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_individual(arg0, v0), arg1));
            v0 = v0 + 1;
        };
    }

    public fun evaluate_population_batch(arg0: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg1: &Dataset, arg2: u64, arg3: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::RNG) {
        let v0 = 0;
        while (v0 < 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::size(arg0)) {
            let v1 = evaluate_network_batch(0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_individual(arg0, v0), arg1, arg2, arg3);
            0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::set_fitness(arg0, v0, v1.accuracy_bps);
            v0 = v0 + 1;
        };
    }

    public fun get_sample(arg0: &Dataset, arg1: u64) : Sample {
        assert!(arg1 < arg0.size, 505);
        let v0 = SampleKey{index: arg1};
        *0x2::dynamic_field::borrow<SampleKey, Sample>(&arg0.id, v0)
    }

    public fun result_accuracy(arg0: &EvaluationResult) : u64 {
        arg0.accuracy_bps
    }

    public fun result_class_accuracies(arg0: &EvaluationResult) : vector<u64> {
        arg0.class_accuracies
    }

    public fun result_confusion(arg0: &EvaluationResult) : vector<u64> {
        arg0.confusion_matrix
    }

    public fun result_correct(arg0: &EvaluationResult) : u64 {
        arg0.correct
    }

    public fun result_total(arg0: &EvaluationResult) : u64 {
        arg0.total
    }

    public fun sample_to_activation(arg0: &Sample) : 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_layer::BinaryActivation {
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::binary_layer::create_activation(arg0.features, arg0.num_features)
    }

    public fun session_best_accuracy(arg0: &TrainingSession) : u64 {
        arg0.best_accuracy
    }

    public fun session_best_gen(arg0: &TrainingSession) : u64 {
        arg0.best_generation
    }

    public fun session_complete(arg0: &TrainingSession) : bool {
        arg0.complete
    }

    public fun session_current_gen(arg0: &TrainingSession) : u64 {
        arg0.current_generation
    }

    public fun session_history(arg0: &TrainingSession) : vector<u64> {
        arg0.history
    }

    public fun share_dataset(arg0: Dataset) {
        0x2::transfer::share_object<Dataset>(arg0);
    }

    public fun train_step(arg0: &mut TrainingSession, arg1: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::Population, arg2: &Dataset, arg3: &mut 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::evolution::RNG, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        if (arg0.complete) {
            return false
        };
        if (arg0.config.use_full_dataset) {
            evaluate_population(arg1, arg2);
        } else {
            evaluate_population_batch(arg1, arg2, arg0.config.eval_batch_size, arg3);
        };
        let v0 = 0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::get_best_fitness(arg1);
        0x1::vector::push_back<u64>(&mut arg0.history, v0);
        if (v0 > arg0.best_accuracy) {
            arg0.best_accuracy = v0;
            arg0.best_generation = arg0.current_generation;
        };
        let v1 = TrainingProgress{
            session_id    : 0x2::object::uid_to_inner(&arg0.id),
            generation    : arg0.current_generation,
            best_accuracy : arg0.best_accuracy,
        };
        0x2::event::emit<TrainingProgress>(v1);
        if (arg0.best_accuracy >= arg0.config.early_stop_threshold) {
            arg0.complete = true;
            arg0.ended_at = 0x2::clock::timestamp_ms(arg4);
            let v2 = TrainingComplete{
                session_id        : 0x2::object::uid_to_inner(&arg0.id),
                final_accuracy    : arg0.best_accuracy,
                total_generations : arg0.current_generation,
            };
            0x2::event::emit<TrainingComplete>(v2);
            return false
        };
        0xe5fdf637c9552e552a040cd9b9d0b768ef33f5a5c7074dd322cf69437782df4f::population::evolve_generation(arg1, arg3, arg5);
        arg0.current_generation = arg0.current_generation + 1;
        if (arg0.current_generation >= arg0.target_generations) {
            arg0.complete = true;
            arg0.ended_at = 0x2::clock::timestamp_ms(arg4);
            let v3 = TrainingComplete{
                session_id        : 0x2::object::uid_to_inner(&arg0.id),
                final_accuracy    : arg0.best_accuracy,
                total_generations : arg0.current_generation,
            };
            0x2::event::emit<TrainingComplete>(v3);
            return false
        };
        true
    }

    public fun transfer_dataset(arg0: Dataset, arg1: address) {
        0x2::transfer::transfer<Dataset>(arg0, arg1);
    }

    public fun transfer_session(arg0: TrainingSession, arg1: address) {
        0x2::transfer::transfer<TrainingSession>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

