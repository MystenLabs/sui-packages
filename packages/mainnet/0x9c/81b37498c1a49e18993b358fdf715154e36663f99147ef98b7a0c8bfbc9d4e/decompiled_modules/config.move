module 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::config {
    struct FeeTier has copy, drop, store {
        tick_spacing: u32,
        fee_rate: u64,
        fee_scheduler: FeeScheduler,
        dynamic_fee: DynamicFee,
    }

    struct LinearFeeScheduler has copy, drop, store {
        cliff_fee_numerator: u64,
        period_frequency: u64,
        number_of_period: u16,
        reduction_factor: u64,
    }

    struct ExponentialFeeScheduler has copy, drop, store {
        cliff_fee_numerator: u64,
        period_frequency: u64,
        number_of_period: u16,
        reduction_factor: u64,
    }

    struct FeeScheduler has copy, drop, store {
        linear: LinearFeeScheduler,
        exponential: ExponentialFeeScheduler,
    }

    struct DynamicFee has copy, drop, store {
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        max_volatility_accumulator: u32,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_rate: u64,
        flash_loan_enable: bool,
        pause: bool,
        fee_tiers: 0x2::vec_map::VecMap<u32, FeeTier>,
        allow_create_pair: bool,
        acl: 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::ACL,
        package_version: u64,
        quote_asset_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct InitConfigEvent has copy, drop {
        global_config_id: 0x2::object::ID,
    }

    struct UpdateFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct AddWhitelistTokenEvent has copy, drop {
        token: 0x1::type_name::TypeName,
    }

    struct RemoveWhitelistTokenEvent has copy, drop {
        token: 0x1::type_name::TypeName,
    }

    struct AddFeeTierEvent has copy, drop {
        tick_spacing: u32,
        fee_rate: u64,
        fee_scheduler: FeeScheduler,
        dynamic_fee: DynamicFee,
    }

    struct UpdateFeeTierEvent has copy, drop {
        tick_spacing: u32,
        old_fee_rate: u64,
        new_fee_rate: u64,
        fee_scheduler: FeeScheduler,
        dynamic_fee: DynamicFee,
    }

    struct DeleteFeeTierEvent has copy, drop {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun acl(arg0: &GlobalConfig) : &0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::ACL {
        &arg0.acl
    }

    public fun cancel(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::cancel(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun execute(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::execute(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun get_fund_receiver(arg0: &GlobalConfig) : address {
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::get_fund_receiver(&arg0.acl)
    }

    public fun get_reward_receiver(arg0: &GlobalConfig) : address {
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::get_reward_receiver(&arg0.acl)
    }

    public fun propose(arg0: &mut GlobalConfig, arg1: u8, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        checked_package_version(arg0);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::propose(&mut arg0.acl, arg1, arg2, arg3, arg4, arg5)
    }

    public fun set_default_upgrade_cap_id(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::set_default_upgrade_cap_id(&mut arg0.acl, arg1, arg2);
    }

    public fun set_publisher(arg0: &mut GlobalConfig, arg1: 0x2::package::Publisher, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::set_publisher(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun set_upgrade_cap(arg0: &mut GlobalConfig, arg1: 0x2::package::UpgradeCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::set_upgrade_cap(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun vote(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::vote(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun add_update_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: u64, arg3: u64, arg4: u16, arg5: u64, arg6: u64, arg7: u64, arg8: u16, arg9: u64, arg10: u64, arg11: u16, arg12: u16, arg13: u16, arg14: u32, arg15: u32, arg16: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg16));
        assert!(arg1 > 0, 207);
        assert!(arg2 <= 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::constants::max_fee_rate(), 202);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::fee_helper::validate_base_fee(arg2, 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::constants::fee_scheduler_mode_linear(), arg3, arg4, arg5, arg6);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::fee_helper::validate_base_fee(arg2, 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::constants::fee_scheduler_mode_exponential(), arg7, arg8, arg9, arg10);
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::fee_helper::validate_dynamic_fee_parameters(arg11, arg12, arg13, arg14, arg15);
        let v0 = LinearFeeScheduler{
            cliff_fee_numerator : arg3,
            period_frequency    : arg5,
            number_of_period    : arg4,
            reduction_factor    : arg6,
        };
        let v1 = ExponentialFeeScheduler{
            cliff_fee_numerator : arg7,
            period_frequency    : arg9,
            number_of_period    : arg8,
            reduction_factor    : arg10,
        };
        let v2 = FeeScheduler{
            linear      : v0,
            exponential : v1,
        };
        let v3 = DynamicFee{
            filter_period              : arg11,
            decay_period               : arg12,
            reduction_factor           : arg13,
            variable_fee_control       : arg14,
            max_volatility_accumulator : arg15,
        };
        let v4 = FeeTier{
            tick_spacing  : arg1,
            fee_rate      : arg2,
            fee_scheduler : v2,
            dynamic_fee   : v3,
        };
        if (!fee_tier_exists(arg0, arg1)) {
            0x2::vec_map::insert<u32, FeeTier>(&mut arg0.fee_tiers, arg1, v4);
        } else {
            *0x2::vec_map::get_mut<u32, FeeTier>(&mut arg0.fee_tiers, &arg1) = v4;
        };
        let v5 = UpdateFeeTierEvent{
            tick_spacing  : arg1,
            old_fee_rate  : v4.fee_rate,
            new_fee_rate  : arg2,
            fee_scheduler : v4.fee_scheduler,
            dynamic_fee   : v4.dynamic_fee,
        };
        0x2::event::emit<UpdateFeeTierEvent>(v5);
    }

    public fun add_whitelist_token<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, v0);
        };
        let v1 = AddWhitelistTokenEvent{token: v0};
        0x2::event::emit<AddWhitelistTokenEvent>(v1);
    }

    public fun check_config_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::has_role(&arg0.acl, arg1, 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::config_role()), 205);
    }

    public fun check_pool_creator_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::has_role(&arg0.acl, arg1, 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::pool_creator_role()), 205);
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::has_role(&arg0.acl, arg1, 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::pool_manager_role()), 205);
    }

    public fun check_reward_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::has_role(&arg0.acl, arg1, 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::reward_role()), 205);
    }

    public fun check_upgrade_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::has_role(&arg0.acl, arg1, 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::upgrade_role()), 205);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version <= 1, 204);
    }

    public fun decay_period(arg0: &GlobalConfig, arg1: u32) : u16 {
        0x2::vec_map::get<u32, FeeTier>(&arg0.fee_tiers, &arg1).dynamic_fee.decay_period
    }

    public fun delete_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<u32, FeeTier>(&arg0.fee_tiers, &arg1), 201);
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg2));
        let (_, v1) = 0x2::vec_map::remove<u32, FeeTier>(&mut arg0.fee_tiers, &arg1);
        let v2 = v1;
        let v3 = DeleteFeeTierEvent{
            tick_spacing : arg1,
            fee_rate     : v2.fee_rate,
        };
        0x2::event::emit<DeleteFeeTierEvent>(v3);
    }

    public fun delete_whitelist_token<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, &v0);
        };
        let v1 = RemoveWhitelistTokenEvent{token: v0};
        0x2::event::emit<RemoveWhitelistTokenEvent>(v1);
    }

    public fun exponential_fee_scheduler(arg0: &GlobalConfig, arg1: u32) : (u64, u16, u64, u64) {
        let v0 = &0x2::vec_map::get<u32, FeeTier>(&arg0.fee_tiers, &arg1).fee_scheduler.exponential;
        (v0.cliff_fee_numerator, v0.number_of_period, v0.period_frequency, v0.reduction_factor)
    }

    public fun fee_rate(arg0: &FeeTier) : u64 {
        arg0.fee_rate
    }

    public fun fee_tier_exists(arg0: &GlobalConfig, arg1: u32) : bool {
        0x2::vec_map::contains<u32, FeeTier>(&arg0.fee_tiers, &arg1)
    }

    public fun fee_tiers(arg0: &GlobalConfig) : &0x2::vec_map::VecMap<u32, FeeTier> {
        &arg0.fee_tiers
    }

    public fun filter_period(arg0: &GlobalConfig, arg1: u32) : u16 {
        0x2::vec_map::get<u32, FeeTier>(&arg0.fee_tiers, &arg1).dynamic_fee.filter_period
    }

    public fun flash_loan_enable(arg0: &GlobalConfig) : bool {
        arg0.flash_loan_enable
    }

    public fun get_allow_create_pair(arg0: &GlobalConfig) : bool {
        arg0.allow_create_pair
    }

    public fun get_decay_period(arg0: &GlobalConfig, arg1: u32) : u16 {
        let v0 = get_dynamic_fee_config(arg0, arg1);
        v0.decay_period
    }

    public fun get_dynamic_fee_config(arg0: &GlobalConfig, arg1: u32) : DynamicFee {
        assert!(0x2::vec_map::contains<u32, FeeTier>(&arg0.fee_tiers, &arg1), 201);
        0x2::vec_map::get<u32, FeeTier>(&arg0.fee_tiers, &arg1).dynamic_fee
    }

    public fun get_fee_rate(arg0: u32, arg1: &GlobalConfig) : u64 {
        assert!(0x2::vec_map::contains<u32, FeeTier>(&arg1.fee_tiers, &arg0), 201);
        0x2::vec_map::get<u32, FeeTier>(&arg1.fee_tiers, &arg0).fee_rate
    }

    public fun get_filter_period(arg0: &GlobalConfig, arg1: u32) : u16 {
        let v0 = get_dynamic_fee_config(arg0, arg1);
        v0.filter_period
    }

    public fun get_max_volatility_accumulator(arg0: &GlobalConfig, arg1: u32) : u32 {
        let v0 = get_dynamic_fee_config(arg0, arg1);
        v0.max_volatility_accumulator
    }

    public fun get_protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun get_reduction_factor(arg0: &GlobalConfig, arg1: u32) : u16 {
        let v0 = get_dynamic_fee_config(arg0, arg1);
        v0.reduction_factor
    }

    public fun get_variable_fee_control(arg0: &GlobalConfig, arg1: u32) : u32 {
        let v0 = get_dynamic_fee_config(arg0, arg1);
        v0.variable_fee_control
    }

    public fun global_paused(arg0: &GlobalConfig) : bool {
        arg0.pause
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            protocol_fee_rate     : 2000,
            flash_loan_enable     : false,
            pause                 : false,
            fee_tiers             : 0x2::vec_map::empty<u32, FeeTier>(),
            allow_create_pair     : false,
            acl                   : 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::new(arg0),
            package_version       : 1,
            quote_asset_whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = InitConfigEvent{global_config_id: 0x2::object::id<GlobalConfig>(&v0)};
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::event::emit<InitConfigEvent>(v1);
    }

    public fun is_config_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::has_role(&arg0.acl, arg1, 0x9c81b37498c1a49e18993b358fdf715154e36663f99147ef98b7a0c8bfbc9d4e::acl::config_role())
    }

    public fun is_in_whitelist<T0>(arg0: &GlobalConfig) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)
    }

    public fun linear_fee_scheduler(arg0: &GlobalConfig, arg1: u32) : (u64, u16, u64, u64) {
        let v0 = &0x2::vec_map::get<u32, FeeTier>(&arg0.fee_tiers, &arg1).fee_scheduler.linear;
        (v0.cliff_fee_numerator, v0.number_of_period, v0.period_frequency, v0.reduction_factor)
    }

    public fun max_protocol_fee_rate() : u64 {
        3000
    }

    public fun max_volatility_accumulator(arg0: &GlobalConfig, arg1: u32) : u32 {
        0x2::vec_map::get<u32, FeeTier>(&arg0.fee_tiers, &arg1).dynamic_fee.max_volatility_accumulator
    }

    public fun package_version() : u64 {
        1
    }

    public fun protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun reduction_factor(arg0: &GlobalConfig, arg1: u32) : u16 {
        0x2::vec_map::get<u32, FeeTier>(&arg0.fee_tiers, &arg1).dynamic_fee.reduction_factor
    }

    public fun set_allow_create_pair(arg0: &mut GlobalConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.allow_create_pair = arg1;
    }

    public fun set_flash_loan_enable(arg0: &mut GlobalConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.flash_loan_enable = arg1;
    }

    public fun set_pause(arg0: &mut GlobalConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.pause = arg1;
    }

    public fun tick_spacing(arg0: &FeeTier) : u32 {
        arg0.tick_spacing
    }

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_upgrade_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = arg0.package_version;
        assert!(arg1 > v0, 206);
        arg0.package_version = arg1;
        let v1 = SetPackageVersion{
            new_version : arg1,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    public fun update_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 3000, 203);
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.protocol_fee_rate = arg1;
        let v0 = UpdateFeeRateEvent{
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    public fun variable_fee_control(arg0: &GlobalConfig, arg1: u32) : u32 {
        0x2::vec_map::get<u32, FeeTier>(&arg0.fee_tiers, &arg1).dynamic_fee.variable_fee_control
    }

    public fun whitelist_tokens(arg0: &GlobalConfig) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.quote_asset_whitelist
    }

    // decompiled from Move bytecode v6
}

