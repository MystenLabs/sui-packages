module 0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::pool {
    public fun swap_in<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::framework::AccountRequest>) : 0x2::coin::Coin<0x2::object::UID> {
        abort 0
    }

    public fun swap_out<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::UID, arg3: 0x2::coin::Coin<0x2::object::UID>, arg4: 0x1::option::Option<0xcc39fc8bcd400e1fc1e566265417df779ad2eaa5244a53fabfd25f3fd8984498::framework::AccountRequest>) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

