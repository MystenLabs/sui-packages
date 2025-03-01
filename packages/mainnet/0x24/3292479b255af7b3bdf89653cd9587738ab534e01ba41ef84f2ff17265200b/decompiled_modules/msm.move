module 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::msm {
    struct PubKey has key {
        id: 0x2::object::UID,
        value: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MSM has drop {
        dummy_field: bool,
    }

    public fun init_module(arg0: MSM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PubKey{
            id    : 0x2::object::new(arg1),
            value : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<PubKey>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_pub_key(arg0: &AdminCap, arg1: &mut PubKey, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.value = arg2;
    }

    public fun u128_to_vec8(arg0: u128) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun verify_signature(arg0: &PubKey, arg1: u128, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : bool {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, u128_to_vec8(arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        let v1 = 0x1::hash::sha2_256(v0);
        0x2::ed25519::ed25519_verify(&arg4, &arg0.value, &v1)
    }

    // decompiled from Move bytecode v6
}

