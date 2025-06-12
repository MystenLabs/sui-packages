module 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    struct EventInit has copy, drop {
        global_info: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
        risk_params: 0x2::object::ID,
        trusted_oracle: 0x2::object::ID,
        oracle_cap: 0x2::object::ID,
        lending_pool_registry: 0x2::object::ID,
        future_tokens_registry: 0x2::object::ID,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::global::new(arg1);
        let v1 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::admin::new(arg1);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::global::add_shared_object_id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::admin::AdminCap>(&mut v0, b"admin_cap", &v1);
        let v2 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::new(arg1);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::global::add_shared_object_id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::RiskParams>(&mut v0, b"risk_params", &v2);
        let (v3, v4) = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_oracle::new(&v1, 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_prices::new(&v1, arg1), arg1);
        let v5 = v4;
        let v6 = v3;
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::global::add_shared_object_id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_oracle::TrustedOracleCap>(&mut v0, b"trusted_oracle", &v6);
        let v7 = 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::new_lending_registry(arg1);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::global::add_shared_object_id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::LendingPoolRegistry>(&mut v0, b"lending_pool_registry", &v7);
        let v8 = EventInit{
            global_info            : 0x2::object::id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::global::GlobalInfo>(&v0),
            admin_cap              : 0x2::object::id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::admin::AdminCap>(&v1),
            risk_params            : 0x2::object::id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::RiskParams>(&v2),
            trusted_oracle         : 0x2::object::id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_oracle::TrustedOracle>(&v5),
            oracle_cap             : 0x2::object::id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_oracle::TrustedOracleCap>(&v6),
            lending_pool_registry  : 0x2::object::id<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::LendingPoolRegistry>(&v7),
            future_tokens_registry : 0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::future_token::new_pool_registry(&v1, arg1),
        };
        0x2::event::emit<EventInit>(v8);
        0x2::transfer::public_transfer<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::admin::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_oracle::TrustedOracleCap>(v6, 0x2::tx_context::sender(arg1));
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::global::share_object(v0);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::risk_params::share_object(v2);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::trusted_oracle::share_object(v5);
        0x418c0d3f57c7fa2029ee69537015975819e26859bc58bbad2f98a363d73af887::lending_pool::share_lending_pool_registry(v7);
    }

    // decompiled from Move bytecode v6
}

