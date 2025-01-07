module 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::app {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        interest_model_cap: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::InterestModels>,
        interest_model_change_delay: u64,
        risk_model_cap: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::RiskModels>,
        risk_model_change_delay: u64,
    }

    public fun add_interest_model<T0>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg1: &AdminCap, arg2: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::OneTimeLockValue<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::InterestModel>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::add_interest_model<T0>(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::interest_models_mut(arg0), &arg1.interest_model_cap, arg2, arg4);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::register_coin<T0>(arg0, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public entry fun add_limiter<T0>(arg0: &AdminCap, arg1: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg2: u64, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::add_limiter<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun add_risk_model<T0>(arg0: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg1: &AdminCap, arg2: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::OneTimeLockValue<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::add_risk_model<T0>(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::risk_models_mut(arg0), &arg1.risk_model_cap, arg2, arg3);
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::register_collateral<T0>(arg0);
    }

    public fun add_whitelist_address(arg0: &AdminCap, arg1: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg2: address) {
        0x4168e1c807a2d1f4cf301e9ce5fbd6e58f54a86751b02df176d89672489ceea8::whitelist::add_whitelist_address(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::uid_mut(arg1), arg2);
    }

    public fun create_interest_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::OneTimeLockValue<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::InterestModel> {
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::create_interest_model_change<T0>(&arg0.interest_model_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg0.interest_model_change_delay, arg9)
    }

    public fun create_risk_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::one_time_lock_value::OneTimeLockValue<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::RiskModel> {
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::create_risk_model_change<T0>(&arg0.risk_model_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg0.risk_model_change_delay, arg7)
    }

    public fun ext(arg0: &AdminCap, arg1: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market) : &mut 0x2::object::UID {
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::uid_mut(arg1)
    }

    public fun extend_interest_model_change_delay(arg0: &mut AdminCap, arg1: u64) {
        let v0 = arg0.interest_model_change_delay + arg1;
        assert!(v0 > arg0.interest_model_change_delay, 0);
        arg0.interest_model_change_delay = v0;
    }

    public fun extend_risk_model_change_delay(arg0: &mut AdminCap, arg1: u64) {
        let v0 = arg0.risk_model_change_delay + arg1;
        assert!(v0 > arg0.risk_model_change_delay, 0);
        arg0.risk_model_change_delay = v0;
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0, arg1);
    }

    fun init_internal(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::new(arg1);
        let v3 = AdminCap{
            id                          : 0x2::object::new(arg1),
            interest_model_cap          : v1,
            interest_model_change_delay : 0,
            risk_model_cap              : v2,
            risk_model_change_delay     : 0,
        };
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        0x2::transfer::public_share_object<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market>(v0);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun update_outflow_limit_params<T0>(arg0: &AdminCap, arg1: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::update_outflow_limit_params<T0>(arg1, arg2);
    }

    public entry fun update_outflow_segment_params<T0>(arg0: &AdminCap, arg1: &mut 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::update_outflow_segment_params<T0>(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

