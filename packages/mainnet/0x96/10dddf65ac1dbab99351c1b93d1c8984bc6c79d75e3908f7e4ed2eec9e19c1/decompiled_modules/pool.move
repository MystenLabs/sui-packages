module 0x9610dddf65ac1dbab99351c1b93d1c8984bc6c79d75e3908f7e4ed2eec9e19c1::pool {
    public fun swap_in<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0x9610dddf65ac1dbab99351c1b93d1c8984bc6c79d75e3908f7e4ed2eec9e19c1::framework::AccountRequest>) : 0x2::coin::Coin<0x2::object::UID> {
        abort 0
    }

    public fun swap_out<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: 0x1::option::Option<0x9610dddf65ac1dbab99351c1b93d1c8984bc6c79d75e3908f7e4ed2eec9e19c1::framework::AccountRequest>) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

