module 0xcd1fe2b668a3160dbecccf24ff3b7c1a542bb7264ef6c27b2fb32507a9e130e8::oyster_demo {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<u64, u64>,
        latest_price: u64,
        latest_timestamp: u64,
        expected_pcrs: 0x8df76b79118ffad2bacb55705c84474802ddb3d62199b98db720c5088e161ab8::enclave_registry::Pcrs,
        pcrs_initialized: bool,
    }

    struct IntentMessage<T0: drop> has copy, drop {
        intent: u8,
        timestamp_ms: u64,
        payload: T0,
    }

    struct PriceUpdatePayload has copy, drop {
        price: u64,
    }

    struct PriceUpdated has copy, drop {
        price: u64,
        timestamp: u64,
    }

    struct OracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
    }

    struct PcrsUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        pcr0: vector<u8>,
        pcr1: vector<u8>,
        pcr2: vector<u8>,
        pcr16: vector<u8>,
    }

    public fun get_latest_price(arg0: &PriceOracle) : (u64, u64) {
        assert!(arg0.latest_timestamp > 0, 2);
        (arg0.latest_price, arg0.latest_timestamp)
    }

    public fun get_latest_timestamp(arg0: &PriceOracle) : u64 {
        assert!(arg0.latest_timestamp > 0, 2);
        arg0.latest_timestamp
    }

    public fun get_price_at_timestamp(arg0: &PriceOracle, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, u64>(&arg0.prices, arg1), 1);
        *0x2::table::borrow<u64, u64>(&arg0.prices, arg1)
    }

    public fun has_price_at_timestamp(arg0: &PriceOracle, arg1: u64) : bool {
        0x2::table::contains<u64, u64>(&arg0.prices, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id               : 0x2::object::new(arg0),
            prices           : 0x2::table::new<u64, u64>(arg0),
            latest_price     : 0,
            latest_timestamp : 0,
            expected_pcrs    : 0x8df76b79118ffad2bacb55705c84474802ddb3d62199b98db720c5088e161ab8::enclave_registry::new_pcrs(x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"),
            pcrs_initialized : false,
        };
        let v1 = OracleCreated{oracle_id: 0x2::object::id<PriceOracle>(&v0)};
        0x2::event::emit<OracleCreated>(v1);
        0x2::transfer::share_object<PriceOracle>(v0);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun update_expected_pcrs(arg0: &mut PriceOracle, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        arg0.expected_pcrs = 0x8df76b79118ffad2bacb55705c84474802ddb3d62199b98db720c5088e161ab8::enclave_registry::new_pcrs(arg2, arg3, arg4, arg5);
        arg0.pcrs_initialized = true;
        let v0 = PcrsUpdated{
            oracle_id : 0x2::object::id<PriceOracle>(arg0),
            pcr0      : arg2,
            pcr1      : arg3,
            pcr2      : arg4,
            pcr16     : arg5,
        };
        0x2::event::emit<PcrsUpdated>(v0);
    }

    public fun update_sui_price(arg0: &mut PriceOracle, arg1: &0x8df76b79118ffad2bacb55705c84474802ddb3d62199b98db720c5088e161ab8::enclave_registry::Registry, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: vector<u8>) {
        assert!(arg0.pcrs_initialized, 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg5 <= v0 && v0 - arg5 <= 3600000, 5);
        assert!(*0x8df76b79118ffad2bacb55705c84474802ddb3d62199b98db720c5088e161ab8::enclave_registry::get_pcrs(arg1, &arg3) == arg0.expected_pcrs, 3);
        let v1 = PriceUpdatePayload{price: arg4};
        let v2 = IntentMessage<PriceUpdatePayload>{
            intent       : 0,
            timestamp_ms : arg5,
            payload      : v1,
        };
        let v3 = 0x1::bcs::to_bytes<IntentMessage<PriceUpdatePayload>>(&v2);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &arg3, &v3, 1), 0);
        0x2::table::add<u64, u64>(&mut arg0.prices, arg5, arg4);
        if (arg5 > arg0.latest_timestamp) {
            arg0.latest_price = arg4;
            arg0.latest_timestamp = arg5;
        };
        let v4 = PriceUpdated{
            price     : arg4,
            timestamp : arg5,
        };
        0x2::event::emit<PriceUpdated>(v4);
    }

    // decompiled from Move bytecode v6
}

