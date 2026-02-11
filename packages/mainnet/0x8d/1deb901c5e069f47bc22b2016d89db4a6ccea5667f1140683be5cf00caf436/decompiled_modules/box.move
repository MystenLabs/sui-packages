module 0x8d1deb901c5e069f47bc22b2016d89db4a6ccea5667f1140683be5cf00caf436::box {
    struct Box has key {
        id: 0x2::object::UID,
        owner: address,
        unlock_timestamp: u64,
        keys: vector<vector<u8>>,
    }

    public entry fun create_box(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0 > v0, 2);
        assert!(arg0 <= v0 + 31536000000, 4);
        let v1 = Box{
            id               : 0x2::object::new(arg2),
            owner            : 0x2::tx_context::sender(arg2),
            unlock_timestamp : arg0,
            keys             : 0x1::vector::empty<vector<u8>>(),
        };
        0x2::transfer::transfer<Box>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun deposit<T0: store + key>(arg0: &mut Box, arg1: vector<u8>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(!0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, arg1), 3);
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut arg0.id, arg1, arg2);
        0x1::vector::push_back<vector<u8>>(&mut arg0.keys, arg1);
    }

    public fun get_keys(arg0: &Box) : vector<vector<u8>> {
        arg0.keys
    }

    public fun get_owner(arg0: &Box) : address {
        arg0.owner
    }

    public fun get_unlock_timestamp(arg0: &Box) : u64 {
        arg0.unlock_timestamp
    }

    public fun has_key(arg0: &Box, arg1: vector<u8>) : bool {
        0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public fun is_unlocked(arg0: &Box, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_timestamp
    }

    public entry fun relock(arg0: &mut Box, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.unlock_timestamp, 1);
        assert!(arg1 > v0, 2);
        assert!(arg1 <= v0 + 31536000000, 4);
        arg0.unlock_timestamp = arg1;
    }

    public fun time_until_unlock(arg0: &Box, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.unlock_timestamp) {
            0
        } else {
            arg0.unlock_timestamp - v0
        }
    }

    public entry fun withdraw<T0: store + key>(arg0: &mut Box, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.unlock_timestamp, 1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg3));
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg0.keys, &arg1);
        if (v0) {
            0x1::vector::remove<vector<u8>>(&mut arg0.keys, v1);
        };
    }

    // decompiled from Move bytecode v6
}

