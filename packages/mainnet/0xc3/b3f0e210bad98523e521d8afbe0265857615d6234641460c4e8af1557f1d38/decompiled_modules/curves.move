module 0xc3b3f0e210bad98523e521d8afbe0265857615d6234641460c4e8af1557f1d38::curves {
    struct Weighted {
        dummy_field: bool,
    }

    struct Stable {
        dummy_field: bool,
    }

    struct Curved {
        dummy_field: bool,
    }

    public fun assert_valid_curve<T0>() {
        assert!(is_valid_curve<T0>(), 10001);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun is_curved<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Curved>()
    }

    public entry fun is_stable<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Stable>()
    }

    public entry fun is_valid_curve<T0>() : bool {
        is_weighted<T0>() || is_stable<T0>() || is_curved<T0>()
    }

    public entry fun is_weighted<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<Weighted>()
    }

    // decompiled from Move bytecode v6
}

