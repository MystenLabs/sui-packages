module 0x8ab7ea0f4dadfc771306ca8ea0a5b97dd093928628b192578f82aa37324cc053::m_2uosyn2i4w {
    struct T_xecq4ixpmo has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct T_mucg2mizpx has key {
        id: 0x2::object::UID,
        keeper_cap_id: 0x2::object::ID,
        profit_recipient: address,
        balances: 0x2::bag::Bag,
    }

    struct T_j4gcbbhdao has copy, drop {
        vault_id: 0x2::object::ID,
        keeper_cap_id: 0x2::object::ID,
        owner: address,
        profit_recipient: address,
    }

    struct T_ukjcohtakf has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun f_54kee3yo22<T0>(arg0: &mut T_mucg2mizpx, arg1: &T_xecq4ixpmo, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = f_rz6vrvonsq<T0>(arg0, arg1, arg2);
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        let v1 = T_ukjcohtakf{
            amount    : arg2,
            recipient : @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292,
        };
        0x2::event::emit<T_ukjcohtakf>(v1);
        0x2::balance::send_funds<T0>(v0, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public entry fun f_55kgw34nxm(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = T_xecq4ixpmo{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        let v3 = 0x2::object::id<T_xecq4ixpmo>(&v2);
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = T_mucg2mizpx{
            id               : v0,
            keeper_cap_id    : v3,
            profit_recipient : arg0,
            balances         : 0x2::bag::new(arg1),
        };
        let v6 = T_j4gcbbhdao{
            vault_id         : v1,
            keeper_cap_id    : v3,
            owner            : v4,
            profit_recipient : arg0,
        };
        0x2::event::emit<T_j4gcbbhdao>(v6);
        0x2::transfer::public_transfer<T_xecq4ixpmo>(v2, v4);
        0x2::transfer::share_object<T_mucg2mizpx>(v5);
    }

    fun f_h6oh7lsxid(arg0: &T_mucg2mizpx, arg1: &T_xecq4ixpmo) {
        assert!(0x2::object::id<T_xecq4ixpmo>(arg1) == arg0.keeper_cap_id, 0);
        assert!(arg1.vault_id == 0x2::object::id<T_mucg2mizpx>(arg0), 0);
    }

    public fun f_mixsot2gxe<T0>(arg0: &mut T_mucg2mizpx, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun f_rz6vrvonsq<T0>(arg0: &mut T_mucg2mizpx, arg1: &T_xecq4ixpmo, arg2: u64) : 0x2::balance::Balance<T0> {
        f_h6oh7lsxid(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1);
        0x2::balance::split<T0>(v1, arg2)
    }

    public fun f_sagrpv4wkd<T0>(arg0: &mut T_mucg2mizpx, arg1: 0x2::coin::Coin<T0>) {
        f_mixsot2gxe<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun f_twjd7h4ivi(arg0: &T_mucg2mizpx) : address {
        arg0.profit_recipient
    }

    public fun f_voq22mhe7e<T0>(arg0: &T_mucg2mizpx) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

