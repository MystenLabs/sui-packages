module 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::securities_token {
    struct Transfer<phantom T0> has copy, drop {
        sender: address,
        from: 0x1::option::Option<address>,
        to: 0x1::option::Option<address>,
        value: u64,
    }

    public entry fun burn<T0>(arg0: &mut 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::GlobalCap<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::check<T0>(arg0);
        assert!(0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::is_role<T0>(arg0, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::roles::role_burn(), arg3), 9223372316027650049);
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::decrease_supply<T0>(arg0, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::split<T0>(arg0, arg1, arg2));
        let v0 = Transfer<T0>{
            sender : 0x2::tx_context::sender(arg3),
            from   : 0x1::option::some<address>(arg1),
            to     : 0x1::option::none<address>(),
            value  : arg2,
        };
        0x2::event::emit<Transfer<T0>>(v0);
    }

    fun check_receive<T0>(arg0: &0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::GlobalCap<T0>, arg1: address) {
        assert!(0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::is_role_by_address<T0>(arg0, arg1, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::roles::role_receive()), 9223372547956277255);
    }

    public entry fun mint<T0>(arg0: &mut 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::GlobalCap<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::check<T0>(arg0);
        assert!(0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::is_role<T0>(arg0, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::roles::role_mint(), arg3), 9223372225833467907);
        check_receive<T0>(arg0, arg1);
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::join<T0>(arg0, arg1, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::increase_supply<T0>(arg0, arg2));
        let v0 = Transfer<T0>{
            sender : 0x2::tx_context::sender(arg3),
            from   : 0x1::option::none<address>(),
            to     : 0x1::option::some<address>(arg1),
            value  : arg2,
        };
        0x2::event::emit<Transfer<T0>>(v0);
    }

    public entry fun transfer<T0>(arg0: &mut 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::GlobalCap<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::is_role<T0>(arg0, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::roles::role_transfer(), arg3), 9223372393337323525);
        transfer_internal<T0>(arg0, 0x2::tx_context::sender(arg3), arg1, arg2, arg3);
    }

    public entry fun transfer_from<T0>(arg0: &mut 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::GlobalCap<T0>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::check_admin<T0>(arg0, arg4);
        transfer_internal<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun transfer_internal<T0>(arg0: &mut 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::GlobalCap<T0>, arg1: address, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 != arg2, 9223372462057062409);
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::check<T0>(arg0);
        check_receive<T0>(arg0, arg2);
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::join<T0>(arg0, arg2, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury::split<T0>(arg0, arg1, arg3));
        let v0 = Transfer<T0>{
            sender : 0x2::tx_context::sender(arg4),
            from   : 0x1::option::some<address>(arg1),
            to     : 0x1::option::some<address>(arg2),
            value  : arg3,
        };
        0x2::event::emit<Transfer<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

