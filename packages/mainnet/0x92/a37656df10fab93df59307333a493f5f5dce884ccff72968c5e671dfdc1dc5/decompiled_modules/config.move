module 0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::config {
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
        quote_asset_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        acl: 0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::ACL,
        package_version: u64,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
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

    public fun acl(arg0: &GlobalConfig) : &0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::ACL {
        &arg0.acl
    }

    public fun add_role(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u8) {
        checked_package_version(arg0);
        0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::add_role(&mut arg0.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::Member> {
        0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        checked_package_version(arg0);
        0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::remove_member(&mut arg0.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u8) {
        checked_package_version(arg0);
        0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::remove_role(&mut arg0.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u128) {
        checked_package_version(arg0);
        0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::set_roles(&mut arg0.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun add_update_bin_step(arg0: &mut GlobalConfig, arg1: u16, arg2: u32, arg3: u16, arg4: u16, arg5: u16, arg6: u32, arg7: u16, arg8: u32, arg9: &0x2::tx_context::TxContext) {
        assert!(arg1 >= 1, 1);
        checked_package_version(arg0);
        check_bin_step_manager_role(arg0, 0x2::tx_context::sender(arg9));
        let v0 = FeeParameters{
            base_factor                : arg2,
            filter_period              : arg3,
            decay_period               : arg4,
            reduction_factor           : arg5,
            variable_fee_control       : arg6,
            protocol_share             : arg7,
            max_volatility_accumulator : arg8,
        };
        if (!0x2::vec_map::contains<u16, FeeParameters>(&arg0.bin_steps, &arg1)) {
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
        check_quote_whitelist_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, v0);
        };
    }

    public fun base_factor(arg0: &GlobalConfig, arg1: u16) : u32 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).base_factor
    }

    public fun check_bin_step_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::has_role(&arg0.acl, arg1, 1), 1);
    }

    public fun check_pair_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::has_role(&arg0.acl, arg1, 0), 5);
    }

    public fun check_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::has_role(&arg0.acl, arg1, 2), 2);
    }

    public fun check_quote_whitelist_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::has_role(&arg0.acl, arg1, 4), 11);
    }

    public fun check_rewarder_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::has_role(&arg0.acl, arg1, 3), 3);
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
        check_bin_step_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let (_, _) = 0x2::vec_map::remove<u16, FeeParameters>(&mut arg0.bin_steps, &arg1);
        let v2 = DeleteBinStepEvent{bin_step: arg1};
        0x2::event::emit<DeleteBinStepEvent>(v2);
    }

    public fun delete_whitelist_token<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_quote_whitelist_role(arg0, 0x2::tx_context::sender(arg1));
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            bin_steps             : 0x2::vec_map::empty<u16, FeeParameters>(),
            flash_loan_fee_rate   : 0,
            quote_asset_whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            acl                   : 0x92a37656df10fab93df59307333a493f5f5dce884ccff72968c5e671dfdc1dc5::acl::new(arg0),
            package_version       : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = &mut v0;
        set_roles(v3, &v1, v2, 0 | 1 << 0 | 1 << 1 | 1 << 2 | 1 << 3 | 1 << 4);
        let v4 = InitConfigEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, v2);
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::event::emit<InitConfigEvent>(v4);
    }

    public fun is_in_whitelist(arg0: &GlobalConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &arg1)
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

    public fun update_flash_loan_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 100000, 4);
        checked_package_version(arg0);
        check_pair_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.flash_loan_fee_rate = arg1;
        let v0 = UpdateFlashLoanFeeRateEvent{
            old_fee_rate : arg0.flash_loan_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFlashLoanFeeRateEvent>(v0);
    }

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        arg0.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg0.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public fun variable_fee_control(arg0: &GlobalConfig, arg1: u16) : u32 {
        0x2::vec_map::get<u16, FeeParameters>(&arg0.bin_steps, &arg1).variable_fee_control
    }

    public fun whitelist_tokens(arg0: &GlobalConfig) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.quote_asset_whitelist
    }

    // decompiled from Move bytecode v6
}

