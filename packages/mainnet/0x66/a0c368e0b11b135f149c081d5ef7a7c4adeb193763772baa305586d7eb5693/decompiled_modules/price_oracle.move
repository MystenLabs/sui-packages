module 0x66a0c368e0b11b135f149c081d5ef7a7c4adeb193763772baa305586d7eb5693::price_oracle {
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

    public fun batch_update_prices(arg0: &mut NestOracleRegistry, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.trusted_oracle, 1);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 4);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 4);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 4);
        let v1 = 0;
        while (v1 < v0) {
            update_price_internal(arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v1), *0x1::vector::borrow<u64>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), *0x1::vector::borrow<u64>(&arg4, v1), arg5);
            v1 = v1 + 1;
        };
        arg0.total_updates = arg0.total_updates + v0;
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
        update_price_internal(arg0, arg1, arg2, arg3, arg4, arg5);
        arg0.total_updates = arg0.total_updates + 1;
    }

    fun update_price_internal(arg0: &mut NestOracleRegistry, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = PriceFeed{
            price      : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
            volume_24h : arg3,
            liquidity  : arg4,
        };
        if (0x2::table::contains<0x1::string::String, PriceFeed>(&arg0.price_feeds, arg1)) {
            0x2::table::remove<0x1::string::String, PriceFeed>(&mut arg0.price_feeds, arg1);
        };
        0x2::table::add<0x1::string::String, PriceFeed>(&mut arg0.price_feeds, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

