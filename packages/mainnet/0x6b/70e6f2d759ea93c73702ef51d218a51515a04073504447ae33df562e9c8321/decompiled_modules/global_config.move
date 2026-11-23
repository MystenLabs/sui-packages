module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        is_paused: bool,
        pausers: 0x2::vec_set::VecSet<address>,
        keepers: 0x2::vec_set::VecSet<address>,
        redeem_operators: 0x2::vec_set::VecSet<address>,
        risk_managers: 0x2::vec_set::VecSet<address>,
        protocol_fee_share_bps: u64,
        liquidator_fee_bps: u64,
        insurance_fee_bps: u64,
        max_skipped_orders_per_match: u64,
        oi_cap_bps: u64,
        price_refresh_threshold_ms: u64,
    }

    struct GlobalVault<phantom T0> has store {
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::witness::WaterXPerp>,
        balance: 0x2::balance::Balance<T0>,
        protocol_fee_balance: 0x2::balance::Balance<T0>,
        insurance_fee_balance: 0x2::balance::Balance<T0>,
    }

    public fun add_keeper(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.keepers, arg2);
    }

    public fun add_pauser(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg0.pausers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.pausers, arg2);
        };
    }

    public fun add_redeem_operator(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.redeem_operators, arg2);
    }

    public fun add_risk_manager(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.risk_managers, arg2);
    }

    public fun allow_version(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
        };
    }

    public fun allowed_versions(arg0: &GlobalConfig) : vector<u16> {
        *0x2::vec_set::keys<u16>(&arg0.allowed_versions)
    }

    public fun assert_active(arg0: &GlobalConfig) {
        if (arg0.is_paused) {
            abort 13906835273855270917
        };
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            abort 13906835282445074435
        };
    }

    public fun assert_not_paused(arg0: &GlobalConfig) {
        if (arg0.is_paused) {
            abort 13906835239495532549
        };
    }

    public fun assert_version(arg0: &GlobalConfig) {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            abort 13906834625315078147
        };
    }

    public(friend) fun balance_mut<T0>(arg0: &mut GlobalConfig) : &mut 0x2::balance::Balance<T0> {
        ensure_vault<T0>(arg0);
        &mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, GlobalVault<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()).balance
    }

    public fun claim_insurance_fee<T0>(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0)) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, GlobalVault<T0>>(&mut arg0.id, v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.insurance_fee_balance, 0x2::balance::value<T0>(&v1.insurance_fee_balance)), arg2)
    }

    public fun claim_protocol_fee<T0>(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0)) {
            return 0x2::coin::zero<T0>(arg2)
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, GlobalVault<T0>>(&mut arg0.id, v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.protocol_fee_balance, 0x2::balance::value<T0>(&v1.protocol_fee_balance)), arg2)
    }

    public fun disallow_version(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
        };
    }

    fun ensure_vault<T0>(arg0: &mut GlobalConfig) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0)) {
            let v1 = GlobalVault<T0>{
                sheet                 : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T0, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::witness::WaterXPerp>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::witness::witness()),
                balance               : 0x2::balance::zero<T0>(),
                protocol_fee_balance  : 0x2::balance::zero<T0>(),
                insurance_fee_balance : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_field::add<0x1::type_name::TypeName, GlobalVault<T0>>(&mut arg0.id, v0, v1);
        };
    }

    public(friend) fun global_config_uid(arg0: &GlobalConfig) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun global_config_uid_mut(arg0: &mut GlobalConfig) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                           : 0x2::object::new(arg0),
            allowed_versions             : 0x2::vec_set::singleton<u16>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::version::package_version()),
            is_paused                    : false,
            pausers                      : 0x2::vec_set::empty<address>(),
            keepers                      : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            redeem_operators             : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            risk_managers                : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            protocol_fee_share_bps       : 3000,
            liquidator_fee_bps           : 0,
            insurance_fee_bps            : 100,
            max_skipped_orders_per_match : 100,
            oi_cap_bps                   : 0,
            price_refresh_threshold_ms   : 0,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public(friend) fun insurance_fee_balance_mut<T0>(arg0: &mut GlobalConfig) : &mut 0x2::balance::Balance<T0> {
        ensure_vault<T0>(arg0);
        &mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, GlobalVault<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()).insurance_fee_balance
    }

    public fun insurance_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.insurance_fee_bps
    }

    public fun insurance_fee_value<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0).insurance_fee_balance)
    }

    public(friend) fun is_keeper(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.is_paused
    }

    public fun keeper_addresses(arg0: &GlobalConfig) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.keepers)
    }

    public fun keeper_count(arg0: &GlobalConfig) : u64 {
        0x2::vec_set::length<address>(&arg0.keepers)
    }

    public fun liquidator_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.liquidator_fee_bps
    }

    public fun max_skipped_orders_per_match(arg0: &GlobalConfig) : u64 {
        arg0.max_skipped_orders_per_match
    }

    public fun oi_cap_bps(arg0: &GlobalConfig) : u64 {
        arg0.oi_cap_bps
    }

    public fun pause(arg0: &mut GlobalConfig, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.pausers, &v0)) {
            abort 13906835389819518983
        };
        arg0.is_paused = true;
    }

    public fun pauser_addresses(arg0: &GlobalConfig) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.pausers)
    }

    public fun pauser_count(arg0: &GlobalConfig) : u64 {
        0x2::vec_set::length<address>(&arg0.pausers)
    }

    public fun price_refresh_threshold_ms(arg0: &GlobalConfig) : u64 {
        arg0.price_refresh_threshold_ms
    }

    public(friend) fun protocol_fee_balance_mut<T0>(arg0: &mut GlobalConfig) : &mut 0x2::balance::Balance<T0> {
        ensure_vault<T0>(arg0);
        &mut 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, GlobalVault<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()).protocol_fee_balance
    }

    public fun protocol_fee_share_bps(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_share_bps
    }

    public fun protocol_fee_value<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0).protocol_fee_balance)
    }

    public fun redeem_operator_addresses(arg0: &GlobalConfig) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.redeem_operators)
    }

    public fun redeem_operator_count(arg0: &GlobalConfig) : u64 {
        0x2::vec_set::length<address>(&arg0.redeem_operators)
    }

    public fun remove_keeper(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.keepers, &arg2);
    }

    public fun remove_pauser(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg0.pausers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.pausers, &arg2);
        };
    }

    public fun remove_redeem_operator(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.redeem_operators, &arg2);
    }

    public fun remove_risk_manager(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.risk_managers, &arg2);
    }

    public fun risk_manager_addresses(arg0: &GlobalConfig) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.risk_managers)
    }

    public fun set_insurance_fee_bps(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u64) {
        arg0.insurance_fee_bps = arg2;
    }

    public fun set_liquidator_fee_bps(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u64) {
        arg0.liquidator_fee_bps = arg2;
    }

    public fun set_max_skipped_orders_per_match(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u64) {
        arg0.max_skipped_orders_per_match = arg2;
    }

    public fun set_oi_cap_bps(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u64) {
        arg0.oi_cap_bps = arg2;
    }

    public fun set_price_refresh_threshold_ms(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u64) {
        arg0.price_refresh_threshold_ms = arg2;
    }

    public fun set_protocol_fee_share(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u64) {
        if (arg2 > 10000) {
            abort 13906835205135532033
        };
        arg0.protocol_fee_share_bps = arg2;
    }

    public fun unpause(arg0: &mut GlobalConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap) {
        arg0.is_paused = false;
    }

    public(friend) fun vault_balance<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T0>(&0x2::dynamic_field::borrow<0x1::type_name::TypeName, GlobalVault<T0>>(&arg0.id, v0).balance)
        }
    }

    public(friend) fun verify_keeper(arg0: &GlobalConfig, arg1: address) {
        assert_version(arg0);
        if (!0x2::vec_set::contains<address>(&arg0.keepers, &arg1)) {
            abort 13906835471423897607
        };
    }

    public(friend) fun verify_redeem_operator(arg0: &GlobalConfig, arg1: address) {
        assert_version(arg0);
        if (!0x2::vec_set::contains<address>(&arg0.redeem_operators, &arg1)) {
            abort 13906835497193701383
        };
    }

    public(friend) fun verify_risk_manager(arg0: &GlobalConfig, arg1: address) {
        assert_version(arg0);
        if (!0x2::vec_set::contains<address>(&arg0.risk_managers, &arg1)) {
            abort 13906835522963505159
        };
    }

    // decompiled from Move bytecode v7
}

