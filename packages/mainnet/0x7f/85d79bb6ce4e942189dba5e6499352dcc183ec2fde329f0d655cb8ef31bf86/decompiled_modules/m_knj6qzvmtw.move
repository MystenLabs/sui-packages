module 0x7f85d79bb6ce4e942189dba5e6499352dcc183ec2fde329f0d655cb8ef31bf86::m_knj6qzvmtw {
    struct T_dk3zo3wq5s has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct T_jgvwn4z2nj has key {
        id: 0x2::object::UID,
        keeper_cap_id: 0x2::object::ID,
        profit_recipient: address,
        balances: 0x2::bag::Bag,
    }

    struct T_j4qxwismw3 has copy, drop {
        vault_id: 0x2::object::ID,
        keeper_cap_id: 0x2::object::ID,
        owner: address,
        profit_recipient: address,
    }

    struct T_ezrczkgytg has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun f_a3uwt3lypo<T0>(arg0: &mut T_jgvwn4z2nj, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun f_dhfatziqe2<T0>(arg0: &T_jgvwn4z2nj) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun f_f2lyhj2gbn<T0>(arg0: &mut T_jgvwn4z2nj, arg1: &T_dk3zo3wq5s, arg2: u64) : 0x2::balance::Balance<T0> {
        f_heektarny3(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 1);
        0x2::balance::split<T0>(v1, arg2)
    }

    public fun f_guxg3bt4an(arg0: &T_jgvwn4z2nj) : address {
        arg0.profit_recipient
    }

    fun f_heektarny3(arg0: &T_jgvwn4z2nj, arg1: &T_dk3zo3wq5s) {
        assert!(0x2::object::id<T_dk3zo3wq5s>(arg1) == arg0.keeper_cap_id, 0);
        assert!(arg1.vault_id == 0x2::object::id<T_jgvwn4z2nj>(arg0), 0);
    }

    public fun f_hzwqxfww74<T0>(arg0: &mut T_jgvwn4z2nj, arg1: 0x2::coin::Coin<T0>) {
        f_a3uwt3lypo<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun f_vgchbcdsyz<T0>(arg0: &mut T_jgvwn4z2nj, arg1: &T_dk3zo3wq5s, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = f_f2lyhj2gbn<T0>(arg0, arg1, arg2);
        assert!(arg0.profit_recipient == @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, 2);
        let v1 = T_ezrczkgytg{
            amount    : arg2,
            recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        0x2::event::emit<T_ezrczkgytg>(v1);
        0x2::balance::send_funds<T0>(v0, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
    }

    public entry fun f_vn3xqdtmjr(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        assert!(arg0 == @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, 2);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = T_dk3zo3wq5s{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        let v3 = 0x2::object::id<T_dk3zo3wq5s>(&v2);
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = T_jgvwn4z2nj{
            id               : v0,
            keeper_cap_id    : v3,
            profit_recipient : arg0,
            balances         : 0x2::bag::new(arg1),
        };
        let v6 = T_j4qxwismw3{
            vault_id         : v1,
            keeper_cap_id    : v3,
            owner            : v4,
            profit_recipient : arg0,
        };
        0x2::event::emit<T_j4qxwismw3>(v6);
        0x2::transfer::public_transfer<T_dk3zo3wq5s>(v2, v4);
        0x2::transfer::share_object<T_jgvwn4z2nj>(v5);
    }

    public entry fun f_xhblq5s46m(arg0: &mut T_jgvwn4z2nj, arg1: &T_dk3zo3wq5s) {
        f_heektarny3(arg0, arg1);
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        arg0.profit_recipient = @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498;
    }

    // decompiled from Move bytecode v7
}

