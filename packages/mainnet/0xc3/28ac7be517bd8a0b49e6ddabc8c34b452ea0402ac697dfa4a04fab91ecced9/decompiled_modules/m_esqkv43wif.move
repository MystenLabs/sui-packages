module 0xc328ac7be517bd8a0b49e6ddabc8c34b452ea0402ac697dfa4a04fab91ecced9::m_esqkv43wif {
    struct T_eymyp26luc has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct T_x6creoqoqf has key {
        id: 0x2::object::UID,
        keeper_cap_id: 0x2::object::ID,
        profit_recipient: address,
        balances: 0x2::bag::Bag,
    }

    struct T_42anmcbufl has copy, drop {
        vault_id: 0x2::object::ID,
        keeper_cap_id: 0x2::object::ID,
        owner: address,
        profit_recipient: address,
    }

    struct T_b6lltnaz7f has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun f_6nao3vve6j(arg0: &T_x6creoqoqf) : address {
        arg0.profit_recipient
    }

    public entry fun f_7jcvsx2qsd(arg0: &mut T_x6creoqoqf, arg1: &T_eymyp26luc) {
        f_mvpbxrwp6t(arg0, arg1);
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        arg0.profit_recipient = @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498;
    }

    public fun f_bunqdgjwgv<T0>(arg0: &mut T_x6creoqoqf, arg1: &T_eymyp26luc, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = f_zx4fevae2t<T0>(arg0, arg1, arg2);
        assert!(arg0.profit_recipient == @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, 2);
        let v1 = T_b6lltnaz7f{
            amount    : arg2,
            recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        0x2::event::emit<T_b6lltnaz7f>(v1);
        0x2::balance::send_funds<T0>(v0, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
    }

    public fun f_hsidcwce5z<T0>(arg0: &T_x6creoqoqf) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun f_lu2j6kr454<T0>(arg0: &mut T_x6creoqoqf, arg1: 0x2::coin::Coin<T0>) {
        f_wcgnimm5d5<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    fun f_mvpbxrwp6t(arg0: &T_x6creoqoqf, arg1: &T_eymyp26luc) {
        assert!(0x2::object::id<T_eymyp26luc>(arg1) == arg0.keeper_cap_id, 0);
        assert!(arg1.vault_id == 0x2::object::id<T_x6creoqoqf>(arg0), 0);
    }

    public entry fun f_q6ugbxjqvm(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        assert!(arg0 == @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, 2);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = T_eymyp26luc{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        let v3 = 0x2::object::id<T_eymyp26luc>(&v2);
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = T_x6creoqoqf{
            id               : v0,
            keeper_cap_id    : v3,
            profit_recipient : arg0,
            balances         : 0x2::bag::new(arg1),
        };
        let v6 = T_42anmcbufl{
            vault_id         : v1,
            keeper_cap_id    : v3,
            owner            : v4,
            profit_recipient : arg0,
        };
        0x2::event::emit<T_42anmcbufl>(v6);
        0x2::transfer::public_transfer<T_eymyp26luc>(v2, v4);
        0x2::transfer::share_object<T_x6creoqoqf>(v5);
    }

    public fun f_wcgnimm5d5<T0>(arg0: &mut T_x6creoqoqf, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun f_zx4fevae2t<T0>(arg0: &mut T_x6creoqoqf, arg1: &T_eymyp26luc, arg2: u64) : 0x2::balance::Balance<T0> {
        f_mvpbxrwp6t(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1);
        0x2::balance::split<T0>(v1, arg2)
    }

    // decompiled from Move bytecode v7
}

