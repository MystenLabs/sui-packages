module 0x5ff09574bbaef3b6229535fad9a25dd1f5b7bba41107afb12bfa4d5966bdc196::price_oracle {
    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceFeed has copy, drop, store {
        price: u64,
        timestamp: u64,
        volume_24h: u64,
        liquidity: u64,
    }

    struct NestOracleRegistry has key {
        id: 0x2::object::UID,
        price_feeds: 0x2::table::Table<0x1::string::String, PriceFeed>,
        trusted_oracle: address,
        total_updates: u64,
        version: u64,
    }

    public fun get_price(arg0: &NestOracleRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x2::table::contains<0x1::string::String, PriceFeed>(&arg0.price_feeds, arg1), 3);
        let v0 = 0x2::table::borrow<0x1::string::String, PriceFeed>(&arg0.price_feeds, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) - v0.timestamp <= 300000, 2);
        v0.price
    }

    public fun get_price_feed(arg0: &NestOracleRegistry, arg1: 0x1::string::String) : (u64, u64, u64, u64) {
        assert!(0x2::table::contains<0x1::string::String, PriceFeed>(&arg0.price_feeds, arg1), 3);
        let v0 = 0x2::table::borrow<0x1::string::String, PriceFeed>(&arg0.price_feeds, arg1);
        (v0.price, v0.timestamp, v0.volume_24h, v0.liquidity)
    }

    public fun get_total_updates(arg0: &NestOracleRegistry) : u64 {
        arg0.total_updates
    }

    public fun get_trusted_oracle(arg0: &NestOracleRegistry) : address {
        arg0.trusted_oracle
    }

    public fun get_version(arg0: &NestOracleRegistry) : u64 {
        arg0.version
    }

    public fun has_price(arg0: &NestOracleRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, PriceFeed>(&arg0.price_feeds, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleAdminCap{id: 0x2::object::new(arg0)};
        let v1 = NestOracleRegistry{
            id             : 0x2::object::new(arg0),
            price_feeds    : 0x2::table::new<0x1::string::String, PriceFeed>(arg0),
            trusted_oracle : 0x2::tx_context::sender(arg0),
            total_updates  : 0,
            version        : 1,
        };
        0x2::transfer::transfer<OracleAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<NestOracleRegistry>(v1);
    }

    public fun set_trusted_oracle(arg0: &OracleAdminCap, arg1: &mut NestOracleRegistry, arg2: address) {
        arg1.trusted_oracle = arg2;
    }

    public fun update_price(arg0: &mut NestOracleRegistry, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.trusted_oracle, 1);
        let v0 = PriceFeed{
            price      : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
            volume_24h : arg3,
            liquidity  : arg4,
        };
        if (0x2::table::contains<0x1::string::String, PriceFeed>(&arg0.price_feeds, arg1)) {
            0x2::table::remove<0x1::string::String, PriceFeed>(&mut arg0.price_feeds, arg1);
            0x2::table::add<0x1::string::String, PriceFeed>(&mut arg0.price_feeds, arg1, v0);
        } else {
            0x2::table::add<0x1::string::String, PriceFeed>(&mut arg0.price_feeds, arg1, v0);
        };
        arg0.total_updates = arg0.total_updates + 1;
    }

    // decompiled from Move bytecode v6
}

