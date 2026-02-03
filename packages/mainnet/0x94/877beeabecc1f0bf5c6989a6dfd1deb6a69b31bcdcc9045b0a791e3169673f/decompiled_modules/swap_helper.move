module 0x94877beeabecc1f0bf5c6989a6dfd1deb6a69b31bcdcc9045b0a791e3169673f::swap_helper {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SwapRecord has copy, drop, store {
        user: address,
        from_coin: 0x1::ascii::String,
        to_coin: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        timestamp: u64,
    }

    struct UserStats has store {
        total_swaps: u64,
        total_volume_in: u64,
        total_volume_out: u64,
        last_swap_time: u64,
    }

    struct SwapRegistry has key {
        id: 0x2::object::UID,
        swap_records: 0x2::table::Table<u64, SwapRecord>,
        user_stats: 0x2::table::Table<address, UserStats>,
        total_swaps: u64,
        total_volume: u64,
    }

    struct SwapReceipt has store, key {
        id: 0x2::object::UID,
        user: address,
        from_coin: 0x1::ascii::String,
        to_coin: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        route: 0x1::ascii::String,
        timestamp: u64,
    }

    struct ZapReceipt has store, key {
        id: 0x2::object::UID,
        user: address,
        recipient: address,
        from_coin: 0x1::ascii::String,
        to_coin: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        route: 0x1::ascii::String,
        timestamp: u64,
    }

    struct SwapEvent has copy, drop {
        user: address,
        from_coin: 0x1::ascii::String,
        to_coin: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        timestamp: u64,
    }

    struct UserStatsUpdated has copy, drop {
        user: address,
        total_swaps: u64,
        total_volume_in: u64,
        total_volume_out: u64,
    }

    struct RegistryInitialized has copy, drop {
        admin: address,
        timestamp: u64,
    }

    struct TransferEvent has copy, drop {
        sender: address,
        recipient: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        memo: 0x1::ascii::String,
        timestamp: u64,
    }

    struct SwapReceiptMinted has copy, drop {
        receipt_id: 0x2::object::ID,
        user: address,
        from_coin: 0x1::ascii::String,
        to_coin: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        route: 0x1::ascii::String,
        timestamp: u64,
    }

    struct ZapReceiptMinted has copy, drop {
        receipt_id: 0x2::object::ID,
        user: address,
        recipient: address,
        from_coin: 0x1::ascii::String,
        to_coin: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        route: 0x1::ascii::String,
        timestamp: u64,
    }

    public fun execute_swap<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut SwapRegistry, arg4: 0x1::ascii::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x2::tx_context::epoch(arg5);
        let v4 = SwapRecord{
            user       : v0,
            from_coin  : v2,
            to_coin    : arg4,
            amount_in  : v1,
            amount_out : arg2,
            timestamp  : v3,
        };
        0x2::table::add<u64, SwapRecord>(&mut arg3.swap_records, arg3.total_swaps, v4);
        arg3.total_swaps = arg3.total_swaps + 1;
        arg3.total_volume = arg3.total_volume + v1;
        if (0x2::table::contains<address, UserStats>(&arg3.user_stats, v0)) {
            let v5 = 0x2::table::borrow_mut<address, UserStats>(&mut arg3.user_stats, v0);
            v5.total_swaps = v5.total_swaps + 1;
            v5.total_volume_in = v5.total_volume_in + v1;
            v5.total_volume_out = v5.total_volume_out + arg2;
            v5.last_swap_time = v3;
            let v6 = UserStatsUpdated{
                user             : v0,
                total_swaps      : v5.total_swaps,
                total_volume_in  : v5.total_volume_in,
                total_volume_out : v5.total_volume_out,
            };
            0x2::event::emit<UserStatsUpdated>(v6);
        } else {
            let v7 = UserStats{
                total_swaps      : 1,
                total_volume_in  : v1,
                total_volume_out : arg2,
                last_swap_time   : v3,
            };
            0x2::table::add<address, UserStats>(&mut arg3.user_stats, v0, v7);
            let v8 = UserStatsUpdated{
                user             : v0,
                total_swaps      : 1,
                total_volume_in  : v1,
                total_volume_out : arg2,
            };
            0x2::event::emit<UserStatsUpdated>(v8);
        };
        let v9 = SwapEvent{
            user       : v0,
            from_coin  : v2,
            to_coin    : arg4,
            amount_in  : v1,
            amount_out : arg2,
            timestamp  : v3,
        };
        0x2::event::emit<SwapEvent>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun get_user_stats(arg0: &SwapRegistry, arg1: address) : (u64, u64, u64, u64) {
        if (0x2::table::contains<address, UserStats>(&arg0.user_stats, arg1)) {
            let v4 = 0x2::table::borrow<address, UserStats>(&arg0.user_stats, arg1);
            (v4.total_swaps, v4.total_volume_in, v4.total_volume_out, v4.last_swap_time)
        } else {
            (0, 0, 0, 0)
        }
    }

    public fun init_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = SwapRegistry{
            id           : 0x2::object::new(arg0),
            swap_records : 0x2::table::new<u64, SwapRecord>(arg0),
            user_stats   : 0x2::table::new<address, UserStats>(arg0),
            total_swaps  : 0,
            total_volume : 0,
        };
        let v2 = RegistryInitialized{
            admin     : 0x2::tx_context::sender(arg0),
            timestamp : 0x2::tx_context::epoch(arg0),
        };
        0x2::event::emit<RegistryInitialized>(v2);
        0x2::transfer::share_object<SwapRegistry>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_swap_receipt(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: 0x1::ascii::String, arg5: &mut 0x2::tx_context::TxContext) : SwapReceipt {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch(arg5);
        let v2 = SwapReceipt{
            id         : 0x2::object::new(arg5),
            user       : v0,
            from_coin  : arg0,
            to_coin    : arg1,
            amount_in  : arg2,
            amount_out : arg3,
            route      : arg4,
            timestamp  : v1,
        };
        let v3 = SwapReceiptMinted{
            receipt_id : 0x2::object::id<SwapReceipt>(&v2),
            user       : v0,
            from_coin  : arg0,
            to_coin    : arg1,
            amount_in  : arg2,
            amount_out : arg3,
            route      : arg4,
            timestamp  : v1,
        };
        0x2::event::emit<SwapReceiptMinted>(v3);
        v2
    }

    public fun mint_zap_receipt(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: 0x1::ascii::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : ZapReceipt {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch(arg6);
        let v2 = ZapReceipt{
            id         : 0x2::object::new(arg6),
            user       : v0,
            recipient  : arg5,
            from_coin  : arg0,
            to_coin    : arg1,
            amount_in  : arg2,
            amount_out : arg3,
            route      : arg4,
            timestamp  : v1,
        };
        let v3 = ZapReceiptMinted{
            receipt_id : 0x2::object::id<ZapReceipt>(&v2),
            user       : v0,
            recipient  : arg5,
            from_coin  : arg0,
            to_coin    : arg1,
            amount_in  : arg2,
            amount_out : arg3,
            route      : arg4,
            timestamp  : v1,
        };
        0x2::event::emit<ZapReceiptMinted>(v3);
        v2
    }

    public fun record_swap_event(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapEvent{
            user       : 0x2::tx_context::sender(arg4),
            from_coin  : arg0,
            to_coin    : arg1,
            amount_in  : arg2,
            amount_out : arg3,
            timestamp  : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public fun transfer_coin_with_memo<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferEvent{
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg1,
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount    : 0x2::coin::value<T0>(&arg0),
            memo      : arg2,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<TransferEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

