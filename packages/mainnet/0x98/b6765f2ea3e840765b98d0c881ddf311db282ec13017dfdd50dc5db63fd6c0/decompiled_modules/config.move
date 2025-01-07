module 0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::ACL,
        package_version: u64,
        min_cycle_amount_in_usd: u64,
        oracle_valid_duration: u64,
        min_cycle_frequency: u64,
        min_cycle_count: u64,
        keeper_threshold: u64,
        whitelist_mode: u8,
        in_coin_whitelist: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        out_coin_whitelist: 0x2::table::Table<0x1::type_name::TypeName, bool>,
    }

    struct ProtocolFeeVault has store, key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
    }

    struct InitEvent has copy, drop {
        global_config_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        protocol_fee_vault_id: 0x2::object::ID,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct SetPackageVersionEvent has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct SetMinCycelAmountInUsdEvent has copy, drop {
        new_min_cycle_amount_in_usd: u64,
        old_min_cycle_amount_in_usd: u64,
    }

    struct SetMinCycelFrequencyEvent has copy, drop {
        new_min_cycle_frequency: u64,
        old_min_cycle_frequency: u64,
    }

    struct SetOracleValidDuration has copy, drop {
        new_oracle_valid_duration: u64,
        old_oracle_valid_duration: u64,
    }

    struct SetKeeperThreshold has copy, drop {
        new_keeper_threshold: u64,
        old_keeper_threshold: u64,
    }

    struct SetWhitelistModeEvent has copy, drop {
        new_whitelist_mode: u8,
        old_whitelist_mode: u8,
    }

    struct AddInCoinTypeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct RemoveInCoinTypeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct AddOutCoinTypeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct RemoveOutCoinTypeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct ClaimProtocolFee has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::Member> {
        0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        checked_package_version(arg0);
        0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::remove_member(&mut arg0.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun set_roles(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u128) {
        checked_package_version(arg0);
        0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::set_roles(&mut arg0.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun add_in_coin_type<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 1), 2);
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.in_coin_whitelist, v0, true);
        let v1 = AddInCoinTypeEvent{coin_type: v0};
        0x2::event::emit<AddInCoinTypeEvent>(v1);
    }

    public fun add_out_coin_type<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 1), 2);
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.out_coin_whitelist, v0, true);
        let v1 = AddOutCoinTypeEvent{coin_type: v0};
        0x2::event::emit<AddOutCoinTypeEvent>(v1);
    }

    public fun checked_keeper(arg0: &GlobalConfig, arg1: address) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, arg1, 0), 1);
    }

    public fun checked_oracle(arg0: &GlobalConfig, arg1: address) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, arg1, 2), 3);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(1 >= arg0.package_version, 0);
    }

    public fun claim_fee<T0>(arg0: &GlobalConfig, arg1: &mut ProtocolFeeVault, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg2), 1), 2);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vault, v0)) {
            return
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vault, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v2), arg2), 0x2::tx_context::sender(arg2));
        let v3 = ClaimProtocolFee{
            coin_type : v0,
            amount    : v2,
        };
        0x2::event::emit<ClaimProtocolFee>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                      : 0x2::object::new(arg0),
            acl                     : 0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::new(arg0),
            package_version         : 1,
            min_cycle_amount_in_usd : 10000000,
            oracle_valid_duration   : 300,
            min_cycle_frequency     : 60,
            min_cycle_count         : 2,
            keeper_threshold        : 2,
            whitelist_mode          : 0,
            in_coin_whitelist       : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            out_coin_whitelist      : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = ProtocolFeeVault{
            id    : 0x2::object::new(arg0),
            vault : 0x2::bag::new(arg0),
        };
        let v3 = 0x2::tx_context::sender(arg0);
        0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::set_roles(&mut v0.acl, v3, 0 | 1 << 1);
        0x2::transfer::transfer<AdminCap>(v1, v3);
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::transfer::share_object<ProtocolFeeVault>(v2);
        let v4 = InitEvent{
            global_config_id      : 0x2::object::id<GlobalConfig>(&v0),
            admin_cap_id          : 0x2::object::id<AdminCap>(&v1),
            protocol_fee_vault_id : 0x2::object::id<ProtocolFeeVault>(&v2),
        };
        0x2::event::emit<InitEvent>(v4);
    }

    public fun is_coin_allow<T0, T1>(arg0: &GlobalConfig) : bool {
        if (arg0.whitelist_mode == 0) {
            return true
        };
        let v0 = arg0.whitelist_mode & 1 == 0 || 0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.in_coin_whitelist, 0x1::type_name::get<T0>());
        let v1 = arg0.whitelist_mode & 2 == 0 || 0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.out_coin_whitelist, 0x1::type_name::get<T1>());
        v0 && v1
    }

    public fun keeper_threshold(arg0: &GlobalConfig) : u64 {
        arg0.keeper_threshold
    }

    public fun min_cycle_amount_in_usd(arg0: &GlobalConfig) : u64 {
        arg0.min_cycle_amount_in_usd
    }

    public fun min_cycle_count(arg0: &GlobalConfig) : u64 {
        arg0.min_cycle_count
    }

    public fun min_cycle_frequency(arg0: &GlobalConfig) : u64 {
        arg0.min_cycle_frequency
    }

    public fun oracle_valid_duration(arg0: &GlobalConfig) : u64 {
        arg0.oracle_valid_duration
    }

    public fun package_version() : u64 {
        1
    }

    public fun receive_fee<T0>(arg0: &mut ProtocolFeeVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, arg1);
        };
    }

    public fun remove_in_coin_type<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 1), 2);
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.in_coin_whitelist, v0);
        let v1 = RemoveInCoinTypeEvent{coin_type: v0};
        0x2::event::emit<RemoveInCoinTypeEvent>(v1);
    }

    public fun remove_out_coin_type<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 1), 2);
        let v0 = 0x1::type_name::get<T0>();
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.out_coin_whitelist, v0);
        let v1 = RemoveOutCoinTypeEvent{coin_type: v0};
        0x2::event::emit<RemoveOutCoinTypeEvent>(v1);
    }

    public fun set_keeper_threshold(arg0: &mut GlobalConfig, arg1: u64, arg2: 0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(&arg2), 1), 2);
        arg0.keeper_threshold = arg1;
        let v0 = SetKeeperThreshold{
            new_keeper_threshold : arg1,
            old_keeper_threshold : arg0.keeper_threshold,
        };
        0x2::event::emit<SetKeeperThreshold>(v0);
    }

    public fun set_min_cycle_amount_in_usd(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg2), 1), 2);
        arg0.min_cycle_amount_in_usd = arg1;
        let v0 = SetMinCycelAmountInUsdEvent{
            new_min_cycle_amount_in_usd : arg1,
            old_min_cycle_amount_in_usd : arg0.min_cycle_amount_in_usd,
        };
        0x2::event::emit<SetMinCycelAmountInUsdEvent>(v0);
    }

    public fun set_min_cycle_frequency(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg2), 1), 2);
        arg0.min_cycle_amount_in_usd = arg1;
        let v0 = SetMinCycelFrequencyEvent{
            new_min_cycle_frequency : arg1,
            old_min_cycle_frequency : arg0.min_cycle_frequency,
        };
        0x2::event::emit<SetMinCycelFrequencyEvent>(v0);
    }

    public fun set_oracle_valid_duration(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg2), 1), 2);
        arg0.oracle_valid_duration = arg1;
        let v0 = SetOracleValidDuration{
            new_oracle_valid_duration : arg1,
            old_oracle_valid_duration : arg0.oracle_valid_duration,
        };
        0x2::event::emit<SetOracleValidDuration>(v0);
    }

    public fun set_whitelist_mode(arg0: &mut GlobalConfig, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(0x98b6765f2ea3e840765b98d0c881ddf311db282ec13017dfdd50dc5db63fd6c0::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg2), 1), 2);
        arg0.whitelist_mode = arg1;
        let v0 = SetWhitelistModeEvent{
            new_whitelist_mode : arg1,
            old_whitelist_mode : arg0.whitelist_mode,
        };
        0x2::event::emit<SetWhitelistModeEvent>(v0);
    }

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        arg0.package_version = arg2;
        let v0 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : arg0.package_version,
        };
        0x2::event::emit<SetPackageVersionEvent>(v0);
    }

    public fun whitelist_mode(arg0: &GlobalConfig) : u8 {
        arg0.whitelist_mode
    }

    // decompiled from Move bytecode v6
}

