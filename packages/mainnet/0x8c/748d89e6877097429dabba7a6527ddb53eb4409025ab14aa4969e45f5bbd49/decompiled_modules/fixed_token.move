module 0x8c748d89e6877097429dabba7a6527ddb53eb4409025ab14aa4969e45f5bbd49::fixed_token {
    struct TOKEN has key {
        id: 0x2::object::UID,
    }

    struct SetupCap has key {
        id: 0x2::object::UID,
    }

    public fun create(arg0: SetupCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(arg2 <= 18, 2);
        assert!(0x1::vector::length<u8>(&arg4) > 0 && 0x1::vector::length<u8>(&arg4) <= 256, 3);
        assert!(0x1::vector::length<u8>(&arg6) <= 2000, 5);
        validate_symbol(&arg5);
        assert!(0x1::vector::length<u8>(&arg7) <= 2048, 6);
        if (!0x1::vector::is_empty<u8>(&arg7)) {
            let v0 = b"https://";
            assert!(0x1::vector::length<u8>(&arg7) > 0x1::vector::length<u8>(&v0), 6);
            let v1 = 0;
            while (v1 < 0x1::vector::length<u8>(&v0)) {
                assert!(*0x1::vector::borrow<u8>(&arg7, v1) == *0x1::vector::borrow<u8>(&v0, v1), 6);
                v1 = v1 + 1;
            };
        };
        let SetupCap { id: v2 } = arg0;
        0x2::object::delete(v2);
        let (v3, v4) = 0x2::coin_registry::new_currency<TOKEN>(arg1, arg2, 0x1::string::utf8(arg5), 0x1::string::utf8(arg4), 0x1::string::utf8(arg6), 0x1::string::utf8(arg7), arg8);
        let v5 = v4;
        let v6 = v3;
        0x2::coin_registry::make_supply_fixed_init<TOKEN>(&mut v6, v5);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TOKEN>(v6, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(&mut v5, arg3, arg8), 0x2::tx_context::sender(arg8));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SetupCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SetupCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun validate_symbol(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0 && 0x1::vector::length<u8>(arg0) <= 10, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = v1 >= 65 && v1 <= 90;
            let v3 = v1 >= 97 && v1 <= 122;
            let v4 = v1 >= 48 && v1 <= 57;
            let v5 = if (v2) {
                true
            } else if (v3) {
                true
            } else {
                v4
            };
            assert!(v5, 4);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

