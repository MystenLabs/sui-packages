module 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::repay {
    struct RepayTokenRatioReg has drop {
        dummy_field: bool,
    }

    struct RepayAssetRatioReg has drop {
        dummy_field: bool,
    }

    struct RepayPTRatioReg has drop {
        dummy_field: bool,
    }

    struct RepayYTRatioReg has drop {
        dummy_field: bool,
    }

    struct RepayLPRatioReg has drop {
        dummy_field: bool,
    }

    struct BlockPositionReg has drop {
        dummy_field: bool,
    }

    struct RepayTokenRatioAddedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayAssetRatioAddedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayTokenRatioUpdatedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayAssetRatioUpdatedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayPTRatioAddedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayYTRatioAddedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayPTRatioUpdatedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayYTRatioUpdatedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayLPRatioAddedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct RepayLPRatioUpdatedEvent<phantom T0: drop, phantom T1: drop> has copy, drop {
        ratio: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64,
    }

    struct BlockPositionAddedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct BlockPositionRemovedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct RepayRegistry has store, key {
        id: 0x2::object::UID,
        repay_token_ratio: 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::WitTable<RepayTokenRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>,
        repay_asset_ratio: 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::WitTable<RepayAssetRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>,
        repay_pt_ratio: 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::WitTable<RepayPTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>,
        repay_yt_ratio: 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::WitTable<RepayYTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>,
        repay_lp_ratio: 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::WitTable<RepayLPRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>,
        block_position: 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::WitTable<BlockPositionReg, 0x2::object::ID, bool>,
    }

    struct AssetUnit<phantom T0: drop, phantom T1: drop> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    public fun repay<T0: drop, T1: drop, T2: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::State, arg2: &mut RepayRegistry, arg3: AssetUnit<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::is_sy_bind<T1, T0>(arg1), 1);
        let AssetUnit {
            id     : v0,
            amount : _,
        } = arg3;
        0x2::object::delete(v0);
        (0x2::coin::mint<T2>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::coin::TreasuryCap<T2>>(&mut arg2.id, b"repay_token_treasury_cap"), 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::multiply(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(arg3.amount), *0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow<RepayTokenRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg2.repay_token_ratio, 0x1::type_name::with_defining_ids<T0>()))), arg4), 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::redeem_internal<T1>(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::multiply(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(arg3.amount), *0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow<RepayAssetRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg2.repay_asset_ratio, 0x1::type_name::with_defining_ids<T0>()))), arg1, arg4))
    }

    public fun add_block_market_position(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::MarketPosition, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = BlockPositionReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::add<BlockPositionReg, 0x2::object::ID, bool>(v0, &mut arg2.block_position, 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::MarketPosition>(arg3), true);
        let v1 = BlockPositionAddedEvent{id: 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::MarketPosition>(arg3)};
        0x2::event::emit<BlockPositionAddedEvent>(v1);
    }

    public fun add_repay_asset_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::State, arg3: &mut RepayRegistry, arg4: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg5: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        assert!(0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::is_sy_bind<T1, T0>(arg2), 1);
        let v0 = RepayAssetRatioReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::add<RepayAssetRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg3.repay_asset_ratio, 0x1::type_name::with_defining_ids<T0>(), arg4);
        let v1 = RepayAssetRatioAddedEvent<T0, T1>{ratio: arg4};
        0x2::event::emit<RepayAssetRatioAddedEvent<T0, T1>>(v1);
    }

    public fun add_repay_lp_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = RepayLPRatioReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::add<RepayLPRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg2.repay_lp_ratio, 0x1::type_name::with_defining_ids<T0>(), arg3);
        let v1 = RepayLPRatioAddedEvent<T0, T1>{ratio: arg3};
        0x2::event::emit<RepayLPRatioAddedEvent<T0, T1>>(v1);
    }

    public fun add_repay_pt_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = RepayPTRatioReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::add<RepayPTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg2.repay_pt_ratio, 0x1::type_name::with_defining_ids<T0>(), arg3);
        let v1 = RepayPTRatioAddedEvent<T0, T1>{ratio: arg3};
        0x2::event::emit<RepayPTRatioAddedEvent<T0, T1>>(v1);
    }

    public fun add_repay_token_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::State, arg3: &mut RepayRegistry, arg4: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg5: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        assert!(0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::is_sy_bind<T1, T0>(arg2), 1);
        let v0 = RepayTokenRatioReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::add<RepayTokenRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg3.repay_token_ratio, 0x1::type_name::with_defining_ids<T0>(), arg4);
        let v1 = RepayTokenRatioAddedEvent<T0, T1>{ratio: arg4};
        0x2::event::emit<RepayTokenRatioAddedEvent<T0, T1>>(v1);
    }

    public fun add_repay_token_treasury_cap<T0: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        0x2::dynamic_field::add<vector<u8>, 0x2::coin::TreasuryCap<T0>>(&mut arg2.id, b"repay_token_treasury_cap", arg3);
    }

    public fun add_repay_yt_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = RepayYTRatioReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::add<RepayYTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg2.repay_yt_ratio, 0x1::type_name::with_defining_ids<T0>(), arg3);
        let v1 = RepayYTRatioAddedEvent<T0, T1>{ratio: arg3};
        0x2::event::emit<RepayYTRatioAddedEvent<T0, T1>>(v1);
    }

    public fun block_py_position(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::PyPosition, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = BlockPositionReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::add<BlockPositionReg, 0x2::object::ID, bool>(v0, &mut arg2.block_position, 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::PyPosition>(arg3), true);
        let v1 = BlockPositionAddedEvent{id: 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::PyPosition>(arg3)};
        0x2::event::emit<BlockPositionAddedEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RepayTokenRatioReg{dummy_field: false};
        let v1 = RepayAssetRatioReg{dummy_field: false};
        let v2 = RepayPTRatioReg{dummy_field: false};
        let v3 = RepayYTRatioReg{dummy_field: false};
        let v4 = RepayLPRatioReg{dummy_field: false};
        let v5 = BlockPositionReg{dummy_field: false};
        let v6 = RepayRegistry{
            id                : 0x2::object::new(arg0),
            repay_token_ratio : 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::new<RepayTokenRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, true, arg0),
            repay_asset_ratio : 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::new<RepayAssetRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v1, true, arg0),
            repay_pt_ratio    : 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::new<RepayPTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v2, true, arg0),
            repay_yt_ratio    : 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::new<RepayYTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v3, true, arg0),
            repay_lp_ratio    : 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::new<RepayLPRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v4, true, arg0),
            block_position    : 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::new<BlockPositionReg, 0x2::object::ID, bool>(v5, true, arg0),
        };
        0x2::transfer::share_object<RepayRegistry>(v6);
    }

    public fun market_to_repay_unit<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::MarketPosition, arg2: &mut 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market::MarketState<T0>, arg3: &mut RepayRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AssetUnit<T0, T1> {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::market_state_id(arg1) == 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market::MarketState<T0>>(arg2), 1);
        assert!(!0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::contains<BlockPositionReg, 0x2::object::ID, bool>(&arg3.block_position, 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::MarketPosition>(arg1)), 2);
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::set_lp_amount(arg1, 0, arg4);
        AssetUnit<T0, T1>{
            id     : 0x2::object::new(arg5),
            amount : 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::multiply(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::lp_amount(arg1)), *0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow<RepayLPRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg3.repay_lp_ratio, 0x1::type_name::with_defining_ids<T0>()))),
        }
    }

    public fun py_to_repay_unit<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py::PyState<T0>, arg2: &mut 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::PyPosition, arg3: &mut RepayRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AssetUnit<T0, T1> {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg4) < 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py::expiry<T0>(arg1), 0);
        assert!(0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::py_state_id(arg2) == 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py::PyState<T0>>(arg1), 1);
        assert!(!0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::contains<BlockPositionReg, 0x2::object::ID, bool>(&arg3.block_position, 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::PyPosition>(arg2)), 2);
        let (v0, v1) = 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::py_amount(arg2);
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::set_pt_balance(arg2, 0, arg4);
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::set_yt_balance(arg2, 0, arg4);
        AssetUnit<T0, T1>{
            id     : 0x2::object::new(arg5),
            amount : 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::multiply(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(v0), *0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow<RepayPTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg3.repay_pt_ratio, 0x1::type_name::with_defining_ids<T0>()))) + 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::truncate(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::multiply(0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::from_uint64(v1), *0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow<RepayYTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(&arg3.repay_yt_ratio, 0x1::type_name::with_defining_ids<T0>()))),
        }
    }

    public fun remove_block_market_position(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::MarketPosition, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = BlockPositionReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::remove<BlockPositionReg, 0x2::object::ID, bool>(v0, &mut arg2.block_position, 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::MarketPosition>(arg3));
        let v1 = BlockPositionRemovedEvent{id: 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::market_position::MarketPosition>(arg3)};
        0x2::event::emit<BlockPositionRemovedEvent>(v1);
    }

    public fun remove_block_py_position(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::PyPosition, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = BlockPositionReg{dummy_field: false};
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::remove<BlockPositionReg, 0x2::object::ID, bool>(v0, &mut arg2.block_position, 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::PyPosition>(arg3));
        let v1 = BlockPositionRemovedEvent{id: 0x2::object::id<0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::py_position::PyPosition>(arg3)};
        0x2::event::emit<BlockPositionRemovedEvent>(v1);
    }

    public fun update_repay_asset_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::State, arg3: &mut RepayRegistry, arg4: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg5: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        assert!(0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::is_sy_bind<T1, T0>(arg2), 1);
        let v0 = RepayAssetRatioReg{dummy_field: false};
        let v1 = 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow_mut<RepayAssetRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg3.repay_asset_ratio, 0x1::type_name::with_defining_ids<T0>());
        *v1 = arg4;
        let v2 = RepayAssetRatioUpdatedEvent<T0, T1>{ratio: *v1};
        0x2::event::emit<RepayAssetRatioUpdatedEvent<T0, T1>>(v2);
    }

    public fun update_repay_lp_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = RepayLPRatioReg{dummy_field: false};
        let v1 = 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow_mut<RepayLPRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg2.repay_lp_ratio, 0x1::type_name::with_defining_ids<T0>());
        *v1 = arg3;
        let v2 = RepayLPRatioUpdatedEvent<T0, T1>{ratio: *v1};
        0x2::event::emit<RepayLPRatioUpdatedEvent<T0, T1>>(v2);
    }

    public fun update_repay_pt_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = RepayPTRatioReg{dummy_field: false};
        let v1 = 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow_mut<RepayPTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg2.repay_pt_ratio, 0x1::type_name::with_defining_ids<T0>());
        *v1 = arg3;
        let v2 = RepayPTRatioUpdatedEvent<T0, T1>{ratio: *v1};
        0x2::event::emit<RepayPTRatioUpdatedEvent<T0, T1>>(v2);
    }

    public fun update_repay_token_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut 0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::State, arg3: &mut RepayRegistry, arg4: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg5: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        assert!(0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::sy::is_sy_bind<T1, T0>(arg2), 1);
        let v0 = RepayTokenRatioReg{dummy_field: false};
        let v1 = 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow_mut<RepayTokenRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg3.repay_token_ratio, 0x1::type_name::with_defining_ids<T0>());
        *v1 = arg4;
        let v2 = RepayTokenRatioUpdatedEvent<T0, T1>{ratio: *v1};
        0x2::event::emit<RepayTokenRatioUpdatedEvent<T0, T1>>(v2);
    }

    public fun update_repay_yt_ratio<T0: drop, T1: drop>(arg0: &0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::Version, arg1: &mut 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut RepayRegistry, arg3: 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64, arg4: &mut 0x2::tx_context::TxContext) {
        0x13b68ff402072eeb4b8b39b8b57d65fabd06258c53830952ad3289a9fffdad24::nemo_version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0);
        let v0 = RepayYTRatioReg{dummy_field: false};
        let v1 = 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::wit_table::borrow_mut<RepayYTRatioReg, 0x1::type_name::TypeName, 0xec4f1ffc3ae33792da03fc072ea80fedb44eb20d40ab08611c427e29247fbf2b::fixed_point64::FixedPoint64>(v0, &mut arg2.repay_yt_ratio, 0x1::type_name::with_defining_ids<T0>());
        *v1 = arg3;
        let v2 = RepayYTRatioUpdatedEvent<T0, T1>{ratio: *v1};
        0x2::event::emit<RepayYTRatioUpdatedEvent<T0, T1>>(v2);
    }

    // decompiled from Move bytecode v6
}

