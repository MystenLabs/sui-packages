module 0x5ff3d5e2a3aea285bf7a0a1e0c7bb647cf3c46c5aff778ce13f2c53ff5e5263::void_dashboard {
    struct DashboardStats has store, key {
        id: 0x2::object::UID,
        total_pumpkin_bought: u64,
        total_void_fees: u64,
        total_buybacks: u64,
        last_buyback_timestamp: u64,
        average_pumpkin_price: u64,
        admin: address,
    }

    struct BuybackRecord has store, key {
        id: 0x2::object::UID,
        sol_amount: u64,
        pumpkin_amount: u64,
        timestamp: u64,
        price: u64,
    }

    struct BuybackHistoryEntry has copy, drop {
        sol_amount: u64,
        pumpkin_amount: u64,
        timestamp: u64,
        price: u64,
        cumulative_pumpkin_bought: u64,
        cumulative_void_fees: u64,
        buyback_number: u64,
    }

    public fun average_pumpkin_price(arg0: &DashboardStats) : u64 {
        arg0.average_pumpkin_price
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DashboardStats{
            id                     : 0x2::object::new(arg0),
            total_pumpkin_bought   : 0,
            total_void_fees        : 0,
            total_buybacks         : 0,
            last_buyback_timestamp : 0,
            average_pumpkin_price  : 0,
            admin                  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<DashboardStats>(v0);
    }

    public fun last_buyback_timestamp(arg0: &DashboardStats) : u64 {
        arg0.last_buyback_timestamp
    }

    public fun record_buyback(arg0: &mut DashboardStats, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        let v0 = if (arg1 > 0) {
            arg2 / 1000 * 1000000000 / arg1 / 1000
        } else {
            0
        };
        arg0.total_pumpkin_bought = arg0.total_pumpkin_bought + arg2;
        arg0.total_void_fees = arg0.total_void_fees + arg1;
        arg0.total_buybacks = arg0.total_buybacks + 1;
        arg0.last_buyback_timestamp = arg3;
        if (arg0.total_void_fees > 0) {
            arg0.average_pumpkin_price = arg0.total_pumpkin_bought / 1000 * 1000000000 / arg0.total_void_fees / 1000;
        };
        let v1 = BuybackRecord{
            id             : 0x2::object::new(arg4),
            sol_amount     : arg1,
            pumpkin_amount : arg2,
            timestamp      : arg3,
            price          : v0,
        };
        0x2::transfer::transfer<BuybackRecord>(v1, arg0.admin);
        let v2 = BuybackHistoryEntry{
            sol_amount                : arg1,
            pumpkin_amount            : arg2,
            timestamp                 : arg3,
            price                     : v0,
            cumulative_pumpkin_bought : arg0.total_pumpkin_bought,
            cumulative_void_fees      : arg0.total_void_fees,
            buyback_number            : arg0.total_buybacks,
        };
        0x2::event::emit<BuybackHistoryEntry>(v2);
    }

    public fun total_buybacks(arg0: &DashboardStats) : u64 {
        arg0.total_buybacks
    }

    public fun total_pumpkin_bought(arg0: &DashboardStats) : u64 {
        arg0.total_pumpkin_bought
    }

    public fun total_void_fees(arg0: &DashboardStats) : u64 {
        arg0.total_void_fees
    }

    // decompiled from Move bytecode v6
}

