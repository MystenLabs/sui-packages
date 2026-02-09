module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::oracle_block_scholes {
    struct SVIParams has copy, drop, store {
        a: u64,
        b: u64,
        rho: u64,
        rho_negative: bool,
        m: u64,
        m_negative: bool,
        sigma: u64,
    }

    struct PriceData has copy, drop, store {
        spot: u64,
        forward: u64,
    }

    struct OracleSVI<phantom T0> has key {
        id: 0x2::object::UID,
        oracle_cap_id: 0x2::object::ID,
        expiry: u64,
        active: bool,
        prices: PriceData,
        svi: SVIParams,
        risk_free_rate: u64,
        timestamp: u64,
        settlement_price: 0x1::option::Option<u64>,
    }

    struct OracleCapSVI has store, key {
        id: 0x2::object::UID,
    }

    public fun activate<T0>(arg0: &mut OracleSVI<T0>, arg1: &OracleCapSVI, arg2: &0x2::clock::Clock) {
        assert!(arg0.oracle_cap_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        assert!(!arg0.active, 3);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expiry, 4);
        arg0.active = true;
    }

    public(friend) fun assert_active<T0>(arg0: &OracleSVI<T0>) {
        assert!(arg0.active, 2);
    }

    public(friend) fun assert_not_stale<T0>(arg0: &OracleSVI<T0>, arg1: &0x2::clock::Clock) {
        assert!(!is_stale<T0>(arg0, arg1), 1);
    }

    public(friend) fun compute_iv<T0>(arg0: &OracleSVI<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        abort 0
    }

    public(friend) fun create_oracle<T0>(arg0: &OracleCapSVI, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = PriceData{
            spot    : 0,
            forward : 0,
        };
        let v2 = SVIParams{
            a            : 0,
            b            : 0,
            rho          : 0,
            rho_negative : false,
            m            : 0,
            m_negative   : false,
            sigma        : 0,
        };
        let v3 = OracleSVI<T0>{
            id               : v0,
            oracle_cap_id    : 0x2::object::uid_to_inner(&arg0.id),
            expiry           : arg1,
            active           : false,
            prices           : v1,
            svi              : v2,
            risk_free_rate   : 0,
            timestamp        : 0,
            settlement_price : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<OracleSVI<T0>>(v3);
        0x2::object::uid_to_inner(&v0)
    }

    public(friend) fun create_oracle_cap(arg0: &mut 0x2::tx_context::TxContext) : OracleCapSVI {
        OracleCapSVI{id: 0x2::object::new(arg0)}
    }

    public fun expiry<T0>(arg0: &OracleSVI<T0>) : u64 {
        arg0.expiry
    }

    public fun forward_price<T0>(arg0: &OracleSVI<T0>) : u64 {
        arg0.prices.forward
    }

    public(friend) fun get_pricing_data<T0>(arg0: &OracleSVI<T0>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        abort 0
    }

    public fun id<T0>(arg0: &OracleSVI<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_active<T0>(arg0: &OracleSVI<T0>) : bool {
        arg0.active
    }

    public fun is_settled<T0>(arg0: &OracleSVI<T0>) : bool {
        0x1::option::is_some<u64>(&arg0.settlement_price)
    }

    public fun is_stale<T0>(arg0: &OracleSVI<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.timestamp + 30000
    }

    public fun new_price_data(arg0: u64, arg1: u64) : PriceData {
        PriceData{
            spot    : arg0,
            forward : arg1,
        }
    }

    public fun new_svi_params(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: u64) : SVIParams {
        SVIParams{
            a            : arg0,
            b            : arg1,
            rho          : arg2,
            rho_negative : arg3,
            m            : arg4,
            m_negative   : arg5,
            sigma        : arg6,
        }
    }

    public fun prices<T0>(arg0: &OracleSVI<T0>) : PriceData {
        arg0.prices
    }

    public fun risk_free_rate<T0>(arg0: &OracleSVI<T0>) : u64 {
        arg0.risk_free_rate
    }

    public fun settlement_price<T0>(arg0: &OracleSVI<T0>) : 0x1::option::Option<u64> {
        arg0.settlement_price
    }

    public fun spot_price<T0>(arg0: &OracleSVI<T0>) : u64 {
        arg0.prices.spot
    }

    public fun svi<T0>(arg0: &OracleSVI<T0>) : SVIParams {
        arg0.svi
    }

    public fun timestamp<T0>(arg0: &OracleSVI<T0>) : u64 {
        arg0.timestamp
    }

    public fun update_prices<T0>(arg0: &mut OracleSVI<T0>, arg1: &OracleCapSVI, arg2: PriceData, arg3: &0x2::clock::Clock) {
        assert!(arg0.oracle_cap_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 > arg0.expiry && 0x1::option::is_none<u64>(&arg0.settlement_price)) {
            arg0.settlement_price = 0x1::option::some<u64>(arg2.spot);
            arg0.active = false;
        };
        arg0.prices = arg2;
        arg0.timestamp = v0;
    }

    public fun update_svi<T0>(arg0: &mut OracleSVI<T0>, arg1: &OracleCapSVI, arg2: SVIParams, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.oracle_cap_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        arg0.svi = arg2;
        arg0.risk_free_rate = arg3;
        arg0.timestamp = 0x2::clock::timestamp_ms(arg4);
    }

    // decompiled from Move bytecode v6
}

