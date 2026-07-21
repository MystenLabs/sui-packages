module 0x5c225c63cc6b8326e9b74d8612ad65d2eeda2be0540d66dc72157bc265ba2070::m_inqwyltxbe {
    struct T_arzmsfzign has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct T_n6yfjf4st4 has key {
        id: 0x2::object::UID,
        keeper_cap_id: 0x2::object::ID,
        profit_recipient: address,
        balances: 0x2::bag::Bag,
    }

    struct T_szntilmrnt has copy, drop {
        vault_id: 0x2::object::ID,
        keeper_cap_id: 0x2::object::ID,
        owner: address,
        profit_recipient: address,
    }

    struct T_h2souqyp33 has copy, drop {
        amount: u64,
        recipient: address,
    }

    fun f_4s2z4l3vz6(arg0: &T_n6yfjf4st4, arg1: &T_arzmsfzign) {
        assert!(0x2::object::id<T_arzmsfzign>(arg1) == arg0.keeper_cap_id, 0);
        assert!(arg1.vault_id == 0x2::object::id<T_n6yfjf4st4>(arg0), 0);
    }

    public entry fun f_4wnonvhdkk(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        assert!(arg0 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = T_arzmsfzign{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        let v3 = 0x2::object::id<T_arzmsfzign>(&v2);
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = T_n6yfjf4st4{
            id               : v0,
            keeper_cap_id    : v3,
            profit_recipient : arg0,
            balances         : 0x2::bag::new(arg1),
        };
        let v6 = T_szntilmrnt{
            vault_id         : v1,
            keeper_cap_id    : v3,
            owner            : v4,
            profit_recipient : arg0,
        };
        0x2::event::emit<T_szntilmrnt>(v6);
        0x2::transfer::public_transfer<T_arzmsfzign>(v2, v4);
        0x2::transfer::share_object<T_n6yfjf4st4>(v5);
    }

    public fun f_743k6jgcwu(arg0: &T_n6yfjf4st4) : address {
        arg0.profit_recipient
    }

    public fun f_h52que6jrj<T0>(arg0: &mut T_n6yfjf4st4, arg1: &T_arzmsfzign, arg2: u64) : 0x2::balance::Balance<T0> {
        f_4s2z4l3vz6(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1);
        0x2::balance::split<T0>(v1, arg2)
    }

    public fun f_hzjlh6hkpn<T0>(arg0: &mut T_n6yfjf4st4, arg1: 0x2::coin::Coin<T0>) {
        f_tum4tgj4gf<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun f_pboxyjrfa2<T0>(arg0: &mut T_n6yfjf4st4, arg1: &T_arzmsfzign, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = f_h52que6jrj<T0>(arg0, arg1, arg2);
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        let v1 = T_h2souqyp33{
            amount    : arg2,
            recipient : @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292,
        };
        0x2::event::emit<T_h2souqyp33>(v1);
        0x2::balance::send_funds<T0>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun f_tum4tgj4gf<T0>(arg0: &mut T_n6yfjf4st4, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun f_xekghjajrc<T0>(arg0: &T_n6yfjf4st4) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

