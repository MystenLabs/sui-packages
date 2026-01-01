module 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_network {
    struct LayerKey has copy, drop, store {
        index: u64,
    }

    struct BinaryNetwork has store, key {
        id: 0x2::object::UID,
        architecture: vector<u64>,
        num_layers: u64,
        total_params: u64,
        generation: u64,
        fitness: u64,
        parent_id: 0x1::option::Option<0x2::object::ID>,
        created_at: u64,
        name: vector<u8>,
    }

    struct InferenceResult has copy, drop, store {
        output: 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation,
        raw_output: 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::RawActivation,
        layer_activations: vector<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation>,
    }

    struct NetworkStats has copy, drop, store {
        architecture: vector<u64>,
        total_params: u64,
        layer_sparsities: vector<u64>,
        generation: u64,
        fitness: u64,
    }

    struct NetworkCreated has copy, drop {
        network_id: 0x2::object::ID,
        architecture: vector<u64>,
        total_params: u64,
        generation: u64,
    }

    struct InferenceCompleted has copy, drop {
        network_id: 0x2::object::ID,
        input_hash: u256,
        output_class: u64,
        confidence: u64,
    }

    struct NetworkMutated has copy, drop {
        network_id: 0x2::object::ID,
        mutations_applied: u64,
        new_generation: u64,
    }

    struct Mutation has copy, drop, store {
        layer_index: u64,
        neuron_index: u64,
        weight_index: u64,
    }

    public fun flip_weight(arg0: &mut BinaryNetwork, arg1: u64, arg2: u64, arg3: u64) {
        0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::flip_weight(get_layer_mut(arg0, arg1), arg2, arg3);
    }

    public fun input_size(arg0: &BinaryNetwork) : u64 {
        *0x1::vector::borrow<u64>(&arg0.architecture, 0)
    }

    public fun output_size(arg0: &BinaryNetwork) : u64 {
        *0x1::vector::borrow<u64>(&arg0.architecture, arg0.num_layers)
    }

    public fun apply_mutations(arg0: &mut BinaryNetwork, arg1: &vector<Mutation>) {
        let v0 = 0x1::vector::length<Mutation>(arg1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<Mutation>(arg1, v1);
            flip_weight(arg0, v2.layer_index, v2.neuron_index, v2.weight_index);
            v1 = v1 + 1;
        };
        arg0.generation = arg0.generation + 1;
        let v3 = NetworkMutated{
            network_id        : 0x2::object::uid_to_inner(&arg0.id),
            mutations_applied : v0,
            new_generation    : arg0.generation,
        };
        0x2::event::emit<NetworkMutated>(v3);
    }

    public fun architecture(arg0: &BinaryNetwork) : vector<u64> {
        arg0.architecture
    }

    fun argmax_raw(arg0: &0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::RawActivation) : u64 {
        let v0 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::raw_magnitudes(arg0);
        let v1 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::raw_signs(arg0);
        let v2 = 0x1::vector::length<u64>(&v0);
        if (v2 == 0) {
            return 0
        };
        let v3 = *0x1::vector::borrow<u64>(&v0, 0);
        let v4 = *0x1::vector::borrow<bool>(&v1, 0);
        let v5 = 1;
        while (v5 < v2) {
            v3 = *0x1::vector::borrow<u64>(&v0, v5);
            v4 = *0x1::vector::borrow<bool>(&v1, v5);
            if (v4 && !v4 || !v4 && v4 && false || !v4 && v3 > v3 || v3 < v3) {
            };
            v5 = v5 + 1;
        };
        0
    }

    public fun clone_network(arg0: &BinaryNetwork, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : BinaryNetwork {
        let v0 = BinaryNetwork{
            id           : 0x2::object::new(arg2),
            architecture : arg0.architecture,
            num_layers   : arg0.num_layers,
            total_params : arg0.total_params,
            generation   : arg0.generation,
            fitness      : arg0.fitness,
            parent_id    : 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&arg0.id)),
            created_at   : 0x2::tx_context::epoch(arg2),
            name         : arg1,
        };
        let v1 = 0;
        while (v1 < arg0.num_layers) {
            let v2 = LayerKey{index: v1};
            let v3 = 0x2::dynamic_object_field::borrow<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&arg0.id, v2);
            let v4 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::output_size(v3);
            let v5 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::create_layer(0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::input_size(v3), v4, v1, arg2);
            let v6 = 0;
            while (v6 < v4) {
                0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::set_neuron_weights(&mut v5, v6, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::get_neuron_weights(v3, v6));
                0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::set_threshold(&mut v5, v6, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::get_threshold(v3, v6));
                v6 = v6 + 1;
            };
            let v7 = LayerKey{index: v1};
            0x2::dynamic_object_field::add<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&mut v0.id, v7, v5);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_mutation(arg0: u64, arg1: u64, arg2: u64) : Mutation {
        Mutation{
            layer_index  : arg0,
            neuron_index : arg1,
            weight_index : arg2,
        }
    }

    public fun create_network(arg0: vector<u64>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : BinaryNetwork {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 >= 2, 200);
        let v1 = v0 - 1;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg0, v3) * *0x1::vector::borrow<u64>(&arg0, v3 + 1);
            v3 = v3 + 1;
        };
        let v4 = BinaryNetwork{
            id           : 0x2::object::new(arg2),
            architecture : arg0,
            num_layers   : v1,
            total_params : v2,
            generation   : 0,
            fitness      : 0,
            parent_id    : 0x1::option::none<0x2::object::ID>(),
            created_at   : 0x2::tx_context::epoch(arg2),
            name         : arg1,
        };
        let v5 = 0;
        while (v5 < v1) {
            let v6 = LayerKey{index: v5};
            0x2::dynamic_object_field::add<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&mut v4.id, v6, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::create_layer(*0x1::vector::borrow<u64>(&v4.architecture, v5), *0x1::vector::borrow<u64>(&v4.architecture, v5 + 1), v5, arg2));
            v5 = v5 + 1;
        };
        let v7 = NetworkCreated{
            network_id   : 0x2::object::uid_to_inner(&v4.id),
            architecture : v4.architecture,
            total_params : v2,
            generation   : 0,
        };
        0x2::event::emit<NetworkCreated>(v7);
        v4
    }

    public fun create_network_random(arg0: vector<u64>, arg1: vector<u8>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) : BinaryNetwork {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 >= 2, 200);
        let v1 = v0 - 1;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg0, v3) * *0x1::vector::borrow<u64>(&arg0, v3 + 1);
            v3 = v3 + 1;
        };
        let v4 = BinaryNetwork{
            id           : 0x2::object::new(arg3),
            architecture : arg0,
            num_layers   : v1,
            total_params : v2,
            generation   : 0,
            fitness      : 0,
            parent_id    : 0x1::option::none<0x2::object::ID>(),
            created_at   : 0x2::tx_context::epoch(arg3),
            name         : arg1,
        };
        let v5 = 0;
        while (v5 < v1) {
            let v6 = arg2 * 6364136223846793005 + 1442695040888963407;
            arg2 = v6;
            let v7 = LayerKey{index: v5};
            0x2::dynamic_object_field::add<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&mut v4.id, v7, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::create_layer_seeded(*0x1::vector::borrow<u64>(&v4.architecture, v5), *0x1::vector::borrow<u64>(&v4.architecture, v5 + 1), v5, v6, arg3));
            v5 = v5 + 1;
        };
        let v8 = NetworkCreated{
            network_id   : 0x2::object::uid_to_inner(&v4.id),
            architecture : v4.architecture,
            total_params : v2,
            generation   : 0,
        };
        0x2::event::emit<NetworkCreated>(v8);
        v4
    }

    public fun destroy_network(arg0: BinaryNetwork) {
        let v0 = 0;
        while (v0 < arg0.num_layers) {
            let v1 = LayerKey{index: v0};
            0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::destroy_layer(0x2::dynamic_object_field::remove<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&mut arg0.id, v1));
            v0 = v0 + 1;
        };
        let BinaryNetwork {
            id           : v2,
            architecture : _,
            num_layers   : _,
            total_params : _,
            generation   : _,
            fitness      : _,
            parent_id    : _,
            created_at   : _,
            name         : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun fitness(arg0: &BinaryNetwork) : u64 {
        arg0.fitness
    }

    public fun generation(arg0: &BinaryNetwork) : u64 {
        arg0.generation
    }

    public fun get_fitness(arg0: &BinaryNetwork) : u64 {
        arg0.fitness
    }

    public fun get_layer(arg0: &BinaryNetwork, arg1: u64) : &0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer {
        assert!(arg1 < arg0.num_layers, 201);
        let v0 = LayerKey{index: arg1};
        0x2::dynamic_object_field::borrow<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&arg0.id, v0)
    }

    public fun get_layer_mut(arg0: &mut BinaryNetwork, arg1: u64) : &mut 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer {
        assert!(arg1 < arg0.num_layers, 201);
        let v0 = LayerKey{index: arg1};
        0x2::dynamic_object_field::borrow_mut<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&mut arg0.id, v0)
    }

    public fun get_stats(arg0: &BinaryNetwork) : NetworkStats {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0.num_layers) {
            let v2 = LayerKey{index: v1};
            let v3 = 0x2::dynamic_object_field::borrow<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&arg0.id, v2);
            let v4 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::output_size(v3);
            let v5 = 0;
            let v6 = 0;
            while (v6 < v4) {
                let (v7, _) = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::neuron_sparsity(v3, v6);
                v5 = v5 + v7;
                v6 = v6 + 1;
            };
            0x1::vector::push_back<u64>(&mut v0, v5 * 10000 / 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::input_size(v3) * v4);
            v1 = v1 + 1;
        };
        NetworkStats{
            architecture     : arg0.architecture,
            total_params     : arg0.total_params,
            layer_sparsities : v0,
            generation       : arg0.generation,
            fitness          : arg0.fitness,
        }
    }

    public fun id(arg0: &BinaryNetwork) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun increment_generation(arg0: &mut BinaryNetwork) {
        arg0.generation = arg0.generation + 1;
    }

    public fun inference(arg0: &BinaryNetwork, arg1: 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation) : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation {
        assert!(0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::activation_num_bits(&arg1) == *0x1::vector::borrow<u64>(&arg0.architecture, 0), 202);
        let v0 = arg1;
        let v1 = 0;
        while (v1 < arg0.num_layers) {
            let v2 = LayerKey{index: v1};
            let v3 = &v0;
            v0 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::forward(0x2::dynamic_object_field::borrow<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&arg0.id, v2), v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun inference_detailed(arg0: &BinaryNetwork, arg1: 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation) : InferenceResult {
        assert!(0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::activation_num_bits(&arg1) == *0x1::vector::borrow<u64>(&arg0.architecture, 0), 202);
        let v0 = 0x1::vector::empty<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation>();
        let v1 = arg1;
        let v2 = 0;
        while (v2 < arg0.num_layers - 1) {
            let v3 = LayerKey{index: v2};
            let v4 = &v1;
            v1 = 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::forward(0x2::dynamic_object_field::borrow<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&arg0.id, v3), v4);
            0x1::vector::push_back<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation>(&mut v0, v1);
            v2 = v2 + 1;
        };
        let v5 = LayerKey{index: arg0.num_layers - 1};
        let v6 = 0x2::dynamic_object_field::borrow<LayerKey, 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryLayer>(&arg0.id, v5);
        InferenceResult{
            output            : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::forward(v6, &v1),
            raw_output        : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::forward_raw(v6, &v1),
            layer_activations : v0,
        }
    }

    public fun name(arg0: &BinaryNetwork) : vector<u8> {
        arg0.name
    }

    public fun num_layers(arg0: &BinaryNetwork) : u64 {
        arg0.num_layers
    }

    public fun parent_id(arg0: &BinaryNetwork) : 0x1::option::Option<0x2::object::ID> {
        arg0.parent_id
    }

    public fun predict_class(arg0: &BinaryNetwork, arg1: 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation) : u64 {
        let v0 = inference_detailed(arg0, arg1);
        argmax_raw(&v0.raw_output)
    }

    public fun result_layers(arg0: &InferenceResult) : vector<0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation> {
        arg0.layer_activations
    }

    public fun result_output(arg0: &InferenceResult) : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::BinaryActivation {
        arg0.output
    }

    public fun result_raw(arg0: &InferenceResult) : 0xb572e91a203288bf7b2e5c8c9b5f715b1b847155fcbc75ec0a2097f0e76fc0e9::binary_layer::RawActivation {
        arg0.raw_output
    }

    public fun set_fitness(arg0: &mut BinaryNetwork, arg1: u64) {
        arg0.fitness = arg1;
    }

    public fun set_parent(arg0: &mut BinaryNetwork, arg1: 0x2::object::ID) {
        arg0.parent_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun share_network(arg0: BinaryNetwork) {
        0x2::transfer::share_object<BinaryNetwork>(arg0);
    }

    public fun total_params(arg0: &BinaryNetwork) : u64 {
        arg0.total_params
    }

    public fun transfer_network(arg0: BinaryNetwork, arg1: address) {
        0x2::transfer::transfer<BinaryNetwork>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

