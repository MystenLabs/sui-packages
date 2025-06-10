module 0x71ae506a9ef21fad8340c1012c60e96baf36eb72829736bad176be2a0e61a723::oracle {
    struct OracleConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        max_staleness_threshold_s: u64,
        max_confidence_interval_bps: u64,
        oracle_id: vector<u8>,
        oracle_type: u8,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceFeed has drop {
        price: u64,
        ema_price: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct OracleHolder has drop {
        price_feeds: 0x2::vec_map::VecMap<0x2::object::ID, PriceFeed>,
    }

    public(friend) fun assert_version(arg0: &OracleConfig) {
        assert!(arg0.version >= 1, 1000);
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000000000 as u128) / (arg1 as u128)) as u64)
    }

    public fun div_u128(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (1000000000 as u256) / (arg1 as u256)) as u128)
    }

    public fun ema_price(arg0: &PriceFeed) : 0x1::option::Option<u64> {
        arg0.ema_price
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun max_bps() : u64 {
        10000
    }

    public fun max_confidence_interval_bps(arg0: &OracleConfig) : u64 {
        arg0.max_confidence_interval_bps
    }

    public fun max_staleness_threshold_s(arg0: &OracleConfig) : u64 {
        arg0.max_staleness_threshold_s
    }

    public(friend) fun new_config(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : OracleConfig {
        assert!(arg0 > 0 && arg0 <= 60, 0);
        assert!(arg1 > 0 && arg1 <= 10000, 1);
        OracleConfig{
            id                          : 0x2::object::new(arg4),
            version                     : 1,
            max_staleness_threshold_s   : arg0,
            max_confidence_interval_bps : arg1,
            oracle_id                   : arg2,
            oracle_type                 : arg3,
        }
    }

    public fun new_holder() : OracleHolder {
        OracleHolder{price_feeds: 0x2::vec_map::empty<0x2::object::ID, PriceFeed>()}
    }

    public(friend) fun new_price_feed(arg0: u64, arg1: 0x1::option::Option<u64>, arg2: u64) : PriceFeed {
        PriceFeed{
            price     : arg0,
            ema_price : arg1,
            timestamp : arg2,
        }
    }

    public fun oracle_id(arg0: &OracleConfig) : vector<u8> {
        arg0.oracle_id
    }

    public fun oracle_type(arg0: &OracleConfig) : u8 {
        arg0.oracle_type
    }

    public fun oracle_type_pyth() : u8 {
        0
    }

    public fun oracle_type_supra() : u8 {
        1
    }

    public fun price(arg0: &PriceFeed) : u64 {
        arg0.price
    }

    public fun price_feed(arg0: &OracleHolder, arg1: &0x2::object::ID) : &PriceFeed {
        0x2::vec_map::get<0x2::object::ID, PriceFeed>(&arg0.price_feeds, arg1)
    }

    public(friend) fun price_feeds_mut(arg0: &mut OracleHolder) : &mut 0x2::vec_map::VecMap<0x2::object::ID, PriceFeed> {
        &mut arg0.price_feeds
    }

    public fun timestamp(arg0: &PriceFeed) : u64 {
        arg0.timestamp
    }

    public fun update_oracle_config(arg0: &mut OracleConfig, arg1: u64, arg2: u64, arg3: &AdminCap) {
        assert_version(arg0);
        arg0.max_staleness_threshold_s = arg1;
        arg0.max_confidence_interval_bps = arg2;
    }

    public fun update_version(arg0: &mut OracleConfig, arg1: u64, arg2: &AdminCap) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

