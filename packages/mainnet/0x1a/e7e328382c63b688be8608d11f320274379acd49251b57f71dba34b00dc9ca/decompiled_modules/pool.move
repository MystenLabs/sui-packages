module 0x1ae7e328382c63b688be8608d11f320274379acd49251b57f71dba34b00dc9ca::pool {
    public fun swap_in<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0x1ae7e328382c63b688be8608d11f320274379acd49251b57f71dba34b00dc9ca::framework::AccountRequest>) : 0x2::coin::Coin<0x2::object::UID> {
        abort 0
    }

    public fun swap_out<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: 0x1::option::Option<0x1ae7e328382c63b688be8608d11f320274379acd49251b57f71dba34b00dc9ca::framework::AccountRequest>) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

