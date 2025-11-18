module 0x272f6782171d962ceb9d90c13c78164cdb7edd2e42854ac63c345888ac22d688::oyster_demo {
    struct OYSTER_DEMO has drop {
        dummy_field: bool,
    }

    struct PriceOracle<phantom T0> has key {
        id: 0x2::object::UID,
        prices: 0x2::table::Table<u64, u64>,
        latest_price: u64,
        latest_timestamp: u64,
    }

    struct PriceUpdatePayload has copy, drop {
        price: u64,
        timestamp: u64,
    }

    struct PriceUpdated has copy, drop {
        price: u64,
        timestamp: u64,
    }

    struct OracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
    }

    fun create_oracle<T0>(arg0: &mut 0x2::tx_context::TxContext) : PriceOracle<T0> {
        let v0 = PriceOracle<T0>{
            id               : 0x2::object::new(arg0),
            prices           : 0x2::table::new<u64, u64>(arg0),
            latest_price     : 0,
            latest_timestamp : 0,
        };
        let v1 = OracleCreated{oracle_id: 0x2::object::id<PriceOracle<T0>>(&v0)};
        0x2::event::emit<OracleCreated>(v1);
        v0
    }

    public fun get_latest_price<T0>(arg0: &PriceOracle<T0>) : (u64, u64) {
        assert!(arg0.latest_timestamp > 0, 2);
        (arg0.latest_price, arg0.latest_timestamp)
    }

    public fun get_latest_timestamp<T0>(arg0: &PriceOracle<T0>) : u64 {
        arg0.latest_timestamp
    }

    public fun get_price_at_timestamp<T0>(arg0: &PriceOracle<T0>, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, u64>(&arg0.prices, arg1), 1);
        *0x2::table::borrow<u64, u64>(&arg0.prices, arg1)
    }

    public fun has_price_at_timestamp<T0>(arg0: &PriceOracle<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, u64>(&arg0.prices, arg1)
    }

    fun init(arg0: OYSTER_DEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x272f6782171d962ceb9d90c13c78164cdb7edd2e42854ac63c345888ac22d688::enclave::new_cap<OYSTER_DEMO>(arg0, arg1);
        0x272f6782171d962ceb9d90c13c78164cdb7edd2e42854ac63c345888ac22d688::enclave::create_enclave_config<OYSTER_DEMO>(&v0, 0x1::string::utf8(b"SUI Price Oracle Enclave"), x"3aa0e6e6ed7d8301655fced7e6ddcc443a3e57bf62f070caa6becf337069e859c0f03d68136440ff1cab8adefd20634c", x"b0d319fa64f9c2c9d7e9187bc21001ddacfab4077e737957fa1b8b97cc993bed43a79019aebfd40ee5f6f213147909f8", x"fdb2295dc5d9b67a653ed5f3ead5fc8166ec3cae1de1c7c6f31c3b43b2eb26ab5d063f414f3d2b93163426805dfe057e", arg1);
        0x2::transfer::public_transfer<0x272f6782171d962ceb9d90c13c78164cdb7edd2e42854ac63c345888ac22d688::enclave::Cap<OYSTER_DEMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun initialize_oracle(arg0: &mut 0x2::tx_context::TxContext) {
        share_oracle<OYSTER_DEMO>(create_oracle<OYSTER_DEMO>(arg0));
    }

    fun share_oracle<T0>(arg0: PriceOracle<T0>) {
        0x2::transfer::share_object<PriceOracle<T0>>(arg0);
    }

    fun update_price<T0: drop>(arg0: &mut PriceOracle<T0>, arg1: &0x272f6782171d962ceb9d90c13c78164cdb7edd2e42854ac63c345888ac22d688::enclave::Enclave<T0>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64) {
        let v0 = PriceUpdatePayload{
            price     : arg2,
            timestamp : arg3,
        };
        assert!(0x272f6782171d962ceb9d90c13c78164cdb7edd2e42854ac63c345888ac22d688::enclave::verify_signature<T0, PriceUpdatePayload>(arg1, 0, arg5, v0, &arg4), 0);
        0x2::table::add<u64, u64>(&mut arg0.prices, arg3, arg2);
        if (arg3 > arg0.latest_timestamp) {
            arg0.latest_price = arg2;
            arg0.latest_timestamp = arg3;
        };
        let v1 = PriceUpdated{
            price     : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<PriceUpdated>(v1);
    }

    entry fun update_sui_price(arg0: &mut PriceOracle<OYSTER_DEMO>, arg1: &0x272f6782171d962ceb9d90c13c78164cdb7edd2e42854ac63c345888ac22d688::enclave::Enclave<OYSTER_DEMO>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        update_price<OYSTER_DEMO>(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    // decompiled from Move bytecode v6
}

