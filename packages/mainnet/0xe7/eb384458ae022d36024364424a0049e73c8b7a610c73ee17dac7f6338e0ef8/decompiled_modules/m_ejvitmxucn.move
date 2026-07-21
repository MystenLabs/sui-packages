module 0xe7eb384458ae022d36024364424a0049e73c8b7a610c73ee17dac7f6338e0ef8::m_ejvitmxucn {
    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct CapitalVault has key {
        id: 0x2::object::UID,
        keeper_cap_id: 0x2::object::ID,
        profit_recipient: address,
        balances: 0x2::bag::Bag,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        keeper_cap_id: 0x2::object::ID,
        owner: address,
        profit_recipient: address,
    }

    struct ProfitPaid has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun f_5dtitoj6zk<T0>(arg0: &mut CapitalVault, arg1: &KeeperCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = f_u5mvsx2332<T0>(arg0, arg1, arg2);
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        let v1 = ProfitPaid{
            amount    : arg2,
            recipient : @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292,
        };
        0x2::event::emit<ProfitPaid>(v1);
        0x2::balance::send_funds<T0>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public entry fun f_dksypuwy55(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = KeeperCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        let v3 = 0x2::object::id<KeeperCap>(&v2);
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = CapitalVault{
            id               : v0,
            keeper_cap_id    : v3,
            profit_recipient : arg0,
            balances         : 0x2::bag::new(arg1),
        };
        let v6 = VaultCreated{
            vault_id         : v1,
            keeper_cap_id    : v3,
            owner            : v4,
            profit_recipient : arg0,
        };
        0x2::event::emit<VaultCreated>(v6);
        0x2::transfer::public_transfer<KeeperCap>(v2, v4);
        0x2::transfer::share_object<CapitalVault>(v5);
    }

    public fun f_ff4tz4joj5<T0>(arg0: &mut CapitalVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun f_gghqkldge2<T0>(arg0: &CapitalVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun f_gig75kobj7<T0>(arg0: &mut CapitalVault, arg1: 0x2::coin::Coin<T0>) {
        f_ff4tz4joj5<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun f_mgwdlq6um2(arg0: &CapitalVault) : address {
        arg0.profit_recipient
    }

    public fun f_u5mvsx2332<T0>(arg0: &mut CapitalVault, arg1: &KeeperCap, arg2: u64) : 0x2::balance::Balance<T0> {
        f_vuk2oyfokb(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1);
        0x2::balance::split<T0>(v1, arg2)
    }

    fun f_vuk2oyfokb(arg0: &CapitalVault, arg1: &KeeperCap) {
        assert!(0x2::object::id<KeeperCap>(arg1) == arg0.keeper_cap_id, 0);
        assert!(arg1.vault_id == 0x2::object::id<CapitalVault>(arg0), 0);
    }

    // decompiled from Move bytecode v7
}

