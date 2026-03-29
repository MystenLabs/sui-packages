module 0xae417c167ac9093993a0eee8fc9a5bca3e888f23cf3ce6196d81e09365d2356f::pool {
    public fun swap_in<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0xae417c167ac9093993a0eee8fc9a5bca3e888f23cf3ce6196d81e09365d2356f::framework::AccountRequest>) : 0x2::coin::Coin<0x2::object::UID> {
        abort 0
    }

    public fun swap_out<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: 0x1::option::Option<0xae417c167ac9093993a0eee8fc9a5bca3e888f23cf3ce6196d81e09365d2356f::framework::AccountRequest>) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

