module 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_layer {
    struct NeuronWeightKey has copy, drop, store {
        neuron_index: u64,
    }

    struct ThresholdKey has copy, drop, store {
        neuron_index: u64,
    }

    struct BinaryLayer has store, key {
        id: 0x2::object::UID,
        input_size: u64,
        output_size: u64,
        input_chunks: u64,
        layer_index: u64,
        activation_type: u8,
        default_threshold: u64,
    }

    struct BinaryActivation has copy, drop, store {
        values: vector<u256>,
        num_bits: u64,
    }

    struct RawActivation has copy, drop, store {
        magnitudes: vector<u64>,
        is_negative: vector<bool>,
    }

    public fun activation_from_bools(arg0: &vector<bool>) : BinaryActivation {
        let v0 = 0x1::vector::length<bool>(arg0);
        let v1 = 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::create_zero_chunks(v0);
        let v2 = 0;
        while (v2 < v0) {
            if (*0x1::vector::borrow<bool>(arg0, v2)) {
                0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::set_bit(&mut v1, v2, true);
            };
            v2 = v2 + 1;
        };
        BinaryActivation{
            values   : v1,
            num_bits : v0,
        }
    }

    public fun activation_num_bits(arg0: &BinaryActivation) : u64 {
        arg0.num_bits
    }

    public fun activation_to_bools(arg0: &BinaryActivation) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = 0;
        while (v1 < arg0.num_bits) {
            0x1::vector::push_back<bool>(&mut v0, 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::get_bit(&arg0.values, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun activation_values(arg0: &BinaryActivation) : vector<u256> {
        arg0.values
    }

    public fun count_positive_weights(arg0: &BinaryLayer, arg1: u64) : u64 {
        let v0 = NeuronWeightKey{neuron_index: arg1};
        let v1 = 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::popcount_chunks(0x2::dynamic_field::borrow<NeuronWeightKey, vector<u256>>(&arg0.id, v0));
        if (v1 > arg0.input_size) {
            arg0.input_size
        } else {
            v1
        }
    }

    public fun create_activation(arg0: vector<u256>, arg1: u64) : BinaryActivation {
        BinaryActivation{
            values   : arg0,
            num_bits : arg1,
        }
    }

    public fun create_layer(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : BinaryLayer {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0, 101);
        let v0 = BinaryLayer{
            id                : 0x2::object::new(arg3),
            input_size        : arg0,
            output_size       : arg1,
            input_chunks      : 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::chunks_needed(arg0),
            layer_index       : arg2,
            activation_type   : 0,
            default_threshold : arg0 / 2,
        };
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = NeuronWeightKey{neuron_index: v1};
            0x2::dynamic_field::add<NeuronWeightKey, vector<u256>>(&mut v0.id, v2, 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::create_zero_chunks(arg0));
            let v3 = ThresholdKey{neuron_index: v1};
            0x2::dynamic_field::add<ThresholdKey, u64>(&mut v0.id, v3, arg0 / 2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_layer_seeded(arg0: u64, arg1: u64, arg2: u64, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) : BinaryLayer {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0, 101);
        let v0 = 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::chunks_needed(arg0);
        let v1 = BinaryLayer{
            id                : 0x2::object::new(arg4),
            input_size        : arg0,
            output_size       : arg1,
            input_chunks      : v0,
            layer_index       : arg2,
            activation_type   : 0,
            default_threshold : arg0 / 2,
        };
        let v2 = 0;
        let v3 = arg3;
        while (v2 < arg1) {
            let v4 = 0x1::vector::empty<u256>();
            let v5 = 0;
            while (v5 < v0) {
                v3 = v3 * 6364136223846793005 + 1;
                0x1::vector::push_back<u256>(&mut v4, v3);
                v5 = v5 + 1;
            };
            let v6 = NeuronWeightKey{neuron_index: v2};
            0x2::dynamic_field::add<NeuronWeightKey, vector<u256>>(&mut v1.id, v6, v4);
            let v7 = ThresholdKey{neuron_index: v2};
            0x2::dynamic_field::add<ThresholdKey, u64>(&mut v1.id, v7, arg0 / 2);
            v2 = v2 + 1;
        };
        v1
    }

    public fun destroy_layer(arg0: BinaryLayer) {
        let v0 = 0;
        while (v0 < arg0.output_size) {
            let v1 = NeuronWeightKey{neuron_index: v0};
            0x2::dynamic_field::remove<NeuronWeightKey, vector<u256>>(&mut arg0.id, v1);
            let v2 = ThresholdKey{neuron_index: v0};
            0x2::dynamic_field::remove<ThresholdKey, u64>(&mut arg0.id, v2);
            v0 = v0 + 1;
        };
        let BinaryLayer {
            id                : v3,
            input_size        : _,
            output_size       : _,
            input_chunks      : _,
            layer_index       : _,
            activation_type   : _,
            default_threshold : _,
        } = arg0;
        0x2::object::delete(v3);
    }

    public fun flip_weight(arg0: &mut BinaryLayer, arg1: u64, arg2: u64) {
        assert!(arg1 < arg0.output_size, 102);
        assert!(arg2 < arg0.input_size, 100);
        let v0 = NeuronWeightKey{neuron_index: arg1};
        0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::flip_bit(0x2::dynamic_field::borrow_mut<NeuronWeightKey, vector<u256>>(&mut arg0.id, v0), arg2);
    }

    public fun forward(arg0: &BinaryLayer, arg1: &BinaryActivation) : BinaryActivation {
        assert!(arg1.num_bits == arg0.input_size, 100);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0;
        while (v2 < arg0.output_size) {
            let v3 = NeuronWeightKey{neuron_index: v2};
            let _ = ThresholdKey{neuron_index: v2};
            let (v5, v6) = 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::binary_dot_product(&arg1.values, 0x2::dynamic_field::borrow<NeuronWeightKey, vector<u256>>(&arg0.id, v3), arg0.input_size);
            0x1::vector::push_back<u64>(&mut v0, v5);
            0x1::vector::push_back<bool>(&mut v1, v6);
            v2 = v2 + 1;
        };
        BinaryActivation{
            values   : 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::sign_activation_batch(&v0, &v1, 0),
            num_bits : arg0.output_size,
        }
    }

    public fun forward_raw(arg0: &BinaryLayer, arg1: &BinaryActivation) : RawActivation {
        assert!(arg1.num_bits == arg0.input_size, 100);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0;
        while (v2 < arg0.output_size) {
            let v3 = NeuronWeightKey{neuron_index: v2};
            let (v4, v5) = 0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::binary_dot_product(&arg1.values, 0x2::dynamic_field::borrow<NeuronWeightKey, vector<u256>>(&arg0.id, v3), arg0.input_size);
            0x1::vector::push_back<u64>(&mut v0, v4);
            0x1::vector::push_back<bool>(&mut v1, v5);
            v2 = v2 + 1;
        };
        RawActivation{
            magnitudes  : v0,
            is_negative : v1,
        }
    }

    public fun get_neuron_weights(arg0: &BinaryLayer, arg1: u64) : vector<u256> {
        assert!(arg1 < arg0.output_size, 102);
        let v0 = NeuronWeightKey{neuron_index: arg1};
        0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::clone_chunks(0x2::dynamic_field::borrow<NeuronWeightKey, vector<u256>>(&arg0.id, v0))
    }

    public fun get_threshold(arg0: &BinaryLayer, arg1: u64) : u64 {
        assert!(arg1 < arg0.output_size, 103);
        let v0 = ThresholdKey{neuron_index: arg1};
        *0x2::dynamic_field::borrow<ThresholdKey, u64>(&arg0.id, v0)
    }

    public fun id(arg0: &BinaryLayer) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun input_chunks(arg0: &BinaryLayer) : u64 {
        arg0.input_chunks
    }

    public fun input_size(arg0: &BinaryLayer) : u64 {
        arg0.input_size
    }

    public fun layer_index(arg0: &BinaryLayer) : u64 {
        arg0.layer_index
    }

    public fun neuron_sparsity(arg0: &BinaryLayer, arg1: u64) : (u64, u64) {
        (arg0.input_size - count_positive_weights(arg0, arg1), arg0.input_size)
    }

    public fun output_size(arg0: &BinaryLayer) : u64 {
        arg0.output_size
    }

    public fun raw_magnitudes(arg0: &RawActivation) : vector<u64> {
        arg0.magnitudes
    }

    public fun raw_signs(arg0: &RawActivation) : vector<bool> {
        arg0.is_negative
    }

    public fun set_neuron_weights(arg0: &mut BinaryLayer, arg1: u64, arg2: vector<u256>) {
        assert!(arg1 < arg0.output_size, 102);
        let v0 = NeuronWeightKey{neuron_index: arg1};
        *0x2::dynamic_field::borrow_mut<NeuronWeightKey, vector<u256>>(&mut arg0.id, v0) = arg2;
    }

    public fun set_threshold(arg0: &mut BinaryLayer, arg1: u64, arg2: u64) {
        assert!(arg1 < arg0.output_size, 103);
        let v0 = ThresholdKey{neuron_index: arg1};
        *0x2::dynamic_field::borrow_mut<ThresholdKey, u64>(&mut arg0.id, v0) = arg2;
    }

    public fun set_weight_bit(arg0: &mut BinaryLayer, arg1: u64, arg2: u64, arg3: bool) {
        assert!(arg1 < arg0.output_size, 102);
        assert!(arg2 < arg0.input_size, 100);
        let v0 = NeuronWeightKey{neuron_index: arg1};
        0x78b6ed7ab72a37a5d644055ffdf4eebf6d25608c31d521ebd399f719e9ec3c9a::binary_math::set_bit(0x2::dynamic_field::borrow_mut<NeuronWeightKey, vector<u256>>(&mut arg0.id, v0), arg2, arg3);
    }

    public fun share_layer(arg0: BinaryLayer) {
        0x2::transfer::share_object<BinaryLayer>(arg0);
    }

    public fun total_weights(arg0: &BinaryLayer) : u64 {
        arg0.input_size * arg0.output_size
    }

    public fun transfer_layer(arg0: BinaryLayer, arg1: address) {
        0x2::transfer::transfer<BinaryLayer>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

