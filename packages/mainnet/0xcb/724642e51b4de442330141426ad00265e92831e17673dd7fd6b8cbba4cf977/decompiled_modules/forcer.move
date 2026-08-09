module 0xcb724642e51b4de442330141426ad00265e92831e17673dd7fd6b8cbba4cf977::forcer {
    struct Probe has copy, drop {
        actual: vector<u8>,
        preds: vector<vector<u8>>,
    }

    fun le8(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    fun predicted_r(arg0: u64, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = predicted_uid_k(arg0, arg1);
        (*0x1::vector::borrow<u8>(&v0, 0) as u64) % 2
    }

    fun predicted_uid_k(arg0: u64, arg1: &0x2::tx_context::TxContext) : vector<u8> {
        let v0 = x"f1";
        0x1::vector::append<u8>(&mut v0, *0x2::tx_context::digest(arg1));
        0x1::vector::append<u8>(&mut v0, le8(arg0));
        0x2::hash::blake2b256(&v0)
    }

    public fun probe(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<vector<u8>>(&mut v0, predicted_uid_k(v1, arg0));
            v1 = v1 + 1;
        };
        let v2 = 0x2::object::new(arg0);
        0x2::object::delete(v2);
        let v3 = Probe{
            actual : 0x2::object::uid_to_bytes(&v2),
            preds  : v0,
        };
        0x2::event::emit<Probe>(v3);
    }

    public fun require_even(arg0: u64) {
        assert!(arg0 % 2 == 0, 42);
    }

    public fun require_win(arg0: u64, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!((arg0 + predicted_r(arg1, arg2)) % 2 == 0, 42);
    }

    public fun seed_input(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg2) + arg0 + 1 + arg1 + 1
    }

    public fun side(arg0: u64) : vector<u8> {
        if (arg0 % 2 == 0) {
            b"head"
        } else {
            b"tail"
        }
    }

    public fun side_from(arg0: u64, arg1: u64, arg2: &0x2::tx_context::TxContext) : vector<u8> {
        if ((arg0 + predicted_r(arg1, arg2)) % 2 == 0) {
            b"head"
        } else {
            b"tail"
        }
    }

    // decompiled from Move bytecode v7
}

