module 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::admin {
    struct AdminCapBurnedEvent has copy, drop {
        burned_by: address,
    }

    struct DaoAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GovernanceActionPayload {
        action_type: u8,
        payload: vector<u8>,
    }

    struct DepegData has copy, drop {
        is_depeg: bool,
        price_bps: u64,
        timestamp_ms: u64,
        action: vector<u8>,
    }

    struct TEEDepegProcessedEvent has copy, drop {
        is_depeg: bool,
        price_bps: u64,
        action: vector<u8>,
        timestamp_ms: u64,
    }

    struct EmergencyExitEvent has copy, drop {
        from_strategy: u8,
        to_strategy: u8,
        depeg_price_bps: u64,
        timestamp_ms: u64,
    }

    public fun burn_admin_cap(arg0: 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = AdminCapBurnedEvent{burned_by: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<AdminCapBurnedEvent>(v0);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::burn_admin_cap(arg0);
    }

    fun apply_crank_config_payload(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::crank::CrankConfig, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::crank::update_config(arg0, 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0));
    }

    fun apply_ema_alpha_payload(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::apy::ApyRegistry, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::apy::set_ema_alpha(arg0, 0x2::bcs::peel_u64(&mut v0));
    }

    fun apply_fee_payload<T0>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap, arg2: vector<u8>) {
        let v0 = 0x2::bcs::new(arg2);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::update_performance_fee<T0>(arg0, arg1, 0x2::bcs::peel_u64(&mut v0));
    }

    fun apply_fee_recipient_payload<T0>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap, arg2: vector<u8>) {
        let v0 = 0x2::bcs::new(arg2);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::update_fee_recipient<T0>(arg0, arg1, 0x2::bcs::peel_address(&mut v0));
    }

    fun apply_harvest_cooldown_payload(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::set_cooldown_ms(arg0, 0x2::bcs::peel_u64(&mut v0));
    }

    fun apply_harvest_slippage_payload(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::set_harvest_slippage_bps(arg0, 0x2::bcs::peel_u64(&mut v0));
    }

    fun apply_harvest_threshold_payload(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::set_min_threshold(arg0, 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u64(&mut v0));
    }

    fun apply_register_protocol_payload(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::register_protocol(arg0, 0x2::bcs::peel_u8(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_bool(&mut v0));
    }

    fun apply_register_tvl_object_payload(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::tvl::TvlRegistry, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::tvl::register_protocol_object(arg0, 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_address(&mut v0));
    }

    fun apply_tee_key_payload(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::crank::CrankConfig, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg2: vector<u8>) {
        let v0 = 0x2::bcs::new(arg2);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::crank::update_tee_key(arg0, v1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::update_tee_key(arg1, v1);
    }

    fun apply_tvl_cap_payload<T0>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::ProtocolAccessCap, arg2: vector<u8>) {
        let v0 = 0x2::bcs::new(arg2);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::update_tvl_cap<T0>(arg0, arg1, 0x2::bcs::peel_u64(&mut v0));
    }

    public fun bootstrap_register_harvest_protocol(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg2: u8, arg3: u64, arg4: 0x2::object::ID, arg5: u8) {
        assert!(0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::protocol_count(arg0) < 10, 903);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::register_harvest_protocol(arg0, arg2, arg3);
    }

    public fun bootstrap_register_protocol(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg2: u8, arg3: vector<u8>, arg4: bool) {
        assert!(0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::count_available(arg0) < 14, 903);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::register_protocol(arg0, arg2, 0x1::string::utf8(arg3), arg4);
    }

    public fun bootstrap_register_tvl_object(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::tvl::TvlRegistry, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg2: u8, arg3: address) {
        assert!(!0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::tvl::has_registered_object(arg0, arg2), 903);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::tvl::register_protocol_object(arg0, arg2, arg3);
    }

    fun consume_payload(arg0: GovernanceActionPayload, arg1: u8) : vector<u8> {
        let GovernanceActionPayload {
            action_type : v0,
            payload     : v1,
        } = arg0;
        assert!(v0 == arg1, 901);
        v1
    }

    public fun create_gov_action_payload(arg0: &DaoAdminCap, arg1: u8, arg2: vector<u8>) : GovernanceActionPayload {
        GovernanceActionPayload{
            action_type : arg1,
            payload     : arg2,
        }
    }

    public fun emergency_exit_from_enclave<T0>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg1: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg2: &vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg4, arg2, &arg3), 905);
        let v0 = 0x2::bcs::new(arg3);
        let v1 = 0x2::bcs::peel_bool(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u64(&mut v0);
        assert!(v3 > 0x2::clock::timestamp_ms(arg5) - 300000, 906);
        if (v1) {
            assert!(v2 < 9700, 907);
        };
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::set_depeg_status<T0>(arg0, 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg1), v1);
        let v4 = TEEDepegProcessedEvent{
            is_depeg     : v1,
            price_bps    : v2,
            action       : 0x2::bcs::peel_vec_u8(&mut v0),
            timestamp_ms : v3,
        };
        0x2::event::emit<TEEDepegProcessedEvent>(v4);
    }

    public fun execute_dao_increase_tvl_cap<T0>(arg0: GovernanceActionPayload, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry) {
        apply_tvl_cap_payload<T0>(arg1, 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2), consume_payload(arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_tvl_cap()));
    }

    public fun execute_dao_register_protocol(arg0: GovernanceActionPayload, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry) {
        apply_register_protocol_payload(arg1, consume_payload(arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_register_protocol()));
    }

    public fun execute_dao_set_ema_alpha(arg0: GovernanceActionPayload, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::apy::ApyRegistry) {
        apply_ema_alpha_payload(arg1, consume_payload(arg0, 20));
    }

    public fun execute_dao_set_fee_recipient<T0>(arg0: GovernanceActionPayload, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry) {
        apply_fee_recipient_payload<T0>(arg1, 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2), consume_payload(arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_set_fee_recipient()));
    }

    public fun execute_dao_update_config(arg0: GovernanceActionPayload, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::crank::CrankConfig) {
        apply_crank_config_payload(arg1, consume_payload(arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_crank_config()));
    }

    public fun execute_dao_update_fee<T0>(arg0: GovernanceActionPayload, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry) {
        apply_fee_payload<T0>(arg1, 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2), consume_payload(arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_fee()));
    }

    public fun execute_dao_update_tee_key(arg0: GovernanceActionPayload, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::crank::CrankConfig, arg2: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig) {
        apply_tee_key_payload(arg1, arg2, consume_payload(arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_tee_key()));
    }

    public fun execute_increase_tvl_cap<T0>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2);
        let (v1, v2) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), v0);
        assert!(v1 == 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_tvl_cap(), 901);
        apply_tvl_cap_payload<T0>(arg1, v0, v2);
    }

    public fun execute_register_harvest_protocol(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 25, 901);
        let v2 = 0x2::bcs::new(v1);
        0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2));
        0x2::bcs::peel_u8(&mut v2);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::register_harvest_protocol(arg1, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_u64(&mut v2));
    }

    public fun execute_register_protocol(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg2, arg3), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg1));
        assert!(v0 == 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_register_protocol(), 901);
        apply_register_protocol_payload(arg1, v1);
    }

    public fun execute_register_tvl_object(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::tvl::TvlRegistry, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 24, 901);
        apply_register_tvl_object_payload(arg1, v1);
    }

    public fun execute_set_ema_alpha(arg0: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::apy::ApyRegistry, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg1, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 20, 901);
        apply_ema_alpha_payload(arg0, v1);
    }

    public fun execute_set_fee_recipient<T0>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2);
        let (v1, v2) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), v0);
        assert!(v1 == 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_set_fee_recipient(), 901);
        apply_fee_recipient_payload<T0>(arg1, v0, v2);
    }

    public fun execute_set_harvest_cooldown(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 21, 901);
        apply_harvest_cooldown_payload(arg1, v1);
    }

    public fun execute_set_harvest_slippage(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 23, 901);
        apply_harvest_slippage_payload(arg1, v1);
    }

    public fun execute_set_harvest_threshold(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 22, 901);
        apply_harvest_threshold_payload(arg1, v1);
    }

    public fun execute_set_pyth_price_id(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 27, 901);
        let v2 = 0x2::bcs::new(v1);
        0x2::bcs::peel_u8(&mut v2);
        0x2::object::id_from_address(0x2::bcs::peel_address(&mut v2));
        0x2::bcs::peel_u8(&mut v2);
    }

    public fun execute_unregister_harvest_protocol(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 28, 901);
        let v2 = 0x2::bcs::new(v1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::unregister_harvest_protocol(arg1, 0x2::bcs::peel_u8(&mut v2));
    }

    public fun execute_update_config(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::crank::CrankConfig, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2));
        assert!(v0 == 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_crank_config(), 901);
        apply_crank_config_payload(arg1, v1);
    }

    public fun execute_update_fee<T0>(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg2);
        let (v1, v2) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg3, arg4), v0);
        assert!(v1 == 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_fee(), 901);
        apply_fee_payload<T0>(arg1, v0, v2);
    }

    public fun execute_update_has_rewards(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg2: u64, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg2, arg3), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg1));
        assert!(v0 == 26, 901);
        let v2 = 0x2::bcs::new(v1);
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::update_has_rewards(arg1, 0x2::bcs::peel_u8(&mut v2), 0x2::bcs::peel_bool(&mut v2));
    }

    public fun execute_update_tee_key(arg0: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg1: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::crank::CrankConfig, arg2: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::harvest::HarvestConfig, arg3: &0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg4: u64, arg5: &0x2::clock::Clock) {
        let (v0, v1) = 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::destroy_action(0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::execute(arg0, arg4, arg5), 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::borrow_protocol_access_cap(arg3));
        assert!(v0 == 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_tee_key(), 911);
        apply_tee_key_payload(arg1, arg2, v1);
    }

    public fun initialize_strategy_registry<T0>(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &mut 0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::StrategyRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        0x94466dcc412fceee5fe421b28c31e17fc545438a83708798289b1f0d029eb3ef::strategy::set_protocol_access_cap(arg2, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::create_protocol_access_cap<T0>(arg1, arg0, arg3));
    }

    public fun mint_dao_admin_cap(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : DaoAdminCap {
        DaoAdminCap{id: 0x2::object::new(arg1)}
    }

    public fun propose_increase_tvl_cap(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_tvl_cap(), 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_register_harvest_protocol(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u8, arg3: u64, arg4: 0x2::object::ID, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg5));
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 25, v0, arg6, arg7)
    }

    public fun propose_register_protocol(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u8, arg3: vector<u8>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg4));
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_register_protocol(), v0, arg5, arg6)
    }

    public fun propose_register_tvl_object(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 24, v0, arg4, arg5)
    }

    public fun propose_set_ema_alpha(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 20, 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_set_fee_recipient(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_set_fee_recipient(), 0x2::bcs::to_bytes<address>(&arg2), arg3, arg4)
    }

    public fun propose_set_harvest_cooldown(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(arg2 >= 3600000, 902);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 21, 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_set_harvest_slippage(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_slippage(arg2, false);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 23, 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_set_harvest_threshold(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 22, v0, arg4, arg5)
    }

    public fun propose_set_pyth_price_id(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u8, arg3: 0x2::object::ID, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg4));
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 27, v0, arg5, arg6)
    }

    public fun propose_unregister_harvest_protocol(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 28, 0x2::bcs::to_bytes<u8>(&arg2), arg3, arg4)
    }

    public fun propose_update_config(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) : u64 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_spread(arg2);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_min_apy(arg3);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_cooldown(arg4);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_slippage(arg5, false);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg9));
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_crank_config(), v0, arg10, arg11)
    }

    public fun propose_update_fee(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_rewards_fee(arg2);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_fee(), 0x2::bcs::to_bytes<u64>(&arg2), arg3, arg4)
    }

    public fun propose_update_has_rewards(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: u8, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg3));
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 26, v0, arg4, arg5)
    }

    public fun propose_update_tee_key(arg0: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap, arg1: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::TimelockRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 910);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::propose(arg1, arg0, 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_tee_key(), 0x2::bcs::to_bytes<vector<u8>>(&arg2), arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

