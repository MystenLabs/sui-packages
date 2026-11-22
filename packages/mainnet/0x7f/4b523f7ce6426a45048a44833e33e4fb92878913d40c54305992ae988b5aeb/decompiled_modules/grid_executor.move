module 0x7f4b523f7ce6426a45048a44833e33e4fb92878913d40c54305992ae988b5aeb::grid_executor {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GridVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        quote_reserve: 0x2::balance::Balance<T1>,
        total_trades: u64,
        last_open_ms: u64,
    }

    struct CycleExecuted has copy, drop {
        pair_tag: vector<u8>,
        net_profit: u64,
        timestamp_ms: u64,
    }

    public entry fun create_vault<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GridVault<T0, T1>{
            id            : 0x2::object::new(arg1),
            owner         : 0x2::tx_context::sender(arg1),
            quote_reserve : 0x2::balance::zero<T1>(),
            total_trades  : 0,
            last_open_ms  : 0,
        };
        0x2::transfer::share_object<GridVault<T0, T1>>(v0);
    }

    public entry fun emergency_withdraw<T0, T1>(arg0: &AdminCap, arg1: &mut GridVault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 1);
        let v0 = 0x2::balance::value<T1>(&arg1.quote_reserve);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.quote_reserve, v0), arg2), arg1.owner);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun settle_tick_cycle<T0, T1>(arg0: &AdminCap, arg1: &mut GridVault<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg1.owner, 1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 >= arg3 + arg4, 2);
        let v1 = v0 - arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v1, arg7), arg1.owner);
        0x2::balance::join<T1>(&mut arg1.quote_reserve, 0x2::coin::into_balance<T1>(arg2));
        arg1.total_trades = arg1.total_trades + 1;
        arg1.last_open_ms = 0x2::clock::timestamp_ms(arg6);
        let v2 = CycleExecuted{
            pair_tag     : arg5,
            net_profit   : v1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CycleExecuted>(v2);
    }

    // decompiled from Move bytecode v7
}

