module 0xb84a4182f93f63a13d5281a83c5c486a11bdfc0a437f8ddb4e3205a8c6c0a075::pool {
    public fun swap_in<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0xb84a4182f93f63a13d5281a83c5c486a11bdfc0a437f8ddb4e3205a8c6c0a075::framework::AccountRequest>) : 0x2::coin::Coin<0x2::object::UID> {
        abort 0
    }

    public fun swap_out<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: 0x1::option::Option<0xb84a4182f93f63a13d5281a83c5c486a11bdfc0a437f8ddb4e3205a8c6c0a075::framework::AccountRequest>) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

