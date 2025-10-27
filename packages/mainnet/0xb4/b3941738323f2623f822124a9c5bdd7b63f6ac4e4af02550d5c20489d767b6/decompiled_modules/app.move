module 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::app {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        interest_model_cap: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::InterestModels>,
        interest_model_change_delay: u64,
        risk_model_cap: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::RiskModels>,
        risk_model_change_delay: u64,
        limiter_change_delay: u64,
    }

    struct TakeRevenueEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
    }

    struct TakeBorrowFeeEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
    }

    public fun add_whitelist_address(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: address) {
        0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::add_whitelist_address(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1), arg2);
    }

    public fun remove_whitelist_address(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: address) {
        0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::remove_whitelist_address(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1), arg2);
    }

    public entry fun set_apm_threshold<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::apm::set_apm_threshold(arg1, 0x1::type_name::get<T0>(), arg2);
    }

    public fun add_interest_model<T0>(arg0: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: &AdminCap, arg2: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::InterestModel>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        update_interest_model<T0>(arg0, arg1, arg2, arg4);
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::register_coin<T0>(arg0, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public entry fun add_limiter<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::add_limiter<T0>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::rate_limiter_mut(arg1), arg2, arg3, arg4);
    }

    public entry fun add_lock_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation_access::ObligationAccessStore) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation_access::add_lock_key<T0>(arg1);
    }

    public fun add_pause_authority_registry(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1);
        let v1 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::pause_authority_registry_key();
        if (!0x2::dynamic_field::exists_<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::PauseAuthorityRegistryKey>(v0, v1)) {
            0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::PauseAuthorityRegistryKey, 0x2::vec_set::VecSet<address>>(v0, v1, 0x2::vec_set::empty<address>());
        };
        0x2::vec_set::insert<address>(0x2::dynamic_field::borrow_mut<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::PauseAuthorityRegistryKey, 0x2::vec_set::VecSet<address>>(v0, v1), arg2);
    }

    public entry fun add_referral_witness_list<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::borrow_referral::AuthorizedWitnessList) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::borrow_referral::add_witness<T0>(arg1);
    }

    public entry fun add_reward_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation_access::ObligationAccessStore) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation_access::add_reward_key<T0>(arg1);
    }

    public entry fun add_risk_model<T0>(arg0: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: &AdminCap, arg2: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        update_risk_model<T0>(arg0, arg1, arg2, arg3);
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::register_collateral<T0>(arg0);
    }

    public entry fun apply_limiter_limit_change<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::LimiterUpdateLimitChange>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::apply_limiter_limit_change(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::rate_limiter_mut(arg1), arg2, arg3);
    }

    public entry fun apply_limiter_params_change<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::LimiterUpdateParamsChange>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::apply_limiter_params_change(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::rate_limiter_mut(arg1), arg2, arg3);
    }

    public fun create_interest_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::InterestModel> {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::create_interest_model_change<T0>(&arg0.interest_model_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg0.interest_model_change_delay, arg12)
    }

    public fun create_limiter_limit_change<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::LimiterUpdateLimitChange> {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::create_limiter_limit_change<T0>(arg1, arg0.limiter_change_delay, arg2)
    }

    public fun create_limiter_params_change<T0>(arg0: &AdminCap, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::LimiterUpdateParamsChange> {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::limiter::create_limiter_params_change<T0>(arg1, arg2, arg0.limiter_change_delay, arg3)
    }

    public entry fun create_referral_witness_list(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::borrow_referral::create_witness_list(arg1);
    }

    public fun create_risk_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::RiskModel> {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::create_risk_model_change<T0>(&arg0.risk_model_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg0.risk_model_change_delay, arg7)
    }

    public fun disable_borrow(arg0: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::version::Version, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::PauseAuthorityRegistryKey, 0x2::vec_set::VecSet<address>>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid(arg1), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::pause_authority_registry_key()), &v0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::unauthorize_pause_error());
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::keys<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::InterestModels, 0x1::type_name::TypeName, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::InterestModel>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::interest_models(arg1));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::set_base_asset_active_state(arg1, *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2), false);
            v2 = v2 + 1;
        };
    }

    public fun disable_collateral(arg0: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::version::Version, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::PauseAuthorityRegistryKey, 0x2::vec_set::VecSet<address>>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid(arg1), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::pause_authority_registry_key()), &v0), 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::unauthorize_pause_error());
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::keys<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::RiskModels, 0x1::type_name::TypeName, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::RiskModel>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::risk_models(arg1));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::set_collateral_active_state(arg1, *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2), false);
            v2 = v2 + 1;
        };
    }

    public fun ext(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market) : &mut 0x2::object::UID {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1)
    }

    public fun extend_interest_model_change_delay(arg0: &mut AdminCap, arg1: u64) {
        assert!(arg1 <= 1, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::invalid_params_error());
        arg0.interest_model_change_delay = arg0.interest_model_change_delay + arg1;
    }

    public fun extend_limiter_change_delay(arg0: &mut AdminCap, arg1: u64) {
        arg0.limiter_change_delay = arg0.limiter_change_delay + arg1;
    }

    public fun extend_risk_model_change_delay(arg0: &mut AdminCap, arg1: u64) {
        arg0.risk_model_change_delay = arg0.risk_model_change_delay + arg1;
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0, arg1);
    }

    fun init_internal(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::new(arg1);
        let v3 = AdminCap{
            id                          : 0x2::object::new(arg1),
            interest_model_cap          : v1,
            interest_model_change_delay : 0,
            risk_model_cap              : v2,
            risk_model_change_delay     : 0,
            limiter_change_delay        : 0,
        };
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        0x2::transfer::public_share_object<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market>(v0);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun init_market_coin_price_table(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::init_market_coin_price_table(arg1, arg2);
    }

    public entry fun remove_lock_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation_access::ObligationAccessStore) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation_access::remove_lock_key<T0>(arg1);
    }

    public fun remove_pause_authority_registry(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1);
        let v1 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::pause_authority_registry_key();
        if (!0x2::dynamic_field::exists_<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::PauseAuthorityRegistryKey>(v0, v1)) {
            0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::PauseAuthorityRegistryKey, 0x2::vec_set::VecSet<address>>(v0, v1, 0x2::vec_set::empty<address>());
        };
        0x2::vec_set::remove<address>(0x2::dynamic_field::borrow_mut<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::PauseAuthorityRegistryKey, 0x2::vec_set::VecSet<address>>(v0, v1), &arg2);
    }

    public entry fun remove_referral_witness_list<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::borrow_referral::AuthorizedWitnessList) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::borrow_referral::remove_witness<T0>(arg1);
    }

    public entry fun remove_reward_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation_access::ObligationAccessStore) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::obligation_access::remove_reward_key<T0>(arg1);
    }

    public entry fun set_base_asset_active_state<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: bool) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::set_base_asset_active_state(arg1, 0x1::type_name::get<T0>(), arg2);
    }

    public entry fun set_collateral_active_state<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: bool) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::set_collateral_active_state(arg1, 0x1::type_name::get<T0>(), arg2);
    }

    public entry fun set_flash_loan_fee<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::set_flash_loan_fee<T0>(arg1, arg2);
    }

    public entry fun set_incentive_reward_factor<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::incentive_rewards::set_reward_factor<T0>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::reward_factors_mut(arg1), arg2, arg3);
    }

    public entry fun take_borrow_fee<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TakeBorrowFeeEvent{
            market    : 0x2::object::id<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market>(arg1),
            amount    : arg2,
            coin_type : 0x1::type_name::get<T0>(),
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TakeBorrowFeeEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::take_borrow_fee<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun take_revenue<T0>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TakeRevenueEvent{
            market    : 0x2::object::id<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market>(arg1),
            amount    : arg2,
            coin_type : 0x1::type_name::get<T0>(),
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TakeRevenueEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::take_revenue<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun update_borrow_fee<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::error::invalid_params_error());
        let v0 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1);
        let v1 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(v0, v1);
        0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(v0, v1, 0x1::fixed_point32::create_from_rational(arg2, arg3));
    }

    public entry fun update_borrow_fee_recipient(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: address) {
        let v0 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1);
        let v1 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::borrow_fee_recipient_key();
        0x2::dynamic_field::remove_if_exists<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::BorrowFeeRecipientKey, address>(v0, v1);
        0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::BorrowFeeRecipientKey, address>(v0, v1, arg2);
    }

    public entry fun update_borrow_limit<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64) {
        let v0 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1);
        let v1 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::borrow_limit_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::BorrowLimitKey, u64>(v0, v1);
        0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::BorrowLimitKey, u64>(v0, v1, arg2);
    }

    public fun update_interest_model<T0>(arg0: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: &AdminCap, arg2: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::interest_model::add_interest_model<T0>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::interest_models_mut(arg0), &arg1.interest_model_cap, arg2, arg3);
    }

    public entry fun update_isolated_asset_status<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: bool) {
        let v0 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1);
        let v1 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::isolated_asset_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::IsolatedAssetKey, bool>(v0, v1);
        0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::IsolatedAssetKey, bool>(v0, v1, arg2);
    }

    public entry fun update_min_collateral_amount<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64) {
        let v0 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1);
        let v1 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::min_collateral_amount_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::MinCollateralAmountKey, u64>(v0, v1);
        0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::MinCollateralAmountKey, u64>(v0, v1, arg2);
    }

    public entry fun update_risk_model<T0>(arg0: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg1: &AdminCap, arg2: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::one_time_lock_value::OneTimeLockValue<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::risk_model::add_risk_model<T0>(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::risk_models_mut(arg0), &arg1.risk_model_cap, arg2, arg3);
    }

    public entry fun update_supply_limit<T0: drop>(arg0: &AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market, arg2: u64) {
        let v0 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::uid_mut(arg1);
        let v1 = 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::supply_limit_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::SupplyLimitKey, u64>(v0, v1);
        0x2::dynamic_field::add<0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market_dynamic_keys::SupplyLimitKey, u64>(v0, v1, arg2);
    }

    // decompiled from Move bytecode v6
}

