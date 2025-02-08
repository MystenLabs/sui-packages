module 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config {
    struct PumpAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Configs has store, key {
        id: 0x2::object::UID,
        acl: 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::acl::ACL,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        swap_fee_rate: u64,
        is_protocol_owned_lp: bool,
        url_update_flags: u8,
        init_fees: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        update_fees: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        fee_vault: 0x2::bag::Bag,
        bonding_curve_config: BondingCurveConfig,
    }

    struct BondingCurveConfig has store {
        start_sqrt_price: u128,
        end_sqrt_price: u128,
        sui_amount: u64,
        amount: u64,
    }

    struct InitEvent has copy, drop {
        global_config_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct SetInitFeeEvent has copy, drop {
        fee_type: 0x1::type_name::TypeName,
        old_fee: 0x1::option::Option<u64>,
        new_fee: u64,
    }

    struct SetUpdateFeeEvent has copy, drop {
        fee_type: 0x1::type_name::TypeName,
        old_fee: 0x1::option::Option<u64>,
        new_fee: u64,
    }

    struct RemoveInitFeeEvent has copy, drop {
        fee_type: 0x1::type_name::TypeName,
        fee: u64,
    }

    struct RemoveUpdateFeeEvent has copy, drop {
        fee_type: 0x1::type_name::TypeName,
        fee: u64,
    }

    struct UpdateSwapFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct ClaimFeeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct UpdateBondingCurveConfigEvent has copy, drop {
        old_start_sqrt_price: u128,
        old_end_sqrt_price: u128,
        old_sui_amount: u64,
        old_amount: u64,
        start_sqrt_price: u128,
        end_sqrt_price: u128,
        amount: u64,
        sui_amount: u64,
    }

    struct UpdateLpOwnershipEvent has copy, drop {
        old_val: bool,
        new_val: bool,
    }

    struct UpdateUrlFlagEvent has copy, drop {
        old_val: u8,
        new_val: u8,
    }

    public fun set_roles(arg0: &mut Configs, arg1: &PumpAdminCap, arg2: address, arg3: u128) {
        assert_valid_package(arg0);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::acl::set_roles(&mut arg0.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun assert_claim_role(arg0: &Configs, arg1: address) {
        assert!(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::acl::has_role(&arg0.acl, arg1, 2), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::no_claim_permission());
    }

    public fun assert_manager_role(arg0: &Configs, arg1: address) {
        assert!(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::acl::has_role(&arg0.acl, arg1, 0), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::no_manager_permission());
    }

    public fun assert_upload_role(arg0: &Configs, arg1: address) {
        assert!(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::acl::has_role(&arg0.acl, arg1, 1), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::no_upload_permission());
    }

    public fun assert_url_update_flag(arg0: &Configs, arg1: u8) {
        assert!(arg0.url_update_flags & 1 << arg1 != 0, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::not_allow_update_in_this_status());
    }

    public fun assert_valid_package(arg0: &Configs) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &v0), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::package_version_not_allowed());
    }

    public fun bonding_curve_config(arg0: &Configs) : (u128, u128, u64, u64) {
        (arg0.bonding_curve_config.start_sqrt_price, arg0.bonding_curve_config.end_sqrt_price, arg0.bonding_curve_config.sui_amount, arg0.bonding_curve_config.amount)
    }

    public fun change_url_flags(arg0: &mut Configs, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_package(arg0);
        assert_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = UpdateUrlFlagEvent{
            old_val : arg0.url_update_flags,
            new_val : arg1,
        };
        0x2::event::emit<UpdateUrlFlagEvent>(v0);
        arg0.url_update_flags = arg1;
    }

    public(friend) fun claim_fee<T0>(arg0: &mut Configs, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_claim_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_vault, v0), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::insufficient_balance());
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_vault, v0);
        let v2 = ClaimFeeEvent{
            coin_type : v0,
            amount    : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<ClaimFeeEvent>(v2);
        v1
    }

    public entry fun disable_version(arg0: &mut Configs, arg1: u64, arg2: &PumpAdminCap) {
        assert!(arg1 != 1, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::cannot_disable_current_version());
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::version_not_enabled());
        0x2::vec_set::remove<u64>(&mut arg0.allowed_versions, &arg1);
    }

    public entry fun enable_version(arg0: &mut Configs, arg1: u64, arg2: &PumpAdminCap) {
        assert!(!0x2::vec_set::contains<u64>(&arg0.allowed_versions, &arg1), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::version_already_enabled());
        0x2::vec_set::insert<u64>(&mut arg0.allowed_versions, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<0x1::type_name::TypeName, u64>(arg0);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<0x2::sui::SUI>(), 500000000);
        let v1 = 0x2::table::new<0x1::type_name::TypeName, u64>(arg0);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut v1, 0x1::type_name::get<0x2::sui::SUI>(), 500000000);
        let v2 = BondingCurveConfig{
            start_sqrt_price : 10312042891210684,
            end_sqrt_price   : 41248175859869273,
            sui_amount       : 10000000000000,
            amount           : 10000000000000000000,
        };
        let v3 = Configs{
            id                   : 0x2::object::new(arg0),
            acl                  : 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::acl::new(arg0),
            allowed_versions     : 0x2::vec_set::singleton<u64>(1),
            swap_fee_rate        : 0,
            is_protocol_owned_lp : true,
            url_update_flags     : 0,
            init_fees            : v0,
            update_fees          : v1,
            fee_vault            : 0x2::bag::new(arg0),
            bonding_curve_config : v2,
        };
        let v4 = PumpAdminCap{id: 0x2::object::new(arg0)};
        let v5 = 0x2::tx_context::sender(arg0);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::acl::set_roles(&mut v3.acl, v5, 0 | 1 << 0);
        0x2::transfer::transfer<PumpAdminCap>(v4, v5);
        0x2::transfer::share_object<Configs>(v3);
        let v6 = InitEvent{
            global_config_id : 0x2::object::id<Configs>(&v3),
            admin_cap_id     : 0x2::object::id<PumpAdminCap>(&v4),
        };
        0x2::event::emit<InitEvent>(v6);
    }

    public fun init_fee<T0>(arg0: &Configs) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.init_fees, v0), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::init_fee_type_not_exist());
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.init_fees, v0)
    }

    public fun is_protocol_owned_lp(arg0: &Configs) : bool {
        arg0.is_protocol_owned_lp
    }

    public fun receive_fee<T0>(arg0: &mut Configs, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_vault, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_vault, v0, arg1);
        };
    }

    public fun remove_init_fee<T0>(arg0: &mut Configs, arg1: &0x2::tx_context::TxContext) {
        assert_valid_package(arg0);
        assert_manager_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.init_fees, v0), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::init_fee_type_not_exist());
        let v1 = RemoveInitFeeEvent{
            fee_type : v0,
            fee      : 0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.init_fees, v0),
        };
        0x2::event::emit<RemoveInitFeeEvent>(v1);
    }

    public fun remove_update_fee<T0>(arg0: &mut Configs, arg1: &0x2::tx_context::TxContext) {
        assert_valid_package(arg0);
        assert_manager_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.update_fees, v0), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::update_fee_type_not_exist());
        let v1 = RemoveUpdateFeeEvent{
            fee_type : v0,
            fee      : 0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.update_fees, v0),
        };
        0x2::event::emit<RemoveUpdateFeeEvent>(v1);
    }

    public fun set_init_fee<T0>(arg0: &mut Configs, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_valid_package(arg0);
        assert_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.init_fees, v0)) {
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.init_fees, v0);
            *v2 = arg1;
            0x1::option::some<u64>(*v2)
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.init_fees, v0, arg1);
            0x1::option::none<u64>()
        };
        let v3 = SetInitFeeEvent{
            fee_type : v0,
            old_fee  : v1,
            new_fee  : arg1,
        };
        0x2::event::emit<SetInitFeeEvent>(v3);
    }

    public fun set_update_fee<T0>(arg0: &mut Configs, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_valid_package(arg0);
        assert_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.update_fees, v0)) {
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.update_fees, v0);
            *v2 = arg1;
            0x1::option::some<u64>(*v2)
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.update_fees, v0, arg1);
            0x1::option::none<u64>()
        };
        let v3 = SetUpdateFeeEvent{
            fee_type : v0,
            old_fee  : v1,
            new_fee  : arg1,
        };
        0x2::event::emit<SetUpdateFeeEvent>(v3);
    }

    public fun swap_fee_rate(arg0: &Configs) : u64 {
        arg0.swap_fee_rate
    }

    public fun update_bonding_curve_config(arg0: &mut Configs, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_valid_package(arg0);
        assert_manager_role(arg0, 0x2::tx_context::sender(arg5));
        let v0 = &mut arg0.bonding_curve_config;
        let v1 = UpdateBondingCurveConfigEvent{
            old_start_sqrt_price : v0.start_sqrt_price,
            old_end_sqrt_price   : v0.end_sqrt_price,
            old_sui_amount       : v0.sui_amount,
            old_amount           : v0.amount,
            start_sqrt_price     : arg1,
            end_sqrt_price       : arg2,
            amount               : arg3,
            sui_amount           : arg4,
        };
        0x2::event::emit<UpdateBondingCurveConfigEvent>(v1);
        v0.start_sqrt_price = arg1;
        v0.end_sqrt_price = arg2;
        v0.sui_amount = arg4;
        v0.amount = arg3;
    }

    public fun update_fee<T0>(arg0: &Configs) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.update_fees, v0), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::update_fee_type_not_exist());
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.update_fees, v0)
    }

    public fun update_lp_owner(arg0: &mut Configs, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_valid_package(arg0);
        assert_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = UpdateLpOwnershipEvent{
            old_val : arg0.is_protocol_owned_lp,
            new_val : arg1,
        };
        0x2::event::emit<UpdateLpOwnershipEvent>(v0);
        arg0.is_protocol_owned_lp = arg1;
    }

    public fun update_swap_fee_rate(arg0: &mut Configs, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_valid_package(arg0);
        assert_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.swap_fee_rate = arg1;
        let v0 = UpdateSwapFeeRateEvent{
            old_fee_rate : arg0.swap_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateSwapFeeRateEvent>(v0);
    }

    public fun url_update_flags(arg0: &Configs) : u8 {
        arg0.url_update_flags
    }

    // decompiled from Move bytecode v6
}

