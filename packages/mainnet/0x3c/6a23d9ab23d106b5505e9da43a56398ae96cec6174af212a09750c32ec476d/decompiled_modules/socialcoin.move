module 0x3c6a23d9ab23d106b5505e9da43a56398ae96cec6174af212a09750c32ec476d::socialcoin {
    struct SOCIALCOIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        shares: 0x2::table::Table<address, Shares>,
        config: Config,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Shares has store {
        holders: 0x2::table::Table<address, u64>,
        supply: u64,
        holding: 0x2::table::Table<address, u64>,
    }

    struct Config has store {
        protocol_fee_destination: address,
        protocol_fee_percent: u64,
        subject_fee_percent: u64,
    }

    struct TradeEvent has copy, drop {
        trader: address,
        subject: address,
        is_buy: bool,
        share_amount: u64,
        sui_amount: u64,
        protocol_sui_amount: u64,
        subject_sui_amount: u64,
        supply: u64,
    }

    public fun buy_shares(arg0: &mut Global, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        ensure_share_created(arg0, arg1, arg4);
        let v1 = 0x2::table::borrow_mut<address, Shares>(&mut arg0.shares, arg1);
        let v2 = v1.supply;
        assert!(v2 > 0 || v0 == arg1, 1);
        let v3 = get_price(v2, arg2);
        let v4 = v3 * arg0.config.protocol_fee_percent / 1000000000;
        let v5 = v3 * arg0.config.subject_fee_percent / 1000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v3 + v4 + v5, 2);
        let v6 = &mut v1.holders;
        change_table_value(v6, v0, arg2, true);
        v1.supply = v2 + arg2;
        change_holding_data(arg0, v0, arg1, arg2, true, arg4);
        let v7 = TradeEvent{
            trader              : v0,
            subject             : arg1,
            is_buy              : true,
            share_amount        : arg2,
            sui_amount          : v3,
            protocol_sui_amount : v4,
            subject_sui_amount  : v5,
            supply              : v2 + arg2,
        };
        0x2::event::emit<TradeEvent>(v7);
        if (v3 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3, arg4)));
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v4, arg4), arg0.config.protocol_fee_destination);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg4), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
    }

    fun change_holding_data(arg0: &mut Global, arg1: address, arg2: address, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            ensure_share_created(arg0, arg1, arg5);
        };
        let v0 = &mut 0x2::table::borrow_mut<address, Shares>(&mut arg0.shares, arg1).holding;
        change_table_value(v0, arg2, arg3, arg4);
    }

    fun change_table_value(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64, arg3: bool) {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            0x2::table::add<address, u64>(arg0, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        if (arg3) {
            *v0 = *v0 + arg2;
        } else {
            *v0 = *v0 - arg2;
            if (*v0 == 0) {
                0x2::table::remove<address, u64>(arg0, arg1);
            };
        };
    }

    fun ensure_share_created(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, Shares>(&arg0.shares, arg1)) {
            let v0 = Shares{
                holders : 0x2::table::new<address, u64>(arg2),
                supply  : 0,
                holding : 0x2::table::new<address, u64>(arg2),
            };
            0x2::table::add<address, Shares>(&mut arg0.shares, arg1, v0);
        };
    }

    public fun get_buy_price(arg0: &Global, arg1: address, arg2: u64) : u64 {
        let v0 = 0;
        if (0x2::table::contains<address, Shares>(&arg0.shares, arg1)) {
            v0 = 0x2::table::borrow<address, Shares>(&arg0.shares, arg1).supply;
        };
        get_price(v0, arg2)
    }

    public fun get_buy_price_after_fee(arg0: &Global, arg1: address, arg2: u64) : u64 {
        let v0 = get_buy_price(arg0, arg1, arg2);
        v0 + v0 * arg0.config.protocol_fee_percent / 1000000000 + v0 * arg0.config.subject_fee_percent / 1000000000
    }

    public fun get_price(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) * arg0 * (2 * (arg0 - 1) + 1) / 6
        };
        let v1 = if (arg0 == 0 && arg1 == 1) {
            0
        } else {
            (arg0 - 1 + arg1) * (arg0 + arg1) * (2 * (arg0 - 1 + arg1) + 1) / 6
        };
        (v1 - v0) * 100000000
    }

    public fun get_sell_price(arg0: &Global, arg1: address, arg2: u64) : u64 {
        get_price(0x2::table::borrow<address, Shares>(&arg0.shares, arg1).supply - arg2, arg2)
    }

    public fun get_sell_price_after_fee(arg0: &Global, arg1: address, arg2: u64) : u64 {
        let v0 = get_sell_price(arg0, arg1, arg2);
        v0 - v0 * arg0.config.protocol_fee_percent / 1000000000 - v0 * arg0.config.subject_fee_percent / 1000000000
    }

    fun init(arg0: SOCIALCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<SOCIALCOIN>(arg0, arg1), 0x2::tx_context::sender(arg1));
        init_social_coin(arg1);
    }

    fun init_social_coin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            protocol_fee_destination : 0x2::tx_context::sender(arg0),
            protocol_fee_percent     : 10000000,
            subject_fee_percent      : 10000000,
        };
        let v2 = Global{
            id     : 0x2::object::new(arg0),
            shares : 0x2::table::new<address, Shares>(arg0),
            config : v1,
            vault  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Global>(v2);
    }

    public fun sell_shares(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, Shares>(&arg0.shares, arg1), 3);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<address, Shares>(&mut arg0.shares, arg1);
        let v2 = v1.supply;
        assert!(v2 >= arg2, 5);
        let v3 = get_price(v2 - arg2, arg2);
        let v4 = v3 * arg0.config.protocol_fee_percent / 1000000000;
        let v5 = v3 * arg0.config.subject_fee_percent / 1000000000;
        let v6 = 0x2::table::borrow_mut<address, u64>(&mut v1.holders, v0);
        assert!(*v6 >= arg2, 4);
        *v6 = *v6 - arg2;
        v1.supply = v2 - arg2;
        change_holding_data(arg0, v0, arg1, arg2, false, arg3);
        let v7 = TradeEvent{
            trader              : v0,
            subject             : arg1,
            is_buy              : false,
            share_amount        : arg2,
            sui_amount          : v3,
            protocol_sui_amount : v4,
            subject_sui_amount  : v5,
            supply              : v2 - arg2,
        };
        0x2::event::emit<TradeEvent>(v7);
        let v8 = arg0.config.protocol_fee_destination;
        transfer_from_vault(arg0, v3 - v4 - v5, v0, arg3);
        transfer_from_vault(arg0, v5, arg1, arg3);
        transfer_from_vault(arg0, v4, v8, arg3);
    }

    fun transfer_from_vault(arg0: &mut Global, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1), arg3), arg2);
    }

    public fun update_config(arg0: &mut Global, arg1: &AdminCap, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.config.protocol_fee_destination = arg2;
        arg0.config.protocol_fee_percent = arg3;
        arg0.config.subject_fee_percent = arg4;
    }

    // decompiled from Move bytecode v6
}

