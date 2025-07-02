module 0x922b3d56c37665b1416409431d6979ebbe8368eaf41f10f4e2b6fd36baa05d34::tokens {
    struct WUSDC has drop {
        dummy_field: bool,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    struct USDT has drop {
        dummy_field: bool,
    }

    struct BUCK has drop {
        dummy_field: bool,
    }

    struct DEEP has drop {
        dummy_field: bool,
    }

    public fun is_valid_intermediate_token<T0>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<WUSDC>()) {
            true
        } else if (v0 == 0x1::type_name::get<USDC>()) {
            true
        } else if (v0 == 0x1::type_name::get<USDT>()) {
            true
        } else if (v0 == 0x1::type_name::get<BUCK>()) {
            true
        } else {
            v0 == 0x1::type_name::get<DEEP>()
        }
    }

    // decompiled from Move bytecode v6
}

