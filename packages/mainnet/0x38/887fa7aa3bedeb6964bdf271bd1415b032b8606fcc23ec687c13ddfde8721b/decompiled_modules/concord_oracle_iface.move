module 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_oracle_iface {
    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
        feed_id: 0x2::object::ID,
    }

    struct OracleFeed has key {
        id: 0x2::object::UID,
        admin: address,
        price: u64,
        decimals: u8,
        last_update_ms: u64,
    }

    public fun assert_fresh(arg0: &OracleFeed, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.last_update_ms <= v0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_stale());
        assert!(v0 - arg0.last_update_ms <= 86400 * 1000, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_stale());
        assert!(arg0.price > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_price_invalid());
        arg0.price
    }

    public fun create_oracle_feed(arg0: address, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : OracleAdminCap {
        assert!(arg1 > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_price_invalid());
        let v0 = OracleFeed{
            id             : 0x2::object::new(arg4),
            admin          : arg0,
            price          : arg1,
            decimals       : arg2,
            last_update_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::share_object<OracleFeed>(v0);
        OracleAdminCap{
            id      : 0x2::object::new(arg4),
            feed_id : 0x2::object::id<OracleFeed>(&v0),
        }
    }

    public fun get_decimals(arg0: &OracleFeed) : u8 {
        arg0.decimals
    }

    public fun get_last_update_ms(arg0: &OracleFeed) : u64 {
        arg0.last_update_ms
    }

    public fun get_price(arg0: &OracleFeed) : u64 {
        arg0.price
    }

    public fun max_oracle_staleness_seconds() : u64 {
        86400
    }

    public fun pow10(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun principal_atoms_for_quote_value(arg0: u128, arg1: u64, arg2: u8, arg3: u8) : u128 {
        assert!(arg1 > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_price_invalid());
        if (arg3 == 0) {
            arg0 / (arg1 as u128)
        } else {
            arg0 * pow10(arg2) * pow10(arg3) / (arg1 as u128)
        }
    }

    public fun token_value_quote_atoms(arg0: u64, arg1: u8, arg2: u64, arg3: u8) : u128 {
        if (arg3 == 0) {
            (arg0 as u128) * (arg2 as u128)
        } else {
            (arg0 as u128) * (arg2 as u128) / pow10(arg1) * pow10(arg3)
        }
    }

    public fun update_price(arg0: &mut OracleFeed, arg1: &OracleAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.feed_id == 0x2::object::id<OracleFeed>(arg0), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::unauthorized());
        assert!(arg2 > 0, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::oracle_price_invalid());
        arg0.price = arg2;
        arg0.last_update_ms = 0x2::clock::timestamp_ms(arg3);
    }

    // decompiled from Move bytecode v7
}

