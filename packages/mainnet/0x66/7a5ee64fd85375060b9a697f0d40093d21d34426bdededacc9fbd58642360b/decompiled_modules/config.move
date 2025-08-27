module 0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::config {
    struct FeeTier has copy, drop, store {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_rate: u64,
        fee_tiers: 0x2::vec_map::VecMap<u32, FeeTier>,
        allow_create_pair: bool,
        acl: 0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::ACL,
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
    }

    struct UpdateFeeTierEvent has copy, drop {
        tick_spacing: u32,
        old_fee_rate: u64,
        new_fee_rate: u64,
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

    public fun acl(arg0: &GlobalConfig) : &0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::ACL {
        &arg0.acl
    }

    public fun cancel(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::cancel(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun execute(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::execute(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun get_fund_receiver(arg0: &GlobalConfig) : address {
        0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::get_fund_receiver(&arg0.acl)
    }

    public fun get_reward_receiver(arg0: &GlobalConfig) : address {
        0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::get_reward_receiver(&arg0.acl)
    }

    public fun propose(arg0: &mut GlobalConfig, arg1: u8, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        checked_package_version(arg0);
        0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::propose(&mut arg0.acl, arg1, arg2, arg3, arg4, arg5)
    }

    public fun set_publisher(arg0: &mut GlobalConfig, arg1: 0x2::package::Publisher, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::set_publisher(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun set_upgrade_cap(arg0: &mut GlobalConfig, arg1: 0x2::package::UpgradeCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::set_upgrade_cap(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun vote(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::vote(&mut arg0.acl, arg1, arg2, arg3);
    }

    public fun add_update_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 200000, 202);
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg3));
        if (!0x2::vec_map::contains<u32, FeeTier>(&arg0.fee_tiers, &arg1)) {
            let v0 = FeeTier{
                tick_spacing : arg1,
                fee_rate     : arg2,
            };
            0x2::vec_map::insert<u32, FeeTier>(&mut arg0.fee_tiers, arg1, v0);
            let v1 = AddFeeTierEvent{
                tick_spacing : arg1,
                fee_rate     : arg2,
            };
            0x2::event::emit<AddFeeTierEvent>(v1);
        } else {
            let v2 = 0x2::vec_map::get_mut<u32, FeeTier>(&mut arg0.fee_tiers, &arg1);
            v2.fee_rate = arg2;
            let v3 = UpdateFeeTierEvent{
                tick_spacing : arg1,
                old_fee_rate : v2.fee_rate,
                new_fee_rate : arg2,
            };
            0x2::event::emit<UpdateFeeTierEvent>(v3);
        };
    }

    public fun add_whitelist_token<T0>(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, v0);
        };
        let v1 = AddWhitelistTokenEvent{token: v0};
        0x2::event::emit<AddWhitelistTokenEvent>(v1);
    }

    public fun check_operator_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::has_role(&arg0.acl, arg1, 0), 205);
    }

    public fun check_protocol_fee_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::has_role(&arg0.acl, arg1, 2), 207);
    }

    public fun check_reward_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::has_role(&arg0.acl, arg1, 1), 206);
    }

    public fun check_upgrade_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::has_role(&arg0.acl, arg1, 3), 208);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version <= 1, 204);
    }

    public fun delete_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<u32, FeeTier>(&arg0.fee_tiers, &arg1), 201);
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg2));
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
        check_operator_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, &v0);
        };
        let v1 = RemoveWhitelistTokenEvent{token: v0};
        0x2::event::emit<RemoveWhitelistTokenEvent>(v1);
    }

    public fun fee_rate(arg0: &FeeTier) : u64 {
        arg0.fee_rate
    }

    public fun fee_tiers(arg0: &GlobalConfig) : &0x2::vec_map::VecMap<u32, FeeTier> {
        &arg0.fee_tiers
    }

    public fun get_allow_create_pair(arg0: &GlobalConfig) : bool {
        arg0.allow_create_pair
    }

    public fun get_fee_rate(arg0: u32, arg1: &GlobalConfig) : u64 {
        assert!(0x2::vec_map::contains<u32, FeeTier>(&arg1.fee_tiers, &arg0), 201);
        0x2::vec_map::get<u32, FeeTier>(&arg1.fee_tiers, &arg0).fee_rate
    }

    public fun get_protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            protocol_fee_rate     : 2000,
            fee_tiers             : 0x2::vec_map::empty<u32, FeeTier>(),
            allow_create_pair     : false,
            acl                   : 0x667a5ee64fd85375060b9a697f0d40093d21d34426bdededacc9fbd58642360b::acl::new(arg0),
            package_version       : 1,
            quote_asset_whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = InitConfigEvent{global_config_id: 0x2::object::id<GlobalConfig>(&v0)};
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::event::emit<InitConfigEvent>(v1);
    }

    public fun is_in_whitelist<T0>(arg0: &GlobalConfig) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0)
    }

    public fun max_fee_rate() : u64 {
        200000
    }

    public fun max_protocol_fee_rate() : u64 {
        3000
    }

    public fun package_version() : u64 {
        1
    }

    public fun protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun set_allow_create_pair(arg0: &mut GlobalConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.allow_create_pair = arg1;
    }

    public fun tick_spacing(arg0: &FeeTier) : u32 {
        arg0.tick_spacing
    }

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_upgrade_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.package_version = arg1;
        let v0 = SetPackageVersion{
            new_version : arg1,
            old_version : arg0.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    public fun update_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 3000, 203);
        checked_package_version(arg0);
        check_operator_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.protocol_fee_rate = arg1;
        let v0 = UpdateFeeRateEvent{
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    public fun whitelist_tokens(arg0: &GlobalConfig) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.quote_asset_whitelist
    }

    // decompiled from Move bytecode v6
}

