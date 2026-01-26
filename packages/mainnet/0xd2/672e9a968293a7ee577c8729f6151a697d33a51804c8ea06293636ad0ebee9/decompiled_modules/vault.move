module 0xd2672e9a968293a7ee577c8729f6151a697d33a51804c8ea06293636ad0ebee9::vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
    }

    struct TraderCap has store, key {
        id: 0x2::object::UID,
        owner: address,
        profit_address: address,
        positions: 0x2::table::Table<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        created: address,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut VaultRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: u64, arg5: u64, arg6: u64, arg7: &mut Vault<T0>, arg8: &mut Vault<T1>, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x2::dynamic_field::exists_with_type<address, TraderCap>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow_mut<address, TraderCap>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg10) == v1.owner, 4);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2));
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg2, v2, v2 + 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg2), arg10);
        let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg1, arg3, arg2, &mut v3, 0x2::balance::split<T0>(&mut arg7.balance, arg4), 0x2::balance::split<T1>(&mut arg8.balance, arg5), arg6, arg9);
        0x2::balance::join<T0>(&mut arg7.balance, v6);
        0x2::balance::join<T1>(&mut arg8.balance, v7);
        let v8 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v3);
        0x2::table::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut v1.positions, v8, v3);
        v8
    }

    public fun close_position<T0, T1, T2, T3>(arg0: &mut VaultRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: 0x2::object::ID, arg5: &mut Vault<T0>, arg6: &mut Vault<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::dynamic_field::exists_with_type<address, TraderCap>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow_mut<address, TraderCap>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg7) == v1.owner, 4);
        let v2 = v1.profit_address;
        let v3 = 0x2::table::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut v1.positions, arg4);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg1, arg3, arg2, &mut v3);
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg7), v2);
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T3>(arg1, arg3, arg2, &mut v3);
        if (0x2::balance::value<T3>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(v5, arg7), v2);
        } else {
            0x2::balance::destroy_zero<T3>(v5);
        };
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v3);
        let (v7, v8) = if (v6 > 0) {
            let (_, _, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg2, &mut v3, v6, arg1);
            (v11, v12)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v13 = v8;
        let v14 = v7;
        let (_, _, v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg1, arg3, arg2, &mut v3);
        0x2::balance::join<T0>(&mut v14, v17);
        0x2::balance::join<T1>(&mut v13, v18);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg1, arg3, arg2, v3);
        0x2::balance::join<T0>(&mut arg5.balance, v14);
        0x2::balance::join<T1>(&mut arg6.balance, v13);
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
            created : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = DepositEvent{
            vault_id : 0x2::object::id<Vault<T0>>(arg0),
            amount   : v0,
            sender   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = VaultRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<VaultRegistry>(v1);
    }

    public fun new_trader(arg0: &AdminCap, arg1: &mut VaultRegistry, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_with_type<address, TraderCap>(&arg1.id, arg2), 5);
        let v0 = TraderCap{
            id             : 0x2::object::new(arg4),
            owner          : arg2,
            profit_address : arg3,
            positions      : 0x2::table::new<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4),
        };
        0x2::dynamic_field::add<address, TraderCap>(&mut arg1.id, arg2, v0);
    }

    public fun revoke_trader(arg0: &AdminCap, arg1: &mut VaultRegistry, arg2: address, arg3: address) {
        let v0 = 0x2::dynamic_field::remove<address, TraderCap>(&mut arg1.id, arg2);
        v0.owner = arg3;
        0x2::dynamic_field::add<address, TraderCap>(&mut arg1.id, arg3, v0);
    }

    public fun update_trader_profit_address(arg0: &AdminCap, arg1: &mut VaultRegistry, arg2: address, arg3: address) {
        0x2::dynamic_field::borrow_mut<address, TraderCap>(&mut arg1.id, arg2).profit_address = arg3;
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = WithdrawEvent{
            vault_id  : 0x2::object::id<Vault<T0>>(arg1),
            amount    : arg2,
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

