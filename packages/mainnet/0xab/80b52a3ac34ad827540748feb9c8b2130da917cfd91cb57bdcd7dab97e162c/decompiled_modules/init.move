module 0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::init {
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
        let v0 = 0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::global::new(arg1);
        let v1 = 0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::admin::new(arg1);
        0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::global::add_shared_object_id<0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::admin::AdminCap>(&mut v0, b"admin_cap", &v1);
        let v2 = 0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::risk_params::new(arg1);
        0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::global::add_object_raw(&mut v0, b"risk_params", v2);
        let v3 = 0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::trusted_oracle::new(0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::trusted_prices::new(&v1, arg1), &mut v0, arg1);
        let v4 = 0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::lending_pool::new_lending_registry(arg1);
        0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::global::add_object_raw(&mut v0, b"lending_pool_registry", v4);
        let v5 = 0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::future_token::new_pool_registry(&v1, arg1);
        0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::global::add_object_raw(&mut v0, b"future_tokens_registry", v5);
        let v6 = EventInit{
            global_info            : 0x2::object::id<0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::global::GlobalInfo>(&v0),
            admin_cap              : 0x2::object::id<0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::admin::AdminCap>(&v1),
            risk_params            : v2,
            trusted_oracle         : 0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::trusted_oracle::oracle_id(&v3),
            oracle_cap             : 0x2::object::id<0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::trusted_oracle::TrustedOracleCap>(&v3),
            lending_pool_registry  : v4,
            future_tokens_registry : v5,
        };
        0x2::event::emit<EventInit>(v6);
        0x2::transfer::public_transfer<0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::admin::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::trusted_oracle::TrustedOracleCap>(v3, 0x2::tx_context::sender(arg1));
        0xab80b52a3ac34ad827540748feb9c8b2130da917cfd91cb57bdcd7dab97e162c::global::share_object(v0);
    }

    // decompiled from Move bytecode v6
}

