module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::analytics {
    struct MarketplaceStats has drop, store {
        total_sales: u64,
        total_volume: u64,
        total_listings: u64,
        total_collections: u64,
        unique_buyers: u64,
        unique_sellers: u64,
    }

    struct DailyStats has copy, drop, store {
        date: u64,
        sales_count: u64,
        volume: u64,
        unique_buyers: u64,
        unique_sellers: u64,
        avg_sale_price: u64,
    }

    struct UserStats has copy, drop, store {
        address: address,
        total_bought: u64,
        total_sold: u64,
        volume_bought: u64,
        volume_sold: u64,
        first_trade_time: u64,
        last_trade_time: u64,
    }

    struct Analytics has store {
        marketplace_stats: MarketplaceStats,
        daily_stats: 0x2::table::Table<u64, DailyStats>,
        user_stats: 0x2::table::Table<address, UserStats>,
        top_collections_by_volume: vector<0x2::object::ID>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Analytics {
        let v0 = MarketplaceStats{
            total_sales       : 0,
            total_volume      : 0,
            total_listings    : 0,
            total_collections : 0,
            unique_buyers     : 0,
            unique_sellers    : 0,
        };
        Analytics{
            marketplace_stats         : v0,
            daily_stats               : 0x2::table::new<u64, DailyStats>(arg0),
            user_stats                : 0x2::table::new<address, UserStats>(arg0),
            top_collections_by_volume : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun daily_avg_sale_price(arg0: &DailyStats) : u64 {
        arg0.avg_sale_price
    }

    public fun daily_date(arg0: &DailyStats) : u64 {
        arg0.date
    }

    public fun daily_sales_count(arg0: &DailyStats) : u64 {
        arg0.sales_count
    }

    public fun daily_unique_buyers(arg0: &DailyStats) : u64 {
        arg0.unique_buyers
    }

    public fun daily_unique_sellers(arg0: &DailyStats) : u64 {
        arg0.unique_sellers
    }

    public fun daily_volume(arg0: &DailyStats) : u64 {
        arg0.volume
    }

    public fun get_daily_stats(arg0: &Analytics, arg1: u64) : DailyStats {
        assert!(0x2::table::contains<u64, DailyStats>(&arg0.daily_stats, arg1), 0);
        *0x2::table::borrow<u64, DailyStats>(&arg0.daily_stats, arg1)
    }

    public fun get_marketplace_stats(arg0: &Analytics) : &MarketplaceStats {
        &arg0.marketplace_stats
    }

    public fun get_user_stats(arg0: &Analytics, arg1: address) : UserStats {
        assert!(0x2::table::contains<address, UserStats>(&arg0.user_stats, arg1), 0);
        *0x2::table::borrow<address, UserStats>(&arg0.user_stats, arg1)
    }

    public fun has_daily_stats(arg0: &Analytics, arg1: u64) : bool {
        0x2::table::contains<u64, DailyStats>(&arg0.daily_stats, arg1)
    }

    public fun has_user_stats(arg0: &Analytics, arg1: address) : bool {
        0x2::table::contains<address, UserStats>(&arg0.user_stats, arg1)
    }

    public fun marketplace_total_collections(arg0: &MarketplaceStats) : u64 {
        arg0.total_collections
    }

    public fun marketplace_total_listings(arg0: &MarketplaceStats) : u64 {
        arg0.total_listings
    }

    public fun marketplace_total_sales(arg0: &MarketplaceStats) : u64 {
        arg0.total_sales
    }

    public fun marketplace_total_volume(arg0: &MarketplaceStats) : u64 {
        arg0.total_volume
    }

    public fun marketplace_unique_buyers(arg0: &MarketplaceStats) : u64 {
        arg0.unique_buyers
    }

    public fun marketplace_unique_sellers(arg0: &MarketplaceStats) : u64 {
        arg0.unique_sellers
    }

    public(friend) fun record_collection(arg0: &mut Analytics) {
        arg0.marketplace_stats.total_collections = arg0.marketplace_stats.total_collections + 1;
    }

    public(friend) fun record_listing(arg0: &mut Analytics) {
        arg0.marketplace_stats.total_listings = arg0.marketplace_stats.total_listings + 1;
    }

    public(friend) fun record_listing_cancellation(arg0: &mut Analytics) {
        if (arg0.marketplace_stats.total_listings > 0) {
            arg0.marketplace_stats.total_listings = arg0.marketplace_stats.total_listings - 1;
        };
    }

    public(friend) fun record_sale(arg0: &mut Analytics, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        arg0.marketplace_stats.total_sales = arg0.marketplace_stats.total_sales + 1;
        arg0.marketplace_stats.total_volume = arg0.marketplace_stats.total_volume + arg3;
        let v0 = arg4 / 86400000;
        if (!0x2::table::contains<u64, DailyStats>(&arg0.daily_stats, v0)) {
            let v1 = DailyStats{
                date           : v0,
                sales_count    : 0,
                volume         : 0,
                unique_buyers  : 0,
                unique_sellers : 0,
                avg_sale_price : 0,
            };
            0x2::table::add<u64, DailyStats>(&mut arg0.daily_stats, v0, v1);
        };
        let v2 = 0x2::table::borrow_mut<u64, DailyStats>(&mut arg0.daily_stats, v0);
        v2.sales_count = v2.sales_count + 1;
        v2.volume = v2.volume + arg3;
        v2.avg_sale_price = v2.volume / v2.sales_count;
        if (!0x2::table::contains<address, UserStats>(&arg0.user_stats, arg1)) {
            let v3 = UserStats{
                address          : arg1,
                total_bought     : 0,
                total_sold       : 0,
                volume_bought    : 0,
                volume_sold      : 0,
                first_trade_time : arg4,
                last_trade_time  : arg4,
            };
            0x2::table::add<address, UserStats>(&mut arg0.user_stats, arg1, v3);
            arg0.marketplace_stats.unique_sellers = arg0.marketplace_stats.unique_sellers + 1;
        };
        let v4 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.user_stats, arg1);
        v4.total_sold = v4.total_sold + 1;
        v4.volume_sold = v4.volume_sold + arg3;
        v4.last_trade_time = arg4;
        if (!0x2::table::contains<address, UserStats>(&arg0.user_stats, arg2)) {
            let v5 = UserStats{
                address          : arg2,
                total_bought     : 0,
                total_sold       : 0,
                volume_bought    : 0,
                volume_sold      : 0,
                first_trade_time : arg4,
                last_trade_time  : arg4,
            };
            0x2::table::add<address, UserStats>(&mut arg0.user_stats, arg2, v5);
            arg0.marketplace_stats.unique_buyers = arg0.marketplace_stats.unique_buyers + 1;
        };
        let v6 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.user_stats, arg2);
        v6.total_bought = v6.total_bought + 1;
        v6.volume_bought = v6.volume_bought + arg3;
        v6.last_trade_time = arg4;
    }

    public fun user_address(arg0: &UserStats) : address {
        arg0.address
    }

    public fun user_first_trade_time(arg0: &UserStats) : u64 {
        arg0.first_trade_time
    }

    public fun user_last_trade_time(arg0: &UserStats) : u64 {
        arg0.last_trade_time
    }

    public fun user_total_bought(arg0: &UserStats) : u64 {
        arg0.total_bought
    }

    public fun user_total_sold(arg0: &UserStats) : u64 {
        arg0.total_sold
    }

    public fun user_volume_bought(arg0: &UserStats) : u64 {
        arg0.volume_bought
    }

    public fun user_volume_sold(arg0: &UserStats) : u64 {
        arg0.volume_sold
    }

    // decompiled from Move bytecode v6
}

