module 0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeParameters has copy, drop, store {
        base_factor: u32,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        bin_steps: 0x2::vec_map::VecMap<u16, FeeParameters>,
        flash_loan_fee_rate: u64,
        flash_loan_max_amount: u64,
        quote_asset_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        allow_create_pair: bool,
        acl: 0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::ACL,
        package_version: u64,
    }

    struct InitConfigEvent has copy, drop {
        global_config_id: 0x2::object::ID,
    }

    struct SetBinStepEvent has copy, drop {
        bin_step: u16,
        base_factor: u32,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct DeleteBinStepEvent has copy, drop {
        bin_step: u16,
    }

    struct UpdateFlashLoanFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun acl(arg0: &GlobalConfig) : &0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::ACL {
        &arg0.acl
    }

    public fun cancel(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::cancel(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun execute(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::execute(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun get_fund_receiver(arg0: &GlobalConfig) : address {
        0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::get_fund_receiver(&arg0.acl)
    }

    public fun get_reward_receiver(arg0: &GlobalConfig) : address {
        0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::get_reward_receiver(&arg0.acl)
    }

    public fun propose(arg0: &mut GlobalConfig, arg1: u8, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        checked_package_version(arg0);
        0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::propose(&mut arg0.acl, arg1, arg2, arg3, arg4, arg5)
    }

    public fun set_publisher(arg0: &mut GlobalConfig, arg1: 0x2::package::Publisher, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::set_publisher(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun set_upgrade_cap(arg0: &mut GlobalConfig, arg1: 0x2::package::UpgradeCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::set_upgrade_cap(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun vote(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::vote(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun add_update_bin_step(arg0: &mut GlobalConfig, arg1: u16, arg2: u32, arg3: u16, arg4: u16, arg5: u16, arg6: u32, arg7: u16, arg8: u32, arg9: &0x2::tx_context::TxContext) {
        assert!(arg1 >= 1, 1);
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg9));
        let v0 = FeeParameters{
            base_factor                : arg2,
            filter_period              : arg3,
            decay_period               : arg4,
            reduction_factor           : arg5,
            variable_fee_control       : arg6,
            protocol_share             : arg7,
            max_volatility_accumulator : arg8,
        };
        if (!bin_step_exists(arg0, arg1)) {
            0x2::vec_map::insert<u16, FeeParameters>(&mut arg0.bin_steps, arg1, v0);
        } else {
            *0x2::vec_map::get_mut<u16, FeeParameters>(&mut arg0.bin_steps, &arg1) = v0;
        };
        let v1 = SetBinStepEvent{
            bin_step                   : arg1,
            base_factor                : arg2,
            filter_period              : arg3,
            decay_period               : arg4,
            reduction_factor           : arg5,
            variable_fee_control       : arg6,
            protocol_share             : arg7,
            max_volatility_accumulator : arg8,
        };
        0x2::event::emit<SetBinStepEvent>(v1);
    }

    public fun add_whitelist_token<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, v0);
        };
    }

    public fun base_factor(arg0: &GlobalConfig, arg1: u16) : u32 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).base_factor
    }

    public fun bin_step_exists(arg0: &GlobalConfig, arg1: u16) : bool {
        0x2::vec_map::contains<u16, FeeParameters>(&arg0.bin_steps, &arg1)
    }

    public fun check_operator_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::has_role(&arg0.acl, arg1, 0), 6);
    }

    public fun check_protocol_fee_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::has_role(&arg0.acl, arg1, 2), 6);
    }

    public fun check_reward_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::has_role(&arg0.acl, arg1, 1), 6);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version <= 1, 10);
    }

    public fun decay_period(arg0: &GlobalConfig, arg1: u16) : u16 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).decay_period
    }

    public fun delete_bin_step(arg0: &mut GlobalConfig, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 >= 1, 1);
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg2));
        let (_, _) = 0x2::vec_map::remove<u16, FeeParameters>(&mut arg0.bin_steps, &arg1);
        let v2 = DeleteBinStepEvent{bin_step: arg1};
        0x2::event::emit<DeleteBinStepEvent>(v2);
    }

    public fun delete_whitelist_token<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, &v0);
        };
    }

    public fun filter_period(arg0: &GlobalConfig, arg1: u16) : u16 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).filter_period
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            bin_steps             : 0x2::vec_map::empty<u16, FeeParameters>(),
            flash_loan_fee_rate   : 0,
            flash_loan_max_amount : 30000,
            quote_asset_whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            allow_create_pair     : false,
            acl                   : 0xcdcd36c1086ccd9dc1dc081c36d73b70bce9eadd1ed67cfcb2d254a324ca5358::acl::new(arg0),
            package_version       : 1,
        };
        let v1 = InitConfigEvent{global_config_id: 0x2::object::id<GlobalConfig>(&v0)};
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::event::emit<InitConfigEvent>(v1);
    }

    public fun is_in_whitelist(arg0: &GlobalConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &arg1)
    }

    public fun max_reward_per_fee_rate() : u128 {
        18446744073709551616000
    }

    public fun max_reward_time_delta() : u64 {
        86400
    }

    public fun max_volatility_accumulator(arg0: &GlobalConfig, arg1: u16) : u32 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).max_volatility_accumulator
    }

    public fun package_version() : u64 {
        1
    }

    public fun protocol_share(arg0: &GlobalConfig, arg1: u16) : u16 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).protocol_share
    }

    public fun reduction_factor(arg0: &GlobalConfig, arg1: u16) : u16 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).reduction_factor
    }

    public fun set_allow_create_pair(arg0: &mut GlobalConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.allow_create_pair = arg1;
    }

    public fun update_flash_loan_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 <= 100000, 5001);
        arg0.flash_loan_fee_rate = arg1;
        let v0 = UpdateFlashLoanFeeRateEvent{
            old_fee_rate : arg0.flash_loan_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFlashLoanFeeRateEvent>(v0);
    }

    public fun update_flash_loan_max_amount(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 <= 30000 * 2, 5002);
        arg0.flash_loan_max_amount = arg1;
    }

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_operator_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.package_version = arg1;
        let v0 = SetPackageVersion{
            new_version : arg1,
            old_version : arg0.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public fun validate_bin_step(arg0: u16) {
        assert!(arg0 <= 5000 && arg0 >= 1, 5000);
    }

    public fun variable_fee_control(arg0: &GlobalConfig, arg1: u16) : u32 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).variable_fee_control
    }

    public fun whitelist_tokens(arg0: &GlobalConfig) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.quote_asset_whitelist
    }

    // decompiled from Move bytecode v6
}

