module 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeParameters has copy, drop, store {
        base_factor: u32,
        protocol_share: u16,
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
        pause: bool,
        fee_tiers: 0x2::vec_map::VecMap<u32, FeeParameters>,
        flash_loan_enable: bool,
        flash_loan_fee_rate: u64,
        flash_loan_max_amount: u64,
        quote_asset_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allow_create_pair: bool,
        acl: 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::ACL,
        package_version: u64,
    }

    struct BinRange has copy, drop, store {
        min_bin: u32,
        max_bin: u32,
    }

    struct InitConfigEvent has copy, drop {
        global_config_id: 0x2::object::ID,
    }

    struct SetBinRangeEvent has copy, drop {
        bin_step: u16,
        min_bin: u32,
        max_bin: u32,
    }

    struct DeleteBinRangeEvent has copy, drop {
        bin_step: u16,
    }

    struct SetFeeTierEvent has copy, drop {
        base_factor: u32,
        protocol_share: u16,
        fee_scheduler: FeeScheduler,
        dynamic_fee: DynamicFee,
    }

    struct DeleteFeeTierEvent has copy, drop {
        base_factor: u32,
    }

    struct UpdateFlashLoanFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun acl(arg0: &GlobalConfig) : &0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::ACL {
        &arg0.acl
    }

    public fun cancel(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::cancel(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun execute(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::execute(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun get_fund_receiver(arg0: &GlobalConfig) : address {
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::get_fund_receiver(&arg0.acl)
    }

    public fun get_reward_receiver(arg0: &GlobalConfig) : address {
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::get_reward_receiver(&arg0.acl)
    }

    public fun propose(arg0: &mut GlobalConfig, arg1: u8, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        checked_package_version(arg0);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::propose(&mut arg0.acl, arg1, arg2, arg3, arg4, arg5)
    }

    public fun set_default_upgrade_cap_id(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::set_default_upgrade_cap_id(&mut arg0.acl, arg1, arg2);
    }

    public fun set_publisher(arg0: &mut GlobalConfig, arg1: 0x2::package::Publisher, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::set_publisher(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun set_upgrade_cap(arg0: &mut GlobalConfig, arg1: 0x2::package::UpgradeCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::set_upgrade_cap(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun vote(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::vote(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun add_update_bin_range(arg0: &mut GlobalConfig, arg1: u16, arg2: u32, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg3 >= arg2, 5006);
        validate_bin_step(arg1);
        let v0 = b"bin_range";
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            let v1 = 0x2::vec_map::empty<u16, BinRange>();
            let v2 = BinRange{
                min_bin : arg2,
                max_bin : arg3,
            };
            0x2::vec_map::insert<u16, BinRange>(&mut v1, arg1, v2);
            0x2::dynamic_field::add<vector<u8>, 0x2::vec_map::VecMap<u16, BinRange>>(&mut arg0.id, v0, v1);
        } else {
            let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::vec_map::VecMap<u16, BinRange>>(&mut arg0.id, v0);
            if (0x2::vec_map::contains<u16, BinRange>(v3, &arg1)) {
                let v4 = 0x2::vec_map::get_mut<u16, BinRange>(v3, &arg1);
                v4.min_bin = arg2;
                v4.max_bin = arg3;
            } else {
                let v5 = BinRange{
                    min_bin : arg2,
                    max_bin : arg3,
                };
                0x2::vec_map::insert<u16, BinRange>(v3, arg1, v5);
            };
        };
        let v6 = SetBinRangeEvent{
            bin_step : arg1,
            min_bin  : arg2,
            max_bin  : arg3,
        };
        0x2::event::emit<SetBinRangeEvent>(v6);
    }

    public fun add_update_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: u16, arg3: u64, arg4: u16, arg5: u64, arg6: u64, arg7: u64, arg8: u16, arg9: u64, arg10: u64, arg11: u16, arg12: u16, arg13: u16, arg14: u32, arg15: u32, arg16: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg16));
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::fee_helper::validate_fee_scheduler_linear(arg3, arg4, arg5, arg6);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::fee_helper::validate_fee_scheduler_exponential(arg7, arg8, arg9, arg10);
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::fee_helper::validate_fee_parameters(arg1, arg11, arg12, arg13, arg14, arg2, arg15);
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
        let v4 = FeeParameters{
            base_factor    : arg1,
            protocol_share : arg2,
            fee_scheduler  : v2,
            dynamic_fee    : v3,
        };
        if (!fee_tier_exists(arg0, arg1)) {
            0x2::vec_map::insert<u32, FeeParameters>(&mut arg0.fee_tiers, arg1, v4);
        } else {
            *0x2::vec_map::get_mut<u32, FeeParameters>(&mut arg0.fee_tiers, &arg1) = v4;
        };
        let v5 = SetFeeTierEvent{
            base_factor    : arg1,
            protocol_share : arg2,
            fee_scheduler  : v4.fee_scheduler,
            dynamic_fee    : v4.dynamic_fee,
        };
        0x2::event::emit<SetFeeTierEvent>(v5);
    }

    public fun add_whitelist_token<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, v0);
        };
    }

    public fun base_factor(arg0: &GlobalConfig, arg1: u32) : u32 {
        0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).base_factor
    }

    public fun check_config_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::has_role(&arg0.acl, arg1, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::config_role()), 5003);
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::has_role(&arg0.acl, arg1, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::pool_manager_role()), 5003);
    }

    public fun check_reward_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::has_role(&arg0.acl, arg1, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::reward_role()), 5003);
    }

    public fun check_upgrade_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::has_role(&arg0.acl, arg1, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::upgrade_role()), 5003);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version <= 3, 5004);
    }

    public fun decay_period(arg0: &GlobalConfig, arg1: u32) : u16 {
        0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).dynamic_fee.decay_period
    }

    public fun delete_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 <= 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::constants::max_base_factor(), 5007);
        let (_, _) = 0x2::vec_map::remove<u32, FeeParameters>(&mut arg0.fee_tiers, &arg1);
        let v2 = DeleteFeeTierEvent{base_factor: arg1};
        0x2::event::emit<DeleteFeeTierEvent>(v2);
    }

    public fun delete_whitelist_token<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, &v0);
        };
    }

    public fun exponential_fee_scheduler(arg0: &GlobalConfig, arg1: u32) : (u64, u16, u64, u64) {
        let v0 = &0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).fee_scheduler.exponential;
        (v0.cliff_fee_numerator, v0.number_of_period, v0.period_frequency, v0.reduction_factor)
    }

    public fun fee_tier_exists(arg0: &GlobalConfig, arg1: u32) : bool {
        0x2::vec_map::contains<u32, FeeParameters>(&arg0.fee_tiers, &arg1)
    }

    public fun filter_period(arg0: &GlobalConfig, arg1: u32) : u16 {
        0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).dynamic_fee.filter_period
    }

    public fun flash_loan_enable(arg0: &GlobalConfig) : bool {
        arg0.flash_loan_enable
    }

    public fun flash_loan_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.flash_loan_fee_rate
    }

    public fun flash_loan_max_amount(arg0: &GlobalConfig) : u64 {
        arg0.flash_loan_max_amount
    }

    public fun get_allow_create_pair(arg0: &GlobalConfig) : bool {
        arg0.allow_create_pair
    }

    public fun get_bin_range(arg0: &GlobalConfig, arg1: u16) : (u32, u32) {
        let v0 = b"bin_range";
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0), 5005);
        let v1 = 0x2::dynamic_field::borrow<vector<u8>, 0x2::vec_map::VecMap<u16, BinRange>>(&arg0.id, v0);
        assert!(0x2::vec_map::contains<u16, BinRange>(v1, &arg1), 5000);
        let v2 = 0x2::vec_map::get<u16, BinRange>(v1, &arg1);
        (v2.min_bin, v2.max_bin)
    }

    public fun global_paused(arg0: &GlobalConfig) : bool {
        arg0.pause
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            pause                 : false,
            fee_tiers             : 0x2::vec_map::empty<u32, FeeParameters>(),
            flash_loan_enable     : true,
            flash_loan_fee_rate   : 0,
            flash_loan_max_amount : 300000000,
            quote_asset_whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            allow_create_pair     : false,
            acl                   : 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::new(arg0),
            package_version       : 3,
        };
        let v1 = InitConfigEvent{global_config_id: 0x2::object::id<GlobalConfig>(&v0)};
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::event::emit<InitConfigEvent>(v1);
    }

    public fun is_config_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::has_role(&arg0.acl, arg1, 0x1d5604c75710adb4303c3c31e1a7173e3e207f7a605c0b4c9aeec7fca89e3a89::acl::config_role())
    }

    public fun is_in_whitelist(arg0: &GlobalConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &arg1)
    }

    public fun linear_fee_scheduler(arg0: &GlobalConfig, arg1: u32) : (u64, u16, u64, u64) {
        let v0 = &0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).fee_scheduler.linear;
        (v0.cliff_fee_numerator, v0.number_of_period, v0.period_frequency, v0.reduction_factor)
    }

    public fun max_volatility_accumulator(arg0: &GlobalConfig, arg1: u32) : u32 {
        0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).dynamic_fee.max_volatility_accumulator
    }

    public fun package_version() : u64 {
        3
    }

    public fun protocol_share(arg0: &GlobalConfig, arg1: u32) : u16 {
        0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).protocol_share
    }

    public fun reduction_factor(arg0: &GlobalConfig, arg1: u32) : u16 {
        0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).dynamic_fee.reduction_factor
    }

    public fun remove_bin_range(arg0: &mut GlobalConfig, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg2));
        validate_bin_step(arg1);
        let v0 = b"bin_range";
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0), 5005);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::vec_map::VecMap<u16, BinRange>>(&mut arg0.id, v0);
        if (!0x2::vec_map::contains<u16, BinRange>(v1, &arg1)) {
            abort 5000
        };
        let (_, _) = 0x2::vec_map::remove<u16, BinRange>(v1, &arg1);
        let v4 = DeleteBinRangeEvent{bin_step: arg1};
        0x2::event::emit<DeleteBinRangeEvent>(v4);
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

    public fun update_flash_loan_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_config_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 <= 100000000, 5001);
        arg0.flash_loan_fee_rate = arg1;
        let v0 = UpdateFlashLoanFeeRateEvent{
            old_fee_rate : arg0.flash_loan_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFlashLoanFeeRateEvent>(v0);
    }

    public fun update_flash_loan_max_amount(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_upgrade_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = arg0.package_version;
        assert!(arg1 > v0, 5004);
        arg0.package_version = arg1;
        let v1 = SetPackageVersion{
            new_version : arg1,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    public fun validate_bin_step(arg0: u16) {
        assert!(arg0 <= 5000 && arg0 >= 1, 5000);
    }

    public fun variable_fee_control(arg0: &GlobalConfig, arg1: u32) : u32 {
        0x2::vec_map::get<u32, FeeParameters>(&arg0.fee_tiers, &arg1).dynamic_fee.variable_fee_control
    }

    public fun whitelist_tokens(arg0: &GlobalConfig) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.quote_asset_whitelist
    }

    // decompiled from Move bytecode v6
}

