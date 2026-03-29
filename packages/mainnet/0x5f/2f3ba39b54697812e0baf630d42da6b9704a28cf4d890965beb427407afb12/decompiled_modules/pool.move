module 0x5f2f3ba39b54697812e0baf630d42da6b9704a28cf4d890965beb427407afb12::pool {
    public fun swap_in<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0x5f2f3ba39b54697812e0baf630d42da6b9704a28cf4d890965beb427407afb12::framework::AccountRequest>) : 0x2::coin::Coin<0x2::object::UID> {
        abort 0
    }

    public fun swap_out<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: 0x1::option::Option<0x5f2f3ba39b54697812e0baf630d42da6b9704a28cf4d890965beb427407afb12::framework::AccountRequest>) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

