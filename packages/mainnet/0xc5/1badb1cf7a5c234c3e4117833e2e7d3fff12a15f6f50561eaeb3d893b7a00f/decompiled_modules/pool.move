module 0xc51badb1cf7a5c234c3e4117833e2e7d3fff12a15f6f50561eaeb3d893b7a00f::pool {
    public fun swap_in<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0xc51badb1cf7a5c234c3e4117833e2e7d3fff12a15f6f50561eaeb3d893b7a00f::framework::AccountRequest>) : 0x2::coin::Coin<0x2::object::UID> {
        abort 0
    }

    public fun swap_out<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: 0x1::option::Option<0xc51badb1cf7a5c234c3e4117833e2e7d3fff12a15f6f50561eaeb3d893b7a00f::framework::AccountRequest>) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

