module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::utils {
    struct UTILS has drop {
        dummy_field: bool,
    }

    public fun check_version(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version) {
        let v0 = 0x1::type_name::get<UTILS>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1)))) == 0, 0);
    }

    public fun create_bit_mask(arg0: u64) : vector<0x1::bit_vector::BitVector> {
        let v0 = arg0 / 1024;
        let v1 = v0;
        let v2 = arg0 - v0 * 1024;
        if (arg0 < 1024) {
            v1 = 0;
            v2 = arg0;
        };
        let v3 = 0x1::vector::empty<0x1::bit_vector::BitVector>();
        while (v1 > 0) {
            0x1::vector::push_back<0x1::bit_vector::BitVector>(&mut v3, 0x1::bit_vector::new(1023));
            v1 = v1 - 1;
        };
        0x1::vector::push_back<0x1::bit_vector::BitVector>(&mut v3, 0x1::bit_vector::new(v2));
        v3
    }

    fun init(arg0: UTILS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<UTILS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun new_version(arg0: &0x2::package::Publisher, arg1: &mut 0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::add(arg0, arg1);
    }

    public fun pseudo_random(arg0: address, arg1: u64) : u64 {
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v1 = 0x1::hash::sha2_256(v0);
        let v2 = b"";
        let v3 = 24;
        while (v3 < 32) {
            let v4 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v1, v3));
            0x1::vector::append<u8>(&mut v2, v4);
            v3 = v3 + 1;
        };
        assert!(arg1 > 0, 999);
        let v5 = 0x2::bcs::new(v2);
        let v6 = 0x2::bcs::peel_u64(&mut v5) % arg1 + 1;
        let v7 = v6;
        if (v6 == 0) {
            v7 = 1;
        };
        v7
    }

    public fun set_version(arg0: &0x2::package::Publisher, arg1: &mut 0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::set(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

