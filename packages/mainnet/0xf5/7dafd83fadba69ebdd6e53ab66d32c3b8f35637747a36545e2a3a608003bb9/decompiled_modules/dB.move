module 0x6b24a77788f715bc98204f0b9eb323839732593fa86183834d88d749dc4c1a9b::dB {
    struct AP has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        balances: 0x2::bag::Bag,
    }

    struct CI has copy, drop, store {
        ls: u64,
        la: 0x1::type_name::TypeName,
        lb: 0x1::string::String,
    }

    public fun eA<T0>(arg0: &mut AP, arg1: 0x2::balance::Balance<T0>, arg2: 0x1::string::String) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = CI{
            ls : 0x2::balance::value<T0>(&arg1),
            la : v0,
            lb : arg2,
        };
        0x2::event::emit<CI>(v1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun fG<T0>(arg0: &mut AP, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = CI{
            ls : 0x2::coin::value<T0>(&arg1),
            la : v0,
            lb : arg2,
        };
        0x2::event::emit<CI>(v1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun gJ(arg0: &AP) {
        assert!(arg0.version == 0, 512);
    }

    public fun hA(arg0: &mut AP, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 914);
        arg0.version = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AP{
            id       : 0x2::object::new(arg0),
            version  : 0,
            admin    : 0x2::tx_context::sender(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<AP>(v0);
    }

    public fun iz<T0>(arg0: &mut AP, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 914);
        let v0 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::with_defining_ids<T0>());
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg1), arg0.admin);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

