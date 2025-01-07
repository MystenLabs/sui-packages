module 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::securities_token {
    struct SecuritiesToken<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        cap: address,
    }

    struct SecuritiesTokenRef<phantom T0> has store, key {
        id: 0x2::object::UID,
        token: address,
        cap: address,
    }

    struct Transfer<phantom T0> has copy, drop {
        name: 0x1::string::String,
        sender: address,
        from: 0x1::option::Option<address>,
        to: 0x1::option::Option<address>,
        value: u64,
    }

    public entry fun transfer<T0>(arg0: &mut 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>, arg1: &mut SecuritiesToken<T0>, arg2: &mut SecuritiesToken<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_upgrade<T0>(arg0);
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_paused<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 9223372792769282053);
        assert!(0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::is_admin_or<T0>(arg0, 4, arg4), 9223372801359609867);
        transfer_internal<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun auth_investor<T0>(arg0: &mut 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::auth<T0>(arg0, arg1, 5, arg2);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::id_address<0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>>(arg0);
        let v2 = SecuritiesTokenRef<T0>{
            id    : 0x2::object::new(arg2),
            token : 0x2::object::uid_to_address(&v0),
            cap   : v1,
        };
        let v3 = SecuritiesToken<T0>{
            id      : v0,
            balance : 0x2::balance::zero<T0>(),
            owner   : arg1,
            cap     : v1,
        };
        0x2::transfer::share_object<SecuritiesToken<T0>>(v3);
        0x2::transfer::transfer<SecuritiesTokenRef<T0>>(v2, arg1);
    }

    public entry fun burn<T0>(arg0: &mut 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>, arg1: &mut SecuritiesToken<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_upgrade<T0>(arg0);
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_paused<T0>(arg0);
        check_cap<T0>(arg1, arg0);
        assert!(0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::is_admin_or<T0>(arg0, 3, arg3), 9223372698280132615);
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::decrease_supply<T0>(arg0, 0x2::balance::split<T0>(&mut arg1.balance, arg2));
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::set_balance<T0>(arg0, arg1.owner, 0x2::balance::value<T0>(&arg1.balance));
        let v0 = Transfer<T0>{
            name   : 0x1::string::utf8(b"burn"),
            sender : 0x2::tx_context::sender(arg3),
            from   : 0x1::option::some<address>(arg1.owner),
            to     : 0x1::option::none<address>(),
            value  : arg2,
        };
        0x2::event::emit<Transfer<T0>>(v0);
    }

    fun check_cap<T0>(arg0: &SecuritiesToken<T0>, arg1: &0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>) {
        assert!(arg0.cap == 0x2::object::id_address<0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>>(arg1), 9223372986043465743);
    }

    fun check_receive<T0>(arg0: &0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>, arg1: address) {
        assert!(0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::has_role_by_address<T0>(arg0, arg1, 5), 9223372968863465485);
    }

    public entry fun mint<T0>(arg0: &mut 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>, arg1: &mut SecuritiesToken<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_upgrade<T0>(arg0);
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_paused<T0>(arg0);
        check_cap<T0>(arg1, arg0);
        assert!(0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::is_admin_or<T0>(arg0, 2, arg3), 9223372590906081289);
        check_receive<T0>(arg0, arg1.owner);
        0x2::balance::join<T0>(&mut arg1.balance, 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::increase_supply<T0>(arg0, arg2));
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::set_balance<T0>(arg0, arg1.owner, 0x2::balance::value<T0>(&arg1.balance));
        let v0 = Transfer<T0>{
            name   : 0x1::string::utf8(b"mint"),
            sender : 0x2::tx_context::sender(arg3),
            from   : 0x1::option::none<address>(),
            to     : 0x1::option::some<address>(arg1.owner),
            value  : arg2,
        };
        0x2::event::emit<Transfer<T0>>(v0);
    }

    public fun token_owner<T0>(arg0: &SecuritiesToken<T0>) : address {
        arg0.owner
    }

    public fun token_value<T0>(arg0: &SecuritiesToken<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun transfer_from<T0>(arg0: &mut 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>, arg1: &mut SecuritiesToken<T0>, arg2: &mut SecuritiesToken<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_upgrade<T0>(arg0);
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_paused<T0>(arg0);
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::check_admin<T0>(arg0, arg4);
        transfer_internal<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun transfer_internal<T0>(arg0: &mut 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>, arg1: &mut SecuritiesToken<T0>, arg2: &mut SecuritiesToken<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        check_cap<T0>(arg1, arg0);
        check_cap<T0>(arg2, arg0);
        check_receive<T0>(arg0, arg2.owner);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::split<T0>(&mut arg1.balance, arg3));
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::set_balance<T0>(arg0, arg1.owner, 0x2::balance::value<T0>(&arg1.balance));
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::set_balance<T0>(arg0, arg2.owner, 0x2::balance::value<T0>(&arg2.balance));
        let v0 = Transfer<T0>{
            name   : 0x1::string::utf8(b"transfer"),
            sender : 0x2::tx_context::sender(arg4),
            from   : 0x1::option::some<address>(arg1.owner),
            to     : 0x1::option::some<address>(arg2.owner),
            value  : arg3,
        };
        0x2::event::emit<Transfer<T0>>(v0);
    }

    public entry fun unauth_investor<T0>(arg0: &mut 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::GlobalCap<T0>, arg1: SecuritiesToken<T0>, arg2: &0x2::tx_context::TxContext) {
        check_cap<T0>(&arg1, arg0);
        let SecuritiesToken {
            id      : v0,
            balance : v1,
            owner   : v2,
            cap     : _,
        } = arg1;
        0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury::unauth<T0>(arg0, v2, 5, arg2);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

