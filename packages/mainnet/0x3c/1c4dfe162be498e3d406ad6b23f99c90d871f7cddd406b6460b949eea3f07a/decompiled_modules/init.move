module 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::init {
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
        let v0 = 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::new(arg1);
        let v1 = 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::admin::new(arg1);
        0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::add_shared_object_id<0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::admin::AdminCap>(&mut v0, b"admin_cap", &v1);
        let v2 = 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::risk_params::new(arg1);
        0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::add_object_raw(&mut v0, b"risk_params", v2);
        let v3 = 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_oracle::new(0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::new(&v1, arg1), &mut v0, arg1);
        let v4 = 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::lending_pool::new_lending_registry(arg1);
        0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::add_object_raw(&mut v0, b"lending_pool_registry", v4);
        let v5 = 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::future_token::new_pool_registry(&v1, arg1);
        0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::add_object_raw(&mut v0, b"future_tokens_registry", v5);
        let v6 = EventInit{
            global_info            : 0x2::object::id<0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::GlobalInfo>(&v0),
            admin_cap              : 0x2::object::id<0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::admin::AdminCap>(&v1),
            risk_params            : v2,
            trusted_oracle         : 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_oracle::oracle_id(&v3),
            oracle_cap             : 0x2::object::id<0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_oracle::TrustedOracleCap>(&v3),
            lending_pool_registry  : v4,
            future_tokens_registry : v5,
        };
        0x2::event::emit<EventInit>(v6);
        0x2::transfer::public_transfer<0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::admin::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_oracle::TrustedOracleCap>(v3, 0x2::tx_context::sender(arg1));
        0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::share_object(v0);
    }

    // decompiled from Move bytecode v6
}

