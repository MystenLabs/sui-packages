module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix {
    struct EpochValue has copy, drop, store {
        epoch: u32,
        value: u64,
    }

    struct IX has copy, drop, store {
        node_id: 0x2::object::ID,
        epoch_values: vector<EpochValue>,
    }

    public(friend) fun epoch(arg0: EpochValue) : u32 {
        arg0.epoch
    }

    public(friend) fun epoch_values(arg0: IX) : vector<EpochValue> {
        arg0.epoch_values
    }

    public fun new_epoch_value_vector(arg0: vector<u32>, arg1: vector<u64>) : vector<EpochValue> {
        let v0 = 0x1::vector::empty<EpochValue>();
        0x1::vector::reverse<u64>(&mut arg1);
        assert!(0x1::vector::length<u32>(&arg0) == 0x1::vector::length<u64>(&arg1), 13906834268832661503);
        0x1::vector::reverse<u32>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg0)) {
            let v2 = EpochValue{
                epoch : 0x1::vector::pop_back<u32>(&mut arg0),
                value : 0x1::vector::pop_back<u64>(&mut arg1),
            };
            0x1::vector::push_back<EpochValue>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u32>(arg0);
        0x1::vector::destroy_empty<u64>(arg1);
        v0
    }

    public fun new_ix(arg0: 0x2::object::ID, arg1: vector<EpochValue>) : IX {
        IX{
            node_id      : arg0,
            epoch_values : arg1,
        }
    }

    public(friend) fun node_id(arg0: IX) : 0x2::object::ID {
        arg0.node_id
    }

    public(friend) fun value(arg0: EpochValue) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

