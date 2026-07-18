module 0x971d70b4e40312c953adf5f773f326844a03708b0f0dfdb38cc006fc180a48dd::rotation_adapters {
    struct Registry has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct BluefinDeepSuiToCetusUsdcSuiCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct CetusUsdcSuiToBluefinDeepSuiCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct BluefinDeepRewardAdapter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct CetusDeepRewardAdapter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct CetusSuiRewardAdapter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct CetusRewardToSuiAdapter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct BluefinDeepUsdcPortfolioCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        primary_pool_id: 0x2::object::ID,
        farm_pool_id: 0x2::object::ID,
        sui_usdc_pool_id: 0x2::object::ID,
    }

    struct GenericCetusXYCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        x_sui_pool_id: 0x2::object::ID,
        y_sui_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
    }

    struct GenericBluefinCetusXYCap<phantom T0, phantom T1, phantom T2, phantom T3> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        x_sui_pool_id: 0x2::object::ID,
        y_sui_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
    }

    struct GenericCetusXSuiCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
        expected_reward_types: vector<0x1::type_name::TypeName>,
    }

    struct GenericCetusXSuiBluefinFallbackCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        bluefin_x_sui_pool_id: 0x2::object::ID,
    }

    struct GenericBluefinCetusXSuiCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
        expected_reward_types: vector<0x1::type_name::TypeName>,
    }

    struct GenericCetusXYRewardRouteCap<phantom T0, phantom T1, phantom T2, phantom T3> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        reward_sui_pool_id: 0x2::object::ID,
    }

    struct GenericCetusXYSuiRewardCap<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
    }

    struct CetusXYRewardIncome<phantom T0> {
        source_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_count: u8,
        expected_reward_count: u8,
        reward_types: vector<0x1::type_name::TypeName>,
        reward_amounts: vector<u64>,
        reward_sui: 0x2::balance::Balance<T0>,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct AdapterRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        adapter_kind: u8,
    }

    struct BluefinToCetusRotated has copy, drop {
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        principal_deep_to_sui: u64,
        principal_deep_as_sui: u64,
        principal_sui_to_usdc: u64,
        principal_usdc_out: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_usdc: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_usdc: u64,
        residual_sui: u64,
    }

    struct BluefinCetusPortfolioOpened has copy, drop {
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        cetus_principal_deep: u64,
        cetus_principal_sui: u64,
        cetus_sui_to_usdc: u64,
        cetus_usdc_out: u64,
        bluefin_tick_lower: u32,
        bluefin_tick_upper: u32,
        cetus_tick_lower: u32,
        cetus_tick_upper: u32,
        bluefin_deposited_deep: u64,
        bluefin_deposited_sui: u64,
        cetus_deposited_usdc: u64,
        cetus_deposited_sui: u64,
        residual_deep: u64,
        residual_usdc: u64,
        residual_sui: u64,
    }

    struct BluefinCetusPortfolioOpenedV2 has copy, drop {
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        cetus_principal_deep: u64,
        cetus_principal_sui: u64,
        cetus_deep_as_sui: u64,
        cetus_sui_to_usdc: u64,
        cetus_usdc_out: u64,
        bluefin_tick_lower: u32,
        bluefin_tick_upper: u32,
        cetus_tick_lower: u32,
        cetus_tick_upper: u32,
        bluefin_deposited_deep: u64,
        bluefin_deposited_sui: u64,
        cetus_deposited_usdc: u64,
        cetus_deposited_sui: u64,
        bluefin_liquidity: u128,
        cetus_liquidity: u128,
        residual_deep: u64,
        residual_usdc: u64,
        residual_sui: u64,
    }

    struct DualBluefinPortfolioOpened has copy, drop {
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        secondary_principal_deep: u64,
        secondary_principal_sui: u64,
        secondary_sui_as_deep: u64,
        secondary_deep_to_blue: u64,
        secondary_blue_out: u64,
        primary_swap_deep_to_sui: bool,
        primary_swap_input: u64,
        primary_swap_output: u64,
        primary_tick_lower: u32,
        primary_tick_upper: u32,
        secondary_tick_lower: u32,
        secondary_tick_upper: u32,
        primary_deposited_deep: u64,
        primary_deposited_sui: u64,
        secondary_deposited_deep: u64,
        secondary_deposited_blue: u64,
        primary_liquidity: u128,
        secondary_liquidity: u128,
        residual_deep: u64,
        residual_sui: u64,
        residual_blue: u64,
    }

    struct GenericCetusIncomePaid has copy, drop {
        reward_x: u64,
        reward_sui: u64,
        reward_external: u64,
        external_as_sui: u64,
        profit_sui: u64,
    }

    struct GenericCetusExited has copy, drop {
        reward_x: u64,
        reward_sui: u64,
        reward_external: u64,
        fee_x: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_x: u64,
        source_principal_sui: u64,
        principal_x_as_sui: u64,
        principal_deep_out: u64,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_x: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct GenericCetusXYRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        cetus_route_id: 0x2::object::ID,
        cross_venue_route_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        x_sui_pool_id: 0x2::object::ID,
        y_sui_pool_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
    }

    struct GenericCetusXYRewardRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        reward_route_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        reward_sui_pool_id: 0x2::object::ID,
        direct_sui: bool,
    }

    struct GenericCetusXSuiRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        cetus_route_id: 0x2::object::ID,
        cross_venue_route_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
    }

    struct GenericBluefinCetusXSuiOpened has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        bluefin_destination_pool_id: 0x2::object::ID,
        cetus_destination_pool_id: 0x2::object::ID,
        bluefin_position_id: 0x2::object::ID,
        cetus_position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        net_principal_sui: u64,
        bluefin_sui_to_deep: u64,
        cetus_sui_to_x: u64,
        cetus_sui_reserve: u64,
        bluefin_deposited_deep: u64,
        bluefin_deposited_sui: u64,
        cetus_deposited_x: u64,
        cetus_deposited_sui: u64,
        bluefin_tick_lower: u32,
        bluefin_tick_upper: u32,
        cetus_tick_lower: u32,
        cetus_tick_upper: u32,
        residual_deep: u64,
        residual_sui: u64,
        residual_x: u64,
        residual_cetus_sui: u64,
    }

    struct GenericCetusXSuiHarvested has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_amounts: vector<u64>,
        reward_sui: u64,
        fee_x: u64,
        fee_sui: u64,
        profit_sui: u64,
    }

    struct GenericCetusXSuiRecentered has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        reward_amounts: vector<u64>,
        reward_sui: u64,
        fee_x: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_x: u64,
        source_principal_sui: u64,
        principal_swap_x_to_sui: bool,
        principal_swap_input: u64,
        principal_swap_output: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_x: u64,
        deposited_sui: u64,
        residual_x: u64,
        residual_sui: u64,
    }

    struct GenericCetusXSuiToBluefinExited has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        destination_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        reward_amounts: vector<u64>,
        reward_sui: u64,
        fee_x: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_x: u64,
        source_principal_sui: u64,
        net_principal_sui: u64,
        principal_sui_to_deep: u64,
        deposited_deep: u64,
        deposited_sui: u64,
        tick_lower: u32,
        tick_upper: u32,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct GenericBluefinCetusXYOpened has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        bluefin_destination_pool_id: 0x2::object::ID,
        cetus_destination_pool_id: 0x2::object::ID,
        bluefin_position_id: 0x2::object::ID,
        cetus_position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        net_principal_sui: u64,
        bluefin_sui_to_deep: u64,
        cetus_sui_to_x: u64,
        cetus_sui_to_y: u64,
        bluefin_deposited_deep: u64,
        bluefin_deposited_sui: u64,
        cetus_deposited_x: u64,
        cetus_deposited_y: u64,
        bluefin_tick_lower: u32,
        bluefin_tick_upper: u32,
        cetus_tick_lower: u32,
        cetus_tick_upper: u32,
        residual_deep: u64,
        residual_sui: u64,
        residual_x: u64,
        residual_y: u64,
    }

    struct GenericCetusXYHarvested has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_amounts: vector<u64>,
        reward_sui: u64,
        fee_x: u64,
        fee_y: u64,
        profit_sui: u64,
    }

    struct GenericCetusXYRecentered has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        destination_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        reward_amounts: vector<u64>,
        reward_sui: u64,
        fee_x: u64,
        fee_y: u64,
        profit_sui: u64,
        source_principal_x: u64,
        source_principal_y: u64,
        principal_swap_x_to_y: bool,
        principal_swap_input: u64,
        principal_swap_output: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_x: u64,
        deposited_y: u64,
        residual_x: u64,
        residual_y: u64,
    }

    struct GenericCetusXYToBluefinExited has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        destination_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        reward_amounts: vector<u64>,
        reward_sui: u64,
        fee_x: u64,
        fee_y: u64,
        profit_sui: u64,
        source_principal_x: u64,
        source_principal_y: u64,
        net_principal_sui: u64,
        principal_sui_to_deep: u64,
        deposited_deep: u64,
        deposited_sui: u64,
        tick_lower: u32,
        tick_upper: u32,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct CetusRewardToBluefinRotated has copy, drop {
        reward_amount: u64,
        reward_sui: u64,
        fee_usdc: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_usdc: u64,
        source_principal_sui: u64,
        principal_usdc_to_sui: u64,
        principal_usdc_as_sui: u64,
        principal_sui_to_deep: u64,
        principal_deep_out: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_usdc: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct GenericCetusXSuiBluefinFallbackRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        bluefin_x_sui_pool_id: 0x2::object::ID,
    }

    struct BluefinDeepUsdcRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        primary_pool_id: 0x2::object::ID,
        farm_pool_id: 0x2::object::ID,
        sui_usdc_pool_id: 0x2::object::ID,
    }

    struct BluefinDeepUsdcPortfolioOpened has copy, drop {
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        primary_position_id: 0x2::object::ID,
        farm_position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        farm_principal_deep: u64,
        farm_sui_to_usdc: u64,
        farm_usdc_out: u64,
        primary_deposited_deep: u64,
        primary_deposited_sui: u64,
        farm_deposited_deep: u64,
        farm_deposited_usdc: u64,
        primary_tick_lower: u32,
        primary_tick_upper: u32,
        farm_tick_lower: u32,
        farm_tick_upper: u32,
        residual_deep: u64,
        residual_sui: u64,
        residual_usdc: u64,
    }

    struct BluefinDeepUsdcHarvested has copy, drop {
        route_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_usdc: u64,
        profit_sui: u64,
    }

    struct BluefinDeepUsdcRecentered has copy, drop {
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_usdc: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_usdc: u64,
        swap_deep_to_usdc: bool,
        swap_input: u64,
        swap_output: u64,
        deposited_deep: u64,
        deposited_usdc: u64,
        residual_deep: u64,
        residual_usdc: u64,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct BluefinDeepUsdcExited has copy, drop {
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_usdc: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_usdc: u64,
        principal_usdc_as_sui: u64,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_sui: u64,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct CetusToBluefinRotated has copy, drop {
        reward_deep: u64,
        reward_sui: u64,
        fee_usdc: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_usdc: u64,
        source_principal_sui: u64,
        principal_usdc_to_sui: u64,
        principal_usdc_as_sui: u64,
        principal_sui_to_deep: u64,
        principal_deep_out: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_usdc: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    fun active_spacing_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : (u32, u32) {
        assert!(arg1 > 0, 3);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), v0);
        let v2 = v1;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(arg0, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0);
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v2, v0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, v2) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, v3), 3);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3))
    }

    public(friend) fun active_spacing_range_for_test(arg0: u32, arg1: u32) : (u32, u32) {
        active_spacing_range(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), arg1)
    }

    fun assert_admin(arg0: &Registry, arg1: &AdminCap) {
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 0);
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 0);
    }

    fun assert_bluefin_deep_reward_adapter<T0, T1>(arg0: &Registry, arg1: &BluefinDeepRewardAdapter<T0, T1>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_bluefin_deep_usdc_cap<T0, T1, T2>(arg0: &Registry, arg1: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>) {
        assert_registry(arg0);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg1.primary_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.farm_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg3), 12);
        assert!(arg1.sui_usdc_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4), 12);
    }

    fun assert_cetus_deep_reward_adapter<T0, T1, T2>(arg0: &Registry, arg1: &CetusDeepRewardAdapter<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_cetus_reward_to_sui_adapter<T0, T1, T2>(arg0: &Registry, arg1: &CetusRewardToSuiAdapter<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_cetus_sui_reward_adapter<T0, T1>(arg0: &Registry, arg1: &CetusSuiRewardAdapter<T0, T1>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_generic_cetus_x_sui_bluefin_fallback<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiBluefinFallbackCap<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        assert_registry(arg0);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.bluefin_x_sui_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 12);
    }

    fun assert_generic_cetus_x_sui_cap<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert_registry(arg0);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
    }

    fun assert_generic_cetus_xy_cap<T0, T1, T2>(arg0: &Registry, arg1: &GenericCetusXYCap<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert_registry(arg0);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
    }

    fun assert_generic_cetus_xy_routes<T0, T1, T2>(arg0: &Registry, arg1: &GenericCetusXYCap<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        assert_generic_cetus_xy_cap<T0, T1, T2>(arg0, arg1, arg2);
        assert!(arg1.x_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg3), 12);
        assert!(arg1.y_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg4), 12);
    }

    fun assert_generic_cross_venue_routes<T0, T1, T2, T3>(arg0: &Registry, arg1: &GenericBluefinCetusXYCap<T0, T1, T2, T3>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>) {
        assert_registry(arg0);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg1.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3), 12);
        assert!(arg1.x_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4), 12);
        assert!(arg1.y_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>>(arg5), 12);
    }

    fun assert_generic_cross_venue_x_sui<T0, T1, T2>(arg0: &Registry, arg1: &GenericBluefinCetusXSuiCap<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>) {
        assert_registry(arg0);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg1.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3), 12);
    }

    fun assert_generic_reward_route_cap<T0, T1, T2, T3>(arg0: &Registry, arg1: &GenericCetusXYRewardRouteCap<T0, T1, T2, T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.reward_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3), 12);
    }

    fun assert_generic_sui_reward_cap<T0, T1, T2>(arg0: &Registry, arg1: &GenericCetusXYSuiRewardCap<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
    }

    fun assert_registry(arg0: &Registry) {
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
    }

    fun assert_reward_income<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &CetusXYRewardIncome<T2>) {
        assert!(arg2.source_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0), 12);
        assert!(arg2.position_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1), 14);
        assert!(arg2.expected_reward_count <= 3, 13);
        assert!(arg2.reward_count <= arg2.expected_reward_count, 13);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.reward_types) == (arg2.reward_count as u64), 13);
        assert!(0x1::vector::length<u64>(&arg2.reward_amounts) == (arg2.reward_count as u64), 13);
    }

    fun assert_route_bluefin_to_cetus<T0, T1, T2>(arg0: &Registry, arg1: &BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_route_cetus_to_bluefin<T0, T1, T2>(arg0: &Registry, arg1: &CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 1);
    }

    fun assert_x_sui_reward_shape<T0>(arg0: &CetusXYRewardIncome<T0>, arg1: &vector<0x1::type_name::TypeName>) {
        let v0 = 0x1::vector::length<0x1::type_name::TypeName>(arg1);
        assert!(arg0.expected_reward_count == (v0 as u8), 13);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.reward_types) == v0, 13);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.reward_types, v1) == 0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v1), 13);
            v1 = v1 + 1;
        };
    }

    public fun begin_cetus_x_sui_reward_collection<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert_generic_cetus_x_sui_cap<T0, T1>(arg0, arg1, arg2);
        CetusXYRewardIncome<T1>{
            source_pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            position_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3),
            reward_count          : 0,
            expected_reward_count : arg1.expected_reward_count,
            reward_types          : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reward_amounts        : vector[],
            reward_sui            : 0x2::balance::zero<T1>(),
        }
    }

    public fun begin_cetus_x_sui_reward_collection_0<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert!(arg1.expected_reward_count == 0, 13);
        begin_cetus_x_sui_reward_collection<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_x_sui_reward_collection_1<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert!(arg1.expected_reward_count == 1, 13);
        begin_cetus_x_sui_reward_collection<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_x_sui_reward_collection_2<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert!(arg1.expected_reward_count == 2, 13);
        begin_cetus_x_sui_reward_collection<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_x_sui_reward_collection_3<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert!(arg1.expected_reward_count == 3, 13);
        begin_cetus_x_sui_reward_collection<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_x_sui_reward_collection_mut_0<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert!(arg1.expected_reward_count == 0, 13);
        begin_cetus_x_sui_reward_collection<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_x_sui_reward_collection_mut_1<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert!(arg1.expected_reward_count == 1, 13);
        begin_cetus_x_sui_reward_collection<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_x_sui_reward_collection_mut_2<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert!(arg1.expected_reward_count == 2, 13);
        begin_cetus_x_sui_reward_collection<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_x_sui_reward_collection_mut_3<T0, T1>(arg0: &Registry, arg1: &GenericCetusXSuiCap<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T1> {
        assert!(arg1.expected_reward_count == 3, 13);
        begin_cetus_x_sui_reward_collection<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_xy_reward_collection<T0, T1, T2>(arg0: &Registry, arg1: &GenericCetusXYCap<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T2> {
        assert_generic_cetus_xy_cap<T0, T1, T2>(arg0, arg1, arg2);
        CetusXYRewardIncome<T2>{
            source_pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            position_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3),
            reward_count          : 0,
            expected_reward_count : arg1.expected_reward_count,
            reward_types          : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reward_amounts        : vector[],
            reward_sui            : 0x2::balance::zero<T2>(),
        }
    }

    public fun begin_cetus_xy_reward_collection_0<T0, T1, T2>(arg0: &Registry, arg1: &GenericCetusXYCap<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T2> {
        assert!(arg1.expected_reward_count == 0, 13);
        begin_cetus_xy_reward_collection<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_xy_reward_collection_1<T0, T1, T2>(arg0: &Registry, arg1: &GenericCetusXYCap<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T2> {
        assert!(arg1.expected_reward_count == 1, 13);
        begin_cetus_xy_reward_collection<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_xy_reward_collection_2<T0, T1, T2>(arg0: &Registry, arg1: &GenericCetusXYCap<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T2> {
        assert!(arg1.expected_reward_count == 2, 13);
        begin_cetus_xy_reward_collection<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun begin_cetus_xy_reward_collection_3<T0, T1, T2>(arg0: &Registry, arg1: &GenericCetusXYCap<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : CetusXYRewardIncome<T2> {
        assert!(arg1.expected_reward_count == 3, 13);
        begin_cetus_xy_reward_collection<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    fun cap_reward_types<T0, T1>(arg0: &GenericCetusXSuiCap<T0, T1>) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.expected_reward_types)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.expected_reward_types, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun centered_range(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32, arg2: u32) : (u32, u32) {
        assert!(arg2 > 0, 3);
        assert!(arg1 >= arg2, 3);
        assert!(arg1 % arg2 == 0, 3);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(arg0, v0), v0);
        let v2 = v1;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0) && !0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(arg0, v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::zero())) {
            v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0);
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg1 / arg2 - 1) / 2 * arg2));
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1));
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0, v3) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, v4), 3);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4))
    }

    public(friend) fun centered_range_for_test(arg0: u32, arg1: u32, arg2: u32) : (u32, u32) {
        centered_range(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), arg1, arg2)
    }

    fun close_bluefin_with_fees<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg3;
        let (v1, v2) = collect_bluefin_fees_if_any<T0, T1>(arg0, arg1, arg2, v0);
        let v3 = v2;
        let v4 = v1;
        let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg0);
        let v9 = &mut arg3;
        let (v10, v11) = collect_bluefin_fees_if_any<T0, T1>(arg0, arg1, arg2, v9);
        0x2::balance::join<T0>(&mut v4, v10);
        0x2::balance::join<T1>(&mut v3, v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        (v7, v8, v4, v3)
    }

    fun close_cetus_with_fees<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg3, false);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg3), arg0);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg3, false);
        0x2::balance::join<T0>(&mut v3, v6);
        0x2::balance::join<T1>(&mut v2, v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, arg3);
        (v4, v5, v3, v2)
    }

    fun collect_bluefin_fees_if_any<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg3);
        if (v0 > 0 || v1 > 0) {
            let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
            (v6, v7)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        }
    }

    public fun collect_cetus_x_sui_external_rewards_to_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &AdminCap, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg8: u64) {
        assert_registry(arg1);
        assert_admin(arg1, arg2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg3, arg4, arg5, arg6, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg4, arg5, arg6, true, arg0);
        let v3 = swap_cetus_a_to_b<T2, T1>(arg0, arg3, arg7, v2);
        0x2::balance::join<T1>(&mut v1, swap_cetus_a_to_b<T0, T1>(arg0, arg3, arg4, v0));
        0x2::balance::join<T1>(&mut v1, v3);
        let v4 = 0x2::balance::value<T1>(&v1);
        assert!(v4 >= arg8, 6);
        let v5 = GenericCetusIncomePaid{
            reward_x        : 0x2::balance::value<T0>(&v0),
            reward_sui      : 0x2::balance::value<T1>(&v1),
            reward_external : 0x2::balance::value<T2>(&v2),
            external_as_sui : 0x2::balance::value<T1>(&v3),
            profit_sui      : v4,
        };
        0x2::event::emit<GenericCetusIncomePaid>(v5);
        0x2::balance::send_funds<T1>(v1, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun collect_cetus_x_sui_x_reward_to_sui<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXYRewardRouteCap<T0, T1, T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut CetusXYRewardIncome<T1>, arg8: u64) {
        assert_registry(arg1);
        assert_generic_reward_route_cap<T0, T1, T1, T0>(arg1, arg2, arg4, arg4);
        assert_reward_income<T0, T1, T1>(arg4, arg5, arg7);
        assert!(arg7.reward_count < arg7.expected_reward_count, 13);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg7.reward_types, &v0), 13);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = swap_cetus_a_to_b<T0, T1>(arg0, arg3, arg4, v1);
        assert!(0x2::balance::value<T1>(&v2) >= arg8, 6);
        0x2::balance::join<T1>(&mut arg7.reward_sui, v2);
        arg7.reward_count = arg7.reward_count + 1;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg7.reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg7.reward_amounts, 0x2::balance::value<T0>(&v1));
    }

    public fun collect_cetus_x_sui_x_reward_to_sui_bluefin<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXSuiBluefinFallbackCap<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut CetusXYRewardIncome<T1>, arg10: u64) {
        assert_registry(arg1);
        assert_generic_cetus_x_sui_bluefin_fallback<T0, T1>(arg1, arg2, arg4, arg8);
        assert_reward_income<T0, T1, T1>(arg4, arg5, arg9);
        assert!(arg9.reward_count < arg9.expected_reward_count, 13);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg9.reward_types, &v0), 13);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = swap_bluefin_a_to_b<T0, T1>(arg0, arg7, arg8, v1);
        assert!(0x2::balance::value<T1>(&v2) >= arg10, 6);
        0x2::balance::join<T1>(&mut arg9.reward_sui, v2);
        arg9.reward_count = arg9.reward_count + 1;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg9.reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg9.reward_amounts, 0x2::balance::value<T0>(&v1));
    }

    public fun collect_cetus_xy_reward_to_sui<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXYRewardRouteCap<T0, T1, T2, T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg8: &mut CetusXYRewardIncome<T2>, arg9: u64) {
        assert_registry(arg1);
        assert_generic_reward_route_cap<T0, T1, T2, T3>(arg1, arg2, arg4, arg7);
        assert_reward_income<T0, T1, T2>(arg4, arg5, arg8);
        assert!(arg8.reward_count < arg8.expected_reward_count, 13);
        let v0 = 0x1::type_name::with_original_ids<T3>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg8.reward_types, &v0), 13);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = swap_cetus_a_to_b<T3, T2>(arg0, arg3, arg7, v1);
        assert!(0x2::balance::value<T2>(&v2) >= arg9, 6);
        0x2::balance::join<T2>(&mut arg8.reward_sui, v2);
        arg8.reward_count = arg8.reward_count + 1;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg8.reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg8.reward_amounts, 0x2::balance::value<T3>(&v1));
    }

    public fun collect_cetus_xy_sui_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXYSuiRewardCap<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut CetusXYRewardIncome<T2>, arg8: u64) {
        assert_registry(arg1);
        assert_generic_sui_reward_cap<T0, T1, T2>(arg1, arg2, arg4);
        assert_reward_income<T0, T1, T2>(arg4, arg5, arg7);
        assert!(arg7.reward_count < arg7.expected_reward_count, 13);
        let v0 = 0x1::type_name::with_original_ids<T2>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg7.reward_types, &v0), 13);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = 0x2::balance::value<T2>(&v1);
        assert!(v2 >= arg8, 6);
        0x2::balance::join<T2>(&mut arg7.reward_sui, v1);
        arg7.reward_count = arg7.reward_count + 1;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg7.reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg7.reward_amounts, v2);
    }

    fun consume_reward_income<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: CetusXYRewardIncome<T2>) : (vector<u64>, 0x2::balance::Balance<T2>) {
        assert_reward_income<T0, T1, T2>(arg0, arg1, &arg2);
        assert!(arg2.reward_count == arg2.expected_reward_count, 13);
        let CetusXYRewardIncome {
            source_pool_id        : _,
            position_id           : _,
            reward_count          : _,
            expected_reward_count : _,
            reward_types          : _,
            reward_amounts        : v5,
            reward_sui            : v6,
        } = arg2;
        (v5, v6)
    }

    public fun exit_bluefin_deep_usdc_to_deep_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u32, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        exit_bluefin_deep_usdc_to_deep_sui_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    fun exit_bluefin_deep_usdc_to_deep_sui_internal<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u32, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        assert_bluefin_deep_usdc_cap<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, &mut arg7);
        let (v1, v2, v3, v4) = close_bluefin_with_fees<T0, T2>(arg0, arg3, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T2>(&v7);
        assert!(v9 >= arg12, 4);
        assert!(v10 >= arg13, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = swap_bluefin_a_to_b<T0, T1>(arg0, arg3, arg4, v6);
        let v12 = swap_bluefin_b_to_a<T1, T2>(arg0, arg3, arg6, v5);
        0x2::balance::join<T1>(&mut v11, v12);
        let v13 = 0x2::balance::value<T1>(&v11);
        assert!(v13 >= arg14, 6);
        0x2::balance::send_funds<T1>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v14 = swap_bluefin_b_to_a<T1, T2>(arg0, arg3, arg6, v7);
        let v15 = 0x2::balance::value<T1>(&v14);
        if (arg8 > 0) {
            assert!(0x2::balance::value<T0>(&v8) >= arg8, 7);
            let v16 = swap_bluefin_a_to_b<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v8, arg8));
            0x2::balance::join<T1>(&mut v14, v16);
        };
        let (v17, v18) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), arg9, 1);
        let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg4, v17, v18, arg19);
        let (v20, v21, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg3, arg4, &mut v19, v8, v14, arg10, arg11);
        v8 = v22;
        v14 = v23;
        let v24 = 0x2::balance::value<T0>(&v8);
        let v25 = 0x2::balance::value<T1>(&v14);
        assert!(v20 >= arg15, 8);
        assert!(v21 >= arg16, 9);
        assert!(v24 <= arg17, 10);
        assert!(v25 <= arg18, 11);
        let v26 = BluefinDeepUsdcExited{
            route_id                : 0x2::object::id<BluefinDeepUsdcPortfolioCap<T0, T1, T2>>(arg2),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v19),
            reward_deep             : 0x2::balance::value<T0>(&v0),
            fee_deep                : 0x2::balance::value<T0>(&v6),
            fee_usdc                : 0x2::balance::value<T2>(&v5),
            profit_sui              : v13,
            source_principal_deep   : v9,
            source_principal_usdc   : v10,
            principal_usdc_as_sui   : v15,
            deposited_deep          : v20,
            deposited_sui           : v21,
            residual_deep           : v24,
            residual_sui            : v25,
            tick_lower              : v17,
            tick_upper              : v18,
        };
        0x2::event::emit<BluefinDeepUsdcExited>(v26);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg19));
        let v27 = 0x2::tx_context::sender(arg19);
        transfer_nonzero<T0>(v8, v27, arg19);
        let v28 = 0x2::tx_context::sender(arg19);
        transfer_nonzero<T1>(v14, v28, arg19);
    }

    public fun exit_bluefin_deep_usdc_to_deep_sui_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u32, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        exit_bluefin_deep_usdc_to_deep_sui_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public fun exit_cetus_x_sui_external_reward_to_bluefin<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &AdminCap, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg10: u64, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1);
        assert_admin(arg1, arg2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg3, arg4, &arg5, arg6, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg3, arg4, &arg5, arg6, true, arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg3, arg4, &arg5, arg6, true, arg0);
        let (v3, v4, v5, v6) = close_cetus_with_fees<T0, T1>(arg0, arg3, arg4, arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = 0x2::balance::value<T0>(&v10);
        let v12 = 0x2::balance::value<T1>(&v9);
        assert!(v11 >= arg15, 4);
        assert!(v12 >= arg16, 5);
        0x2::balance::join<T0>(&mut v8, v0);
        let v13 = swap_cetus_a_to_b<T0, T1>(arg0, arg3, arg4, v8);
        0x2::balance::join<T1>(&mut v1, v7);
        0x2::balance::join<T1>(&mut v1, v13);
        0x2::balance::join<T1>(&mut v1, swap_cetus_a_to_b<T3, T1>(arg0, arg3, arg7, v2));
        let v14 = 0x2::balance::value<T1>(&v1);
        assert!(v14 >= arg17, 6);
        0x2::balance::send_funds<T1>(v1, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        assert!(v11 >= arg10, 7);
        let v15 = swap_cetus_a_to_b<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v10, arg10));
        0x2::balance::join<T1>(&mut v9, v15);
        assert!(0x2::balance::value<T1>(&v9) >= arg11, 7);
        let v16 = swap_bluefin_b_to_a<T2, T1>(arg0, arg8, arg9, 0x2::balance::split<T1>(&mut v9, arg11));
        let (v17, v18) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T2, T1>(arg9), arg12, 1);
        let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T2, T1>(arg8, arg9, v17, v18, arg23);
        let (v20, v21, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T2, T1>(arg0, arg8, arg9, &mut v19, v16, v9, arg13, arg14);
        let v24 = v23;
        let v25 = v22;
        let v26 = 0x2::balance::value<T0>(&v10);
        let v27 = 0x2::balance::value<T2>(&v25);
        let v28 = 0x2::balance::value<T1>(&v24);
        assert!(v20 >= arg18, 8);
        assert!(v21 >= arg19, 9);
        assert!(v26 <= arg20, 10);
        assert!(v27 <= arg21, 10);
        assert!(v28 <= arg22, 11);
        let v29 = GenericCetusExited{
            reward_x             : 0x2::balance::value<T0>(&v0),
            reward_sui           : 0x2::balance::value<T1>(&v1),
            reward_external      : 0x2::balance::value<T3>(&v2),
            fee_x                : 0x2::balance::value<T0>(&v8),
            fee_sui              : 0x2::balance::value<T1>(&v7),
            profit_sui           : v14,
            source_principal_x   : v11,
            source_principal_sui : v12,
            principal_x_as_sui   : 0x2::balance::value<T1>(&v15),
            principal_deep_out   : 0x2::balance::value<T2>(&v16),
            deposited_deep       : v20,
            deposited_sui        : v21,
            residual_x           : v26,
            residual_deep        : v27,
            residual_sui         : v28,
        };
        0x2::event::emit<GenericCetusExited>(v29);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg23));
        let v30 = 0x2::tx_context::sender(arg23);
        transfer_nonzero<T0>(v10, v30, arg23);
        let v31 = 0x2::tx_context::sender(arg23);
        transfer_nonzero<T2>(v25, v31, arg23);
        let v32 = 0x2::tx_context::sender(arg23);
        transfer_nonzero<T1>(v24, v32, arg23);
    }

    public fun exit_cetus_x_sui_to_bluefin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericBluefinCetusXSuiCap<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: CetusXYRewardIncome<T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: u64, arg10: u32, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) {
        assert_generic_cross_venue_x_sui<T0, T1, T2>(arg1, arg2, arg8, arg4);
        assert_x_sui_reward_shape<T1>(&arg6, &arg2.expected_reward_types);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4);
        let (v1, v2) = consume_reward_income<T2, T1, T1>(arg4, &arg5, arg6);
        let v3 = v2;
        let (v4, v5, v6, v7) = close_cetus_with_fees<T2, T1>(arg0, arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T2>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg13, 4);
        assert!(v13 >= arg14, 5);
        let v14 = swap_cetus_a_to_b<T2, T1>(arg0, arg3, arg4, v9);
        0x2::balance::join<T1>(&mut v3, v14);
        0x2::balance::join<T1>(&mut v3, v8);
        let v15 = 0x2::balance::value<T1>(&v3);
        assert!(v15 >= arg16, 6);
        0x2::balance::send_funds<T1>(v3, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        0x2::balance::join<T1>(&mut v10, swap_cetus_a_to_b<T2, T1>(arg0, arg3, arg4, v11));
        let v16 = 0x2::balance::value<T1>(&v10);
        assert!(v16 >= arg15, 5);
        assert!(v16 >= arg9, 7);
        let v17 = swap_bluefin_b_to_a<T0, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v10, arg9));
        let (v18, v19) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg8), arg10, 1);
        let v20 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg7, arg8, v18, v19, arg21);
        let (v21, v22, v23, v24) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg7, arg8, &mut v20, v17, v10, arg11, arg12);
        let v25 = v24;
        let v26 = v23;
        let v27 = 0x2::balance::value<T0>(&v26);
        let v28 = 0x2::balance::value<T1>(&v25);
        assert!(v21 >= arg17, 8);
        assert!(v22 >= arg18, 9);
        assert!(v27 <= arg19, 10);
        assert!(v28 <= arg20, 11);
        let v29 = GenericCetusXSuiToBluefinExited{
            route_id                : 0x2::object::id<GenericBluefinCetusXSuiCap<T0, T1, T2>>(arg2),
            source_pool_id          : v0,
            destination_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg8),
            source_position_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg5),
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v20),
            reward_amounts          : v1,
            reward_sui              : 0x2::balance::value<T1>(&v3),
            fee_x                   : 0x2::balance::value<T2>(&v9),
            fee_sui                 : 0x2::balance::value<T1>(&v8),
            profit_sui              : v15,
            source_principal_x      : v12,
            source_principal_sui    : v13,
            net_principal_sui       : v16,
            principal_sui_to_deep   : arg9,
            deposited_deep          : v21,
            deposited_sui           : v22,
            tick_lower              : v18,
            tick_upper              : v19,
            residual_deep           : v27,
            residual_sui            : v28,
        };
        0x2::event::emit<GenericCetusXSuiToBluefinExited>(v29);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v20, 0x2::tx_context::sender(arg21));
        let v30 = 0x2::tx_context::sender(arg21);
        transfer_nonzero<T0>(v26, v30, arg21);
        let v31 = 0x2::tx_context::sender(arg21);
        transfer_nonzero<T1>(v25, v31, arg21);
    }

    public fun exit_cetus_x_sui_to_bluefin_fallback<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericBluefinCetusXSuiCap<T0, T1, T2>, arg3: &GenericCetusXSuiBluefinFallbackCap<T2, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg6: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: CetusXYRewardIncome<T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        assert_generic_cross_venue_x_sui<T0, T1, T2>(arg1, arg2, arg10, arg5);
        assert_generic_cetus_x_sui_bluefin_fallback<T2, T1>(arg1, arg3, arg5, arg9);
        assert_x_sui_reward_shape<T1>(&arg7, &arg2.expected_reward_types);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg5);
        let (v1, v2) = consume_reward_income<T2, T1, T1>(arg5, &arg6, arg7);
        let v3 = v2;
        let (v4, v5, v6, v7) = close_cetus_with_fees<T2, T1>(arg0, arg4, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T2>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg15, 4);
        assert!(v13 >= arg16, 5);
        let v14 = swap_bluefin_a_to_b<T2, T1>(arg0, arg8, arg9, v9);
        0x2::balance::join<T1>(&mut v3, v14);
        0x2::balance::join<T1>(&mut v3, v8);
        let v15 = 0x2::balance::value<T1>(&v3);
        assert!(v15 >= arg18, 6);
        0x2::balance::send_funds<T1>(v3, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        0x2::balance::join<T1>(&mut v10, swap_bluefin_a_to_b<T2, T1>(arg0, arg8, arg9, v11));
        let v16 = 0x2::balance::value<T1>(&v10);
        assert!(v16 >= arg17, 5);
        assert!(v16 >= arg11, 7);
        let v17 = swap_bluefin_b_to_a<T0, T1>(arg0, arg8, arg10, 0x2::balance::split<T1>(&mut v10, arg11));
        let (v18, v19) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg10), arg12, 1);
        let v20 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg8, arg10, v18, v19, arg23);
        let (v21, v22, v23, v24) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg8, arg10, &mut v20, v17, v10, arg13, arg14);
        let v25 = v24;
        let v26 = v23;
        let v27 = 0x2::balance::value<T0>(&v26);
        let v28 = 0x2::balance::value<T1>(&v25);
        assert!(v21 >= arg19, 8);
        assert!(v22 >= arg20, 9);
        assert!(v27 <= arg21, 10);
        assert!(v28 <= arg22, 11);
        let v29 = GenericCetusXSuiToBluefinExited{
            route_id                : 0x2::object::id<GenericBluefinCetusXSuiCap<T0, T1, T2>>(arg2),
            source_pool_id          : v0,
            destination_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg10),
            source_position_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg6),
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v20),
            reward_amounts          : v1,
            reward_sui              : 0x2::balance::value<T1>(&v3),
            fee_x                   : 0x2::balance::value<T2>(&v9),
            fee_sui                 : 0x2::balance::value<T1>(&v8),
            profit_sui              : v15,
            source_principal_x      : v12,
            source_principal_sui    : v13,
            net_principal_sui       : v16,
            principal_sui_to_deep   : arg11,
            deposited_deep          : v21,
            deposited_sui           : v22,
            tick_lower              : v18,
            tick_upper              : v19,
            residual_deep           : v27,
            residual_sui            : v28,
        };
        0x2::event::emit<GenericCetusXSuiToBluefinExited>(v29);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v20, 0x2::tx_context::sender(arg23));
        let v30 = 0x2::tx_context::sender(arg23);
        transfer_nonzero<T0>(v26, v30, arg23);
        let v31 = 0x2::tx_context::sender(arg23);
        transfer_nonzero<T1>(v25, v31, arg23);
    }

    public fun exit_cetus_xy_to_bluefin<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericBluefinCetusXYCap<T0, T1, T2, T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg8: CetusXYRewardIncome<T1>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        assert_generic_cross_venue_routes<T0, T1, T2, T3>(arg1, arg2, arg10, arg4, arg6, arg7);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4);
        assert!(arg8.expected_reward_count == arg2.expected_reward_count, 13);
        let (v1, v2) = consume_reward_income<T2, T3, T1>(arg4, &arg5, arg8);
        let v3 = v2;
        let (v4, v5, v6, v7) = close_cetus_with_fees<T2, T3>(arg0, arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T2>(&v11);
        let v13 = 0x2::balance::value<T3>(&v10);
        assert!(v12 >= arg15, 4);
        assert!(v13 >= arg16, 5);
        let v14 = normalize_cetus_xy_income<T2, T3, T1>(arg0, arg3, arg6, arg7, v9, v8, v3);
        let v15 = 0x2::balance::value<T1>(&v14);
        assert!(v15 >= arg18, 6);
        0x2::balance::send_funds<T1>(v14, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v16 = swap_cetus_a_to_b<T2, T1>(arg0, arg3, arg6, v11);
        0x2::balance::join<T1>(&mut v16, swap_cetus_a_to_b<T3, T1>(arg0, arg3, arg7, v10));
        let v17 = 0x2::balance::value<T1>(&v16);
        assert!(v17 >= arg17, 5);
        assert!(v17 >= arg11, 7);
        let v18 = swap_bluefin_b_to_a<T0, T1>(arg0, arg9, arg10, 0x2::balance::split<T1>(&mut v16, arg11));
        let (v19, v20) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg10), arg12, 1);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg9, arg10, v19, v20, arg23);
        let (v22, v23, v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg9, arg10, &mut v21, v18, v16, arg13, arg14);
        let v26 = v25;
        let v27 = v24;
        let v28 = 0x2::balance::value<T0>(&v27);
        let v29 = 0x2::balance::value<T1>(&v26);
        assert!(v22 >= arg19, 8);
        assert!(v23 >= arg20, 9);
        assert!(v28 <= arg21, 10);
        assert!(v29 <= arg22, 11);
        let v30 = GenericCetusXYToBluefinExited{
            route_id                : 0x2::object::id<GenericBluefinCetusXYCap<T0, T1, T2, T3>>(arg2),
            source_pool_id          : v0,
            destination_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg10),
            source_position_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg5),
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v21),
            reward_amounts          : v1,
            reward_sui              : 0x2::balance::value<T1>(&v3),
            fee_x                   : 0x2::balance::value<T2>(&v9),
            fee_y                   : 0x2::balance::value<T3>(&v8),
            profit_sui              : v15,
            source_principal_x      : v12,
            source_principal_y      : v13,
            net_principal_sui       : v17,
            principal_sui_to_deep   : arg11,
            deposited_deep          : v22,
            deposited_sui           : v23,
            tick_lower              : v19,
            tick_upper              : v20,
            residual_deep           : v28,
            residual_sui            : v29,
        };
        0x2::event::emit<GenericCetusXYToBluefinExited>(v30);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg23));
        let v31 = 0x2::tx_context::sender(arg23);
        transfer_nonzero<T0>(v27, v31, arg23);
        let v32 = 0x2::tx_context::sender(arg23);
        transfer_nonzero<T1>(v26, v32, arg23);
    }

    public fun harvest_bluefin_deep_usdc_to_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64) {
        assert_bluefin_deep_usdc_cap<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, arg7);
        let (v1, v2) = collect_bluefin_fees_if_any<T0, T2>(arg0, arg3, arg5, arg7);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T0>(&mut v4, v0);
        let v5 = swap_bluefin_a_to_b<T0, T1>(arg0, arg3, arg4, v4);
        0x2::balance::join<T1>(&mut v5, swap_bluefin_b_to_a<T1, T2>(arg0, arg3, arg6, v3));
        let v6 = 0x2::balance::value<T1>(&v5);
        assert!(v6 >= arg8, 6);
        let v7 = BluefinDeepUsdcHarvested{
            route_id    : 0x2::object::id<BluefinDeepUsdcPortfolioCap<T0, T1, T2>>(arg2),
            position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg7),
            reward_deep : 0x2::balance::value<T0>(&v0),
            fee_deep    : 0x2::balance::value<T0>(&v4),
            fee_usdc    : 0x2::balance::value<T2>(&v3),
            profit_sui  : v6,
        };
        0x2::event::emit<BluefinDeepUsdcHarvested>(v7);
        0x2::balance::send_funds<T1>(v5, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun harvest_cetus_x_sui_to_sui<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXSuiCap<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: CetusXYRewardIncome<T1>, arg7: u64) {
        assert_generic_cetus_x_sui_cap<T0, T1>(arg1, arg2, arg4);
        assert_x_sui_reward_shape<T1>(&arg6, &arg2.expected_reward_types);
        let (v0, v1) = consume_reward_income<T0, T1, T1>(arg4, arg5, arg6);
        let v2 = v1;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, arg5, true);
        let v5 = v4;
        let v6 = v3;
        let v7 = swap_cetus_a_to_b<T0, T1>(arg0, arg3, arg4, v6);
        0x2::balance::join<T1>(&mut v2, v7);
        0x2::balance::join<T1>(&mut v2, v5);
        let v8 = 0x2::balance::value<T1>(&v2);
        assert!(v8 >= arg7, 6);
        let v9 = GenericCetusXSuiHarvested{
            route_id       : 0x2::object::id<GenericCetusXSuiCap<T0, T1>>(arg2),
            source_pool_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg5),
            reward_amounts : v0,
            reward_sui     : 0x2::balance::value<T1>(&v2),
            fee_x          : 0x2::balance::value<T0>(&v6),
            fee_sui        : 0x2::balance::value<T1>(&v5),
            profit_sui     : v8,
        };
        0x2::event::emit<GenericCetusXSuiHarvested>(v9);
        0x2::balance::send_funds<T1>(v2, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun harvest_cetus_x_sui_to_sui_bluefin_fallback<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXSuiCap<T0, T1>, arg3: &GenericCetusXSuiBluefinFallbackCap<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: CetusXYRewardIncome<T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: u64) {
        assert_generic_cetus_x_sui_cap<T0, T1>(arg1, arg2, arg5);
        assert_generic_cetus_x_sui_bluefin_fallback<T0, T1>(arg1, arg3, arg5, arg9);
        assert_x_sui_reward_shape<T1>(&arg7, &arg2.expected_reward_types);
        let (v0, v1) = consume_reward_income<T0, T1, T1>(arg5, arg6, arg7);
        let v2 = v1;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg4, arg5, arg6, true);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::join<T1>(&mut v2, swap_bluefin_a_to_b<T0, T1>(arg0, arg8, arg9, v6));
        0x2::balance::join<T1>(&mut v2, v5);
        let v7 = 0x2::balance::value<T1>(&v2);
        assert!(v7 >= arg10, 6);
        let v8 = GenericCetusXSuiHarvested{
            route_id       : 0x2::object::id<GenericCetusXSuiCap<T0, T1>>(arg2),
            source_pool_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5),
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg6),
            reward_amounts : v0,
            reward_sui     : 0x2::balance::value<T1>(&v2),
            fee_x          : 0x2::balance::value<T0>(&v6),
            fee_sui        : 0x2::balance::value<T1>(&v5),
            profit_sui     : v7,
        };
        0x2::event::emit<GenericCetusXSuiHarvested>(v8);
        0x2::balance::send_funds<T1>(v2, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    public fun harvest_cetus_xy_to_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXYCap<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: CetusXYRewardIncome<T2>, arg9: u64) {
        assert_generic_cetus_xy_routes<T0, T1, T2>(arg1, arg2, arg4, arg6, arg7);
        assert!(arg8.expected_reward_count == arg2.expected_reward_count, 13);
        let (v0, v1) = consume_reward_income<T0, T1, T2>(arg4, arg5, arg8);
        let v2 = v1;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, arg5, true);
        let v5 = v4;
        let v6 = v3;
        let v7 = normalize_cetus_xy_income<T0, T1, T2>(arg0, arg3, arg6, arg7, v6, v5, v2);
        let v8 = 0x2::balance::value<T2>(&v7);
        assert!(v8 >= arg9, 6);
        let v9 = GenericCetusXYHarvested{
            route_id       : 0x2::object::id<GenericCetusXYCap<T0, T1, T2>>(arg2),
            source_pool_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg5),
            reward_amounts : v0,
            reward_sui     : 0x2::balance::value<T2>(&v2),
            fee_x          : 0x2::balance::value<T0>(&v6),
            fee_y          : 0x2::balance::value<T1>(&v5),
            profit_sui     : v8,
        };
        0x2::event::emit<GenericCetusXYHarvested>(v9);
        0x2::balance::send_funds<T2>(v7, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : v1,
        };
        let v3 = 0x2::object::id<AdminCap>(&v2);
        let v4 = Registry{
            id               : v0,
            admin_cap_id     : v3,
            profit_recipient : @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292,
        };
        let v5 = RegistryCreated{
            registry_id      : v1,
            admin_cap_id     : v3,
            profit_recipient : @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292,
        };
        0x2::event::emit<RegistryCreated>(v5);
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Registry>(v4);
    }

    fun mint_generic_cetus_x_sui_caps<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: vector<0x1::type_name::TypeName>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = (0x1::vector::length<0x1::type_name::TypeName>(&arg4) as u8);
        assert!(v0 <= 3, 13);
        let v1 = 0x2::object::id<Registry>(arg0);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3);
        assert!(v2 != v3, 12);
        let v4 = GenericCetusXSuiCap<T2, T1>{
            id                    : 0x2::object::new(arg5),
            registry_id           : v1,
            cetus_pool_id         : v3,
            expected_reward_count : v0,
            expected_reward_types : arg4,
        };
        let v5 = GenericBluefinCetusXSuiCap<T0, T1, T2>{
            id                    : 0x2::object::new(arg5),
            registry_id           : v1,
            bluefin_pool_id       : v2,
            cetus_pool_id         : v3,
            expected_reward_count : v0,
            expected_reward_types : cap_reward_types<T2, T1>(&v4),
        };
        let v6 = GenericCetusXSuiRegistered{
            registry_id           : v1,
            cetus_route_id        : 0x2::object::id<GenericCetusXSuiCap<T2, T1>>(&v4),
            cross_venue_route_id  : 0x2::object::id<GenericBluefinCetusXSuiCap<T0, T1, T2>>(&v5),
            cetus_pool_id         : v3,
            bluefin_pool_id       : v2,
            expected_reward_count : v0,
        };
        0x2::event::emit<GenericCetusXSuiRegistered>(v6);
        0x2::transfer::public_transfer<GenericCetusXSuiCap<T2, T1>>(v4, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<GenericBluefinCetusXSuiCap<T0, T1, T2>>(v5, 0x2::tx_context::sender(arg5));
    }

    fun normalize_cetus_xy_income<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: 0x2::balance::Balance<T2>) : 0x2::balance::Balance<T2> {
        0x2::balance::join<T2>(&mut arg6, swap_cetus_a_to_b<T0, T2>(arg0, arg1, arg2, arg4));
        0x2::balance::join<T2>(&mut arg6, swap_cetus_a_to_b<T1, T2>(arg0, arg1, arg3, arg5));
        arg6
    }

    public fun open_bluefin_and_generic_cetus_x_sui_from_bluefin<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericBluefinCetusXSuiCap<T0, T1, T2>, arg3: &BluefinDeepRewardAdapter<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: u64, arg11: u64, arg12: u32, arg13: u32, arg14: u64, arg15: bool, arg16: u64, arg17: bool, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: &mut 0x2::tx_context::TxContext) {
        assert_generic_cross_venue_x_sui<T0, T1, T2>(arg1, arg2, arg5, arg8);
        assert_bluefin_deep_reward_adapter<T0, T1>(arg1, arg3);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v2, v3, v4, v5) = close_bluefin_with_fees<T0, T1>(arg0, arg4, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg18, 4);
        assert!(v11 >= arg19, 5);
        0x2::balance::join<T0>(&mut v7, v1);
        let v12 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, v7);
        0x2::balance::join<T1>(&mut v12, v6);
        let v13 = 0x2::balance::value<T1>(&v12);
        assert!(v13 >= arg21, 6);
        0x2::balance::send_funds<T1>(v12, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v14 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, v9);
        0x2::balance::join<T1>(&mut v8, v14);
        let v15 = 0x2::balance::value<T1>(&v8);
        assert!(v15 >= arg20, 5);
        assert!(0x2::balance::value<T1>(&v8) >= arg10, 7);
        let v16 = swap_cetus_b_to_a<T2, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v8, arg10));
        assert!(0x2::balance::value<T1>(&v8) >= arg11, 7);
        let v17 = 0x2::balance::split<T1>(&mut v8, arg11);
        assert!(0x2::balance::value<T1>(&v8) >= arg9, 7);
        let v18 = swap_bluefin_b_to_a<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T1>(&mut v8, arg9));
        let (v19, v20) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg12, 1);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v19, v20, arg30);
        let (v22, v23, v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v21, v18, v8, arg14, arg15);
        let v26 = v25;
        let v27 = v24;
        let (v28, v29) = centered_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T1>(arg8), arg13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T1>(arg8));
        let v30 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T2, T1>(arg7, arg8, v28, v29, arg30);
        let v31 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T2, T1>(arg7, arg8, &mut v30, arg16, arg17, arg0);
        let (v32, v33) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T2, T1>(&v31);
        assert!(0x2::balance::value<T2>(&v16) >= v32, 8);
        assert!(0x2::balance::value<T1>(&v17) >= v33, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T2, T1>(arg7, arg8, 0x2::balance::split<T2>(&mut v16, v32), 0x2::balance::split<T1>(&mut v17, v33), v31);
        let v34 = 0x2::balance::value<T0>(&v27);
        let v35 = 0x2::balance::value<T1>(&v26);
        let v36 = 0x2::balance::value<T2>(&v16);
        let v37 = 0x2::balance::value<T1>(&v17);
        assert!(v22 >= arg22, 8);
        assert!(v23 >= arg23, 9);
        assert!(v32 >= arg24, 8);
        assert!(v33 >= arg25, 9);
        assert!(v34 <= arg26, 10);
        assert!(v35 <= arg27, 11);
        assert!(v36 <= arg28, 10);
        assert!(v37 <= arg29, 11);
        let v38 = GenericBluefinCetusXSuiOpened{
            route_id                    : 0x2::object::id<GenericBluefinCetusXSuiCap<T0, T1, T2>>(arg2),
            source_pool_id              : v0,
            source_position_id          : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg6),
            bluefin_destination_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5),
            cetus_destination_pool_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg8),
            bluefin_position_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v21),
            cetus_position_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v30),
            reward_deep                 : 0x2::balance::value<T0>(&v1),
            fee_deep                    : 0x2::balance::value<T0>(&v7),
            fee_sui                     : 0x2::balance::value<T1>(&v6),
            profit_sui                  : v13,
            source_principal_deep       : v10,
            source_principal_sui        : v11,
            net_principal_sui           : v15,
            bluefin_sui_to_deep         : arg9,
            cetus_sui_to_x              : arg10,
            cetus_sui_reserve           : arg11,
            bluefin_deposited_deep      : v22,
            bluefin_deposited_sui       : v23,
            cetus_deposited_x           : v32,
            cetus_deposited_sui         : v33,
            bluefin_tick_lower          : v19,
            bluefin_tick_upper          : v20,
            cetus_tick_lower            : v28,
            cetus_tick_upper            : v29,
            residual_deep               : v34,
            residual_sui                : v35,
            residual_x                  : v36,
            residual_cetus_sui          : v37,
        };
        0x2::event::emit<GenericBluefinCetusXSuiOpened>(v38);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg30));
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v30, 0x2::tx_context::sender(arg30));
        0x2::balance::join<T1>(&mut v26, v17);
        let v39 = 0x2::tx_context::sender(arg30);
        transfer_nonzero<T0>(v27, v39, arg30);
        let v40 = 0x2::tx_context::sender(arg30);
        transfer_nonzero<T1>(v26, v40, arg30);
        let v41 = 0x2::tx_context::sender(arg30);
        transfer_nonzero<T2>(v16, v41, arg30);
    }

    public fun open_bluefin_and_generic_cetus_xy_from_bluefin<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericBluefinCetusXYCap<T0, T1, T2, T3>, arg3: &BluefinDeepRewardAdapter<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg11: u64, arg12: u64, arg13: u64, arg14: u32, arg15: u32, arg16: u64, arg17: bool, arg18: u64, arg19: bool, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: &mut 0x2::tx_context::TxContext) {
        assert_generic_cross_venue_routes<T0, T1, T2, T3>(arg1, arg2, arg5, arg8, arg9, arg10);
        assert_bluefin_deep_reward_adapter<T0, T1>(arg1, arg3);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v2, v3, v4, v5) = close_bluefin_with_fees<T0, T1>(arg0, arg4, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg20, 4);
        assert!(v11 >= arg21, 5);
        0x2::balance::join<T0>(&mut v7, v1);
        let v12 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, v7);
        0x2::balance::join<T1>(&mut v12, v6);
        let v13 = 0x2::balance::value<T1>(&v12);
        assert!(v13 >= arg23, 6);
        0x2::balance::send_funds<T1>(v12, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v14 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, v9);
        0x2::balance::join<T1>(&mut v8, v14);
        let v15 = 0x2::balance::value<T1>(&v8);
        assert!(v15 >= arg22, 5);
        assert!(v15 >= arg11, 7);
        let v16 = swap_bluefin_b_to_a<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T1>(&mut v8, arg11));
        assert!(0x2::balance::value<T1>(&v8) >= arg12, 7);
        let v17 = swap_cetus_b_to_a<T2, T1>(arg0, arg7, arg9, 0x2::balance::split<T1>(&mut v8, arg12));
        assert!(0x2::balance::value<T1>(&v8) >= arg13, 7);
        let v18 = swap_cetus_b_to_a<T3, T1>(arg0, arg7, arg10, 0x2::balance::split<T1>(&mut v8, arg13));
        let (v19, v20) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg14, 1);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v19, v20, arg32);
        let (v22, v23, v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v21, v16, v8, arg16, arg17);
        let v26 = v25;
        let v27 = v24;
        let (v28, v29) = centered_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T3>(arg8), arg15, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T3>(arg8));
        let v30 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T2, T3>(arg7, arg8, v28, v29, arg32);
        let v31 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T2, T3>(arg7, arg8, &mut v30, arg18, arg19, arg0);
        let (v32, v33) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T2, T3>(&v31);
        assert!(0x2::balance::value<T2>(&v17) >= v32, 8);
        assert!(0x2::balance::value<T3>(&v18) >= v33, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T2, T3>(arg7, arg8, 0x2::balance::split<T2>(&mut v17, v32), 0x2::balance::split<T3>(&mut v18, v33), v31);
        let v34 = 0x2::balance::value<T0>(&v27);
        let v35 = 0x2::balance::value<T1>(&v26);
        let v36 = 0x2::balance::value<T2>(&v17);
        let v37 = 0x2::balance::value<T3>(&v18);
        assert!(v22 >= arg24, 8);
        assert!(v23 >= arg25, 9);
        assert!(v32 >= arg26, 8);
        assert!(v33 >= arg27, 9);
        assert!(v34 <= arg28, 10);
        assert!(v35 <= arg29, 11);
        assert!(v36 <= arg30, 10);
        assert!(v37 <= arg31, 11);
        let v38 = GenericBluefinCetusXYOpened{
            route_id                    : 0x2::object::id<GenericBluefinCetusXYCap<T0, T1, T2, T3>>(arg2),
            source_pool_id              : v0,
            source_position_id          : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg6),
            bluefin_destination_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5),
            cetus_destination_pool_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg8),
            bluefin_position_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v21),
            cetus_position_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v30),
            reward_deep                 : 0x2::balance::value<T0>(&v1),
            fee_deep                    : 0x2::balance::value<T0>(&v7),
            fee_sui                     : 0x2::balance::value<T1>(&v6),
            profit_sui                  : v13,
            source_principal_deep       : v10,
            source_principal_sui        : v11,
            net_principal_sui           : v15,
            bluefin_sui_to_deep         : arg11,
            cetus_sui_to_x              : arg12,
            cetus_sui_to_y              : arg13,
            bluefin_deposited_deep      : v22,
            bluefin_deposited_sui       : v23,
            cetus_deposited_x           : v32,
            cetus_deposited_y           : v33,
            bluefin_tick_lower          : v19,
            bluefin_tick_upper          : v20,
            cetus_tick_lower            : v28,
            cetus_tick_upper            : v29,
            residual_deep               : v34,
            residual_sui                : v35,
            residual_x                  : v36,
            residual_y                  : v37,
        };
        0x2::event::emit<GenericBluefinCetusXYOpened>(v38);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg32));
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v30, 0x2::tx_context::sender(arg32));
        let v39 = 0x2::tx_context::sender(arg32);
        transfer_nonzero<T0>(v27, v39, arg32);
        let v40 = 0x2::tx_context::sender(arg32);
        transfer_nonzero<T1>(v26, v40, arg32);
        let v41 = 0x2::tx_context::sender(arg32);
        transfer_nonzero<T2>(v17, v41, arg32);
        let v42 = 0x2::tx_context::sender(arg32);
        transfer_nonzero<T3>(v18, v42, arg32);
    }

    public fun open_bluefin_deep_sui_and_deep_usdc<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u64, arg10: u32, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: bool, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: &mut 0x2::tx_context::TxContext) {
        open_bluefin_deep_sui_and_deep_usdc_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
    }

    fun open_bluefin_deep_sui_and_deep_usdc_internal<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: &mut 0x2::tx_context::TxContext) {
        assert_bluefin_deep_usdc_cap<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg3, arg4, &mut arg7);
        let (v1, v2, v3, v4) = close_bluefin_with_fees<T0, T1>(arg0, arg3, arg4, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg17, 4);
        assert!(v10 >= arg18, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = swap_bluefin_a_to_b<T0, T1>(arg0, arg3, arg4, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg19, 6);
        0x2::balance::send_funds<T1>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        assert!(0x2::balance::value<T0>(&v8) >= arg8, 7);
        let v13 = 0x2::balance::split<T0>(&mut v8, arg8);
        if (0x2::balance::value<T1>(&v7) < arg9) {
            assert!(0x2::balance::value<T0>(&v8) >= arg8, 7);
            let v14 = swap_bluefin_a_to_b<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v8, arg8));
            0x2::balance::join<T1>(&mut v7, v14);
        };
        assert!(0x2::balance::value<T1>(&v7) >= arg9, 7);
        let v15 = swap_bluefin_a_to_b<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T1>(&mut v7, arg9));
        let v16 = v15;
        if (arg10 > 0) {
            assert!(0x2::balance::value<T1>(&v7) >= arg10, 7);
            let v17 = swap_bluefin_b_to_a<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v7, arg10));
            0x2::balance::join<T0>(&mut v8, v17);
        };
        let (v18, v19) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), arg11, 1);
        let v20 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg4, v18, v19, arg27);
        let (v21, v22, v23, v24) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg3, arg4, &mut v20, v8, v7, arg13, arg14);
        v8 = v23;
        v7 = v24;
        let (v25, v26) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg5), arg12, 1);
        let v27 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T2>(arg3, arg5, v25, v26, arg27);
        let (v28, v29, v30, v31) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg3, arg5, &mut v27, v13, v16, arg15, arg16);
        v16 = v31;
        0x2::balance::join<T0>(&mut v8, v30);
        let v32 = 0x2::balance::value<T0>(&v8);
        let v33 = 0x2::balance::value<T1>(&v7);
        let v34 = 0x2::balance::value<T2>(&v16);
        assert!(v21 >= arg20, 8);
        assert!(v22 >= arg21, 9);
        assert!(v28 >= arg22, 8);
        assert!(v29 >= arg23, 9);
        assert!(v32 <= arg24, 10);
        assert!(v33 <= arg25, 11);
        assert!(v34 <= arg26, 11);
        let v35 = BluefinDeepUsdcPortfolioOpened{
            route_id               : 0x2::object::id<BluefinDeepUsdcPortfolioCap<T0, T1, T2>>(arg2),
            source_position_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            primary_position_id    : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v20),
            farm_position_id       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v27),
            reward_deep            : 0x2::balance::value<T0>(&v0),
            fee_deep               : 0x2::balance::value<T0>(&v6),
            fee_sui                : 0x2::balance::value<T1>(&v5),
            profit_sui             : v12,
            source_principal_deep  : v9,
            source_principal_sui   : v10,
            farm_principal_deep    : arg8,
            farm_sui_to_usdc       : arg9,
            farm_usdc_out          : 0x2::balance::value<T2>(&v15),
            primary_deposited_deep : v21,
            primary_deposited_sui  : v22,
            farm_deposited_deep    : v28,
            farm_deposited_usdc    : v29,
            primary_tick_lower     : v18,
            primary_tick_upper     : v19,
            farm_tick_lower        : v25,
            farm_tick_upper        : v26,
            residual_deep          : v32,
            residual_sui           : v33,
            residual_usdc          : v34,
        };
        0x2::event::emit<BluefinDeepUsdcPortfolioOpened>(v35);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v20, 0x2::tx_context::sender(arg27));
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v27, 0x2::tx_context::sender(arg27));
        let v36 = 0x2::tx_context::sender(arg27);
        transfer_nonzero<T0>(v8, v36, arg27);
        let v37 = 0x2::tx_context::sender(arg27);
        transfer_nonzero<T1>(v7, v37, arg27);
        let v38 = 0x2::tx_context::sender(arg27);
        transfer_nonzero<T2>(v16, v38, arg27);
    }

    public fun open_bluefin_deep_sui_and_deep_usdc_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: &mut 0x2::tx_context::TxContext) {
        open_bluefin_deep_sui_and_deep_usdc_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27);
    }

    public fun recenter_bluefin_deep_usdc<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepUsdcPortfolioCap<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: bool, arg9: u64, arg10: u32, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) {
        assert_bluefin_deep_usdc_cap<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, &mut arg7);
        let (v1, v2, v3, v4) = close_bluefin_with_fees<T0, T2>(arg0, arg3, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T2>(&v7);
        assert!(v9 >= arg13, 4);
        assert!(v10 >= arg14, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = swap_bluefin_a_to_b<T0, T1>(arg0, arg3, arg4, v6);
        0x2::balance::join<T1>(&mut v11, swap_bluefin_b_to_a<T1, T2>(arg0, arg3, arg6, v5));
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg15, 6);
        0x2::balance::send_funds<T1>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v13 = if (arg9 == 0) {
            0
        } else if (arg8) {
            assert!(0x2::balance::value<T0>(&v8) >= arg9, 7);
            let v14 = swap_bluefin_a_to_b<T0, T2>(arg0, arg3, arg5, 0x2::balance::split<T0>(&mut v8, arg9));
            0x2::balance::join<T2>(&mut v7, v14);
            0x2::balance::value<T2>(&v14)
        } else {
            assert!(0x2::balance::value<T2>(&v7) >= arg9, 7);
            let v15 = swap_bluefin_b_to_a<T0, T2>(arg0, arg3, arg5, 0x2::balance::split<T2>(&mut v7, arg9));
            0x2::balance::join<T0>(&mut v8, v15);
            0x2::balance::value<T0>(&v15)
        };
        let (v16, v17) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg5), arg10, 1);
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T2>(arg3, arg5, v16, v17, arg20);
        let (v19, v20, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg3, arg5, &mut v18, v8, v7, arg11, arg12);
        v8 = v21;
        v7 = v22;
        let v23 = 0x2::balance::value<T0>(&v8);
        let v24 = 0x2::balance::value<T2>(&v7);
        assert!(v19 >= arg16, 8);
        assert!(v20 >= arg17, 9);
        assert!(v23 <= arg18, 10);
        assert!(v24 <= arg19, 11);
        let v25 = BluefinDeepUsdcRecentered{
            route_id                : 0x2::object::id<BluefinDeepUsdcPortfolioCap<T0, T1, T2>>(arg2),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v18),
            reward_deep             : 0x2::balance::value<T0>(&v0),
            fee_deep                : 0x2::balance::value<T0>(&v6),
            fee_usdc                : 0x2::balance::value<T2>(&v5),
            profit_sui              : v12,
            source_principal_deep   : v9,
            source_principal_usdc   : v10,
            swap_deep_to_usdc       : arg8,
            swap_input              : arg9,
            swap_output             : v13,
            deposited_deep          : v19,
            deposited_usdc          : v20,
            residual_deep           : v23,
            residual_usdc           : v24,
            tick_lower              : v16,
            tick_upper              : v17,
        };
        0x2::event::emit<BluefinDeepUsdcRecentered>(v25);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v18, 0x2::tx_context::sender(arg20));
        let v26 = 0x2::tx_context::sender(arg20);
        transfer_nonzero<T0>(v8, v26, arg20);
        let v27 = 0x2::tx_context::sender(arg20);
        transfer_nonzero<T2>(v7, v27, arg20);
    }

    public fun recenter_cetus_x_sui<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXSuiCap<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: CetusXYRewardIncome<T1>, arg7: bool, arg8: u64, arg9: u32, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        assert_generic_cetus_x_sui_cap<T0, T1>(arg1, arg2, arg4);
        assert_x_sui_reward_shape<T1>(&arg6, &arg2.expected_reward_types);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4);
        let (v1, v2) = consume_reward_income<T0, T1, T1>(arg4, &arg5, arg6);
        let v3 = v2;
        let (v4, v5, v6, v7) = close_cetus_with_fees<T0, T1>(arg0, arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg12, 4);
        assert!(v13 >= arg13, 5);
        let v14 = swap_cetus_a_to_b<T0, T1>(arg0, arg3, arg4, v9);
        0x2::balance::join<T1>(&mut v3, v14);
        0x2::balance::join<T1>(&mut v3, v8);
        let v15 = 0x2::balance::value<T1>(&v3);
        assert!(v15 >= arg14, 6);
        0x2::balance::send_funds<T1>(v3, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v16 = 0;
        if (arg8 > 0) {
            if (arg7) {
                assert!(0x2::balance::value<T0>(&v11) >= arg8, 7);
                let v17 = swap_cetus_a_to_b<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v11, arg8));
                v16 = 0x2::balance::value<T1>(&v17);
                0x2::balance::join<T1>(&mut v10, v17);
            } else {
                assert!(0x2::balance::value<T1>(&v10) >= arg8, 7);
                let v18 = swap_cetus_b_to_a<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v10, arg8));
                v16 = 0x2::balance::value<T0>(&v18);
                0x2::balance::join<T0>(&mut v11, v18);
            };
        };
        let (v19, v20) = centered_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg4), arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4));
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg4, v19, v20, arg19);
        let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg4, &mut v21, arg10, arg11, arg0);
        let (v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v22);
        assert!(0x2::balance::value<T0>(&v11) >= v23, 8);
        assert!(0x2::balance::value<T1>(&v10) >= v24, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg3, arg4, 0x2::balance::split<T0>(&mut v11, v23), 0x2::balance::split<T1>(&mut v10, v24), v22);
        let v25 = 0x2::balance::value<T0>(&v11);
        let v26 = 0x2::balance::value<T1>(&v10);
        assert!(v23 >= arg15, 8);
        assert!(v24 >= arg16, 9);
        assert!(v25 <= arg17, 10);
        assert!(v26 <= arg18, 11);
        let v27 = GenericCetusXSuiRecentered{
            route_id                : 0x2::object::id<GenericCetusXSuiCap<T0, T1>>(arg2),
            source_pool_id          : v0,
            source_position_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg5),
            destination_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v21),
            reward_amounts          : v1,
            reward_sui              : 0x2::balance::value<T1>(&v3),
            fee_x                   : 0x2::balance::value<T0>(&v9),
            fee_sui                 : 0x2::balance::value<T1>(&v8),
            profit_sui              : v15,
            source_principal_x      : v12,
            source_principal_sui    : v13,
            principal_swap_x_to_sui : arg7,
            principal_swap_input    : arg8,
            principal_swap_output   : v16,
            tick_lower              : v19,
            tick_upper              : v20,
            deposited_x             : v23,
            deposited_sui           : v24,
            residual_x              : v25,
            residual_sui            : v26,
        };
        0x2::event::emit<GenericCetusXSuiRecentered>(v27);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v21, 0x2::tx_context::sender(arg19));
        let v28 = 0x2::tx_context::sender(arg19);
        transfer_nonzero<T0>(v11, v28, arg19);
        let v29 = 0x2::tx_context::sender(arg19);
        transfer_nonzero<T1>(v10, v29, arg19);
    }

    public fun recenter_cetus_x_sui_bluefin_fallback<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXSuiCap<T0, T1>, arg3: &GenericCetusXSuiBluefinFallbackCap<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: CetusXYRewardIncome<T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: bool, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        assert_generic_cetus_x_sui_cap<T0, T1>(arg1, arg2, arg5);
        assert_generic_cetus_x_sui_bluefin_fallback<T0, T1>(arg1, arg3, arg5, arg9);
        assert_x_sui_reward_shape<T1>(&arg7, &arg2.expected_reward_types);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5);
        let (v1, v2) = consume_reward_income<T0, T1, T1>(arg5, &arg6, arg7);
        let v3 = v2;
        let (v4, v5, v6, v7) = close_cetus_with_fees<T0, T1>(arg0, arg4, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg15, 4);
        assert!(v13 >= arg16, 5);
        let v14 = swap_bluefin_a_to_b<T0, T1>(arg0, arg8, arg9, v9);
        0x2::balance::join<T1>(&mut v3, v14);
        0x2::balance::join<T1>(&mut v3, v8);
        let v15 = 0x2::balance::value<T1>(&v3);
        assert!(v15 >= arg17, 6);
        0x2::balance::send_funds<T1>(v3, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v16 = 0;
        if (arg11 > 0) {
            if (arg10) {
                assert!(0x2::balance::value<T0>(&v11) >= arg11, 7);
                let v17 = swap_bluefin_a_to_b<T0, T1>(arg0, arg8, arg9, 0x2::balance::split<T0>(&mut v11, arg11));
                v16 = 0x2::balance::value<T1>(&v17);
                0x2::balance::join<T1>(&mut v10, v17);
            } else {
                assert!(0x2::balance::value<T1>(&v10) >= arg11, 7);
                let v18 = swap_bluefin_b_to_a<T0, T1>(arg0, arg8, arg9, 0x2::balance::split<T1>(&mut v10, arg11));
                v16 = 0x2::balance::value<T0>(&v18);
                0x2::balance::join<T0>(&mut v11, v18);
            };
        };
        let (v19, v20) = centered_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), arg12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg5));
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg4, arg5, v19, v20, arg22);
        let v22 = if (arg13 == 18446744073709551615) {
            let v23 = 0x2::balance::value<T0>(&v11);
            assert!(v23 > arg20, 8);
            v23 - arg20
        } else {
            arg13
        };
        let v24 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg4, arg5, &mut v21, v22, arg14, arg0);
        let (v25, v26) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v24);
        assert!(0x2::balance::value<T0>(&v11) >= v25, 8);
        assert!(0x2::balance::value<T1>(&v10) >= v26, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg4, arg5, 0x2::balance::split<T0>(&mut v11, v25), 0x2::balance::split<T1>(&mut v10, v26), v24);
        let v27 = 0x2::balance::value<T0>(&v11);
        let v28 = 0x2::balance::value<T1>(&v10);
        assert!(v25 >= arg18, 8);
        assert!(v26 >= arg19, 9);
        assert!(v27 <= arg20, 10);
        assert!(v28 <= arg21, 11);
        let v29 = GenericCetusXSuiRecentered{
            route_id                : 0x2::object::id<GenericCetusXSuiCap<T0, T1>>(arg2),
            source_pool_id          : v0,
            source_position_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg6),
            destination_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v21),
            reward_amounts          : v1,
            reward_sui              : 0x2::balance::value<T1>(&v3),
            fee_x                   : 0x2::balance::value<T0>(&v9),
            fee_sui                 : 0x2::balance::value<T1>(&v8),
            profit_sui              : v15,
            source_principal_x      : v12,
            source_principal_sui    : v13,
            principal_swap_x_to_sui : arg10,
            principal_swap_input    : arg11,
            principal_swap_output   : v16,
            tick_lower              : v19,
            tick_upper              : v20,
            deposited_x             : v25,
            deposited_sui           : v26,
            residual_x              : v27,
            residual_sui            : v28,
        };
        0x2::event::emit<GenericCetusXSuiRecentered>(v29);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v21, 0x2::tx_context::sender(arg22));
        let v30 = 0x2::tx_context::sender(arg22);
        transfer_nonzero<T0>(v11, v30, arg22);
        let v31 = 0x2::tx_context::sender(arg22);
        transfer_nonzero<T1>(v10, v31, arg22);
    }

    public fun recenter_cetus_xy<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &GenericCetusXYCap<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: CetusXYRewardIncome<T2>, arg9: bool, arg10: u64, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) {
        assert_generic_cetus_xy_routes<T0, T1, T2>(arg1, arg2, arg4, arg6, arg7);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4);
        assert!(arg8.expected_reward_count == arg2.expected_reward_count, 13);
        let (v1, v2) = consume_reward_income<T0, T1, T2>(arg4, &arg5, arg8);
        let v3 = v2;
        let (v4, v5, v6, v7) = close_cetus_with_fees<T0, T1>(arg0, arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg14, 4);
        assert!(v13 >= arg15, 5);
        let v14 = normalize_cetus_xy_income<T0, T1, T2>(arg0, arg3, arg6, arg7, v9, v8, v3);
        let v15 = 0x2::balance::value<T2>(&v14);
        assert!(v15 >= arg16, 6);
        0x2::balance::send_funds<T2>(v14, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v16 = 0;
        if (arg10 > 0) {
            if (arg9) {
                assert!(0x2::balance::value<T0>(&v11) >= arg10, 7);
                let v17 = swap_cetus_a_to_b<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v11, arg10));
                v16 = 0x2::balance::value<T1>(&v17);
                0x2::balance::join<T1>(&mut v10, v17);
            } else {
                assert!(0x2::balance::value<T1>(&v10) >= arg10, 7);
                let v18 = swap_cetus_b_to_a<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v10, arg10));
                v16 = 0x2::balance::value<T0>(&v18);
                0x2::balance::join<T0>(&mut v11, v18);
            };
        };
        let (v19, v20) = centered_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg4), arg11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4));
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg4, v19, v20, arg21);
        let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg4, &mut v21, arg12, arg13, arg0);
        let (v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v22);
        assert!(0x2::balance::value<T0>(&v11) >= v23, 8);
        assert!(0x2::balance::value<T1>(&v10) >= v24, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg3, arg4, 0x2::balance::split<T0>(&mut v11, v23), 0x2::balance::split<T1>(&mut v10, v24), v22);
        let v25 = 0x2::balance::value<T0>(&v11);
        let v26 = 0x2::balance::value<T1>(&v10);
        assert!(v23 >= arg17, 8);
        assert!(v24 >= arg18, 9);
        assert!(v25 <= arg19, 10);
        assert!(v26 <= arg20, 11);
        let v27 = GenericCetusXYRecentered{
            route_id                : 0x2::object::id<GenericCetusXYCap<T0, T1, T2>>(arg2),
            source_pool_id          : v0,
            destination_pool_id     : v0,
            source_position_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg5),
            destination_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v21),
            reward_amounts          : v1,
            reward_sui              : 0x2::balance::value<T2>(&v3),
            fee_x                   : 0x2::balance::value<T0>(&v9),
            fee_y                   : 0x2::balance::value<T1>(&v8),
            profit_sui              : v15,
            source_principal_x      : v12,
            source_principal_y      : v13,
            principal_swap_x_to_y   : arg9,
            principal_swap_input    : arg10,
            principal_swap_output   : v16,
            tick_lower              : v19,
            tick_upper              : v20,
            deposited_x             : v23,
            deposited_y             : v24,
            residual_x              : v25,
            residual_y              : v26,
        };
        0x2::event::emit<GenericCetusXYRecentered>(v27);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v21, 0x2::tx_context::sender(arg21));
        let v28 = 0x2::tx_context::sender(arg21);
        transfer_nonzero<T0>(v11, v28, arg21);
        let v29 = 0x2::tx_context::sender(arg21);
        transfer_nonzero<T1>(v10, v29, arg21);
    }

    public fun register_bluefin_deep_reward_adapter<T0, T1>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = BluefinDeepRewardAdapter<T0, T1>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 3,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<BluefinDeepRewardAdapter<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_bluefin_deep_sui_to_cetus_usdc_sui<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 1,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_bluefin_deep_usdc_portfolio<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = BluefinDeepUsdcPortfolioCap<T0, T1, T2>{
            id               : 0x2::object::new(arg5),
            registry_id      : 0x2::object::id<Registry>(arg0),
            primary_pool_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            farm_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg3),
            sui_usdc_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4),
        };
        let v1 = BluefinDeepUsdcRegistered{
            registry_id      : 0x2::object::id<Registry>(arg0),
            route_id         : 0x2::object::id<BluefinDeepUsdcPortfolioCap<T0, T1, T2>>(&v0),
            primary_pool_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            farm_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg3),
            sui_usdc_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4),
        };
        0x2::event::emit<BluefinDeepUsdcRegistered>(v1);
        0x2::transfer::public_transfer<BluefinDeepUsdcPortfolioCap<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun register_cetus_deep_reward_adapter<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = CetusDeepRewardAdapter<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 4,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<CetusDeepRewardAdapter<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_cetus_reward_to_sui_adapter<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = CetusRewardToSuiAdapter<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 6,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<CetusRewardToSuiAdapter<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_cetus_sui_reward_adapter<T0, T1>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = CetusSuiRewardAdapter<T0, T1>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 5,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<CetusSuiRewardAdapter<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_cetus_usdc_sui_to_bluefin_deep_sui<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        let v1 = AdapterRegistered{
            registry_id  : 0x2::object::id<Registry>(arg0),
            adapter_kind : 2,
        };
        0x2::event::emit<AdapterRegistered>(v1);
        0x2::transfer::public_transfer<CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_generic_cetus_x_sui_0<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        mint_generic_cetus_x_sui_caps<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x1::vector::empty<0x1::type_name::TypeName>(), arg4);
    }

    public fun register_generic_cetus_x_sui_1<T0, T1, T2, T3>(arg0: &Registry, arg1: &AdminCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_original_ids<T3>());
        mint_generic_cetus_x_sui_caps<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun register_generic_cetus_x_sui_2<T0, T1, T2, T3, T4>(arg0: &Registry, arg1: &AdminCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T4>());
        mint_generic_cetus_x_sui_caps<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun register_generic_cetus_x_sui_3<T0, T1, T2, T3, T4, T5>(arg0: &Registry, arg1: &AdminCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T4>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T5>());
        mint_generic_cetus_x_sui_caps<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun register_generic_cetus_x_sui_bluefin_fallback<T0, T1>(arg0: &Registry, arg1: &AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = GenericCetusXSuiBluefinFallbackCap<T0, T1>{
            id                    : 0x2::object::new(arg4),
            registry_id           : 0x2::object::id<Registry>(arg0),
            cetus_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            bluefin_x_sui_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
        };
        let v1 = GenericCetusXSuiBluefinFallbackRegistered{
            registry_id           : 0x2::object::id<Registry>(arg0),
            route_id              : 0x2::object::id<GenericCetusXSuiBluefinFallbackCap<T0, T1>>(&v0),
            cetus_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            bluefin_x_sui_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
        };
        0x2::event::emit<GenericCetusXSuiBluefinFallbackRegistered>(v1);
        0x2::transfer::public_transfer<GenericCetusXSuiBluefinFallbackCap<T0, T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun register_generic_cetus_x_sui_reward_route<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x2::object::id<Registry>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3);
        let v3 = GenericCetusXYRewardRouteCap<T0, T1, T1, T2>{
            id                 : 0x2::object::new(arg4),
            registry_id        : v0,
            cetus_pool_id      : v1,
            reward_sui_pool_id : v2,
        };
        let v4 = GenericCetusXYRewardRegistered{
            registry_id        : v0,
            reward_route_id    : 0x2::object::id<GenericCetusXYRewardRouteCap<T0, T1, T1, T2>>(&v3),
            cetus_pool_id      : v1,
            reward_sui_pool_id : v2,
            direct_sui         : false,
        };
        0x2::event::emit<GenericCetusXYRewardRegistered>(v4);
        0x2::transfer::public_transfer<GenericCetusXYRewardRouteCap<T0, T1, T1, T2>>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun register_generic_cetus_xy<T0, T1, T2, T3>(arg0: &Registry, arg1: &AdminCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg6 <= 3, 13);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>>(arg5);
        assert!(v0 != v1, 12);
        assert!(v0 != v2, 12);
        assert!(v1 != v2, 12);
        let v3 = 0x2::object::id<Registry>(arg0);
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v5 = GenericCetusXYCap<T2, T3, T1>{
            id                    : 0x2::object::new(arg7),
            registry_id           : v3,
            cetus_pool_id         : v0,
            x_sui_pool_id         : v1,
            y_sui_pool_id         : v2,
            expected_reward_count : arg6,
        };
        let v6 = GenericBluefinCetusXYCap<T0, T1, T2, T3>{
            id                    : 0x2::object::new(arg7),
            registry_id           : v3,
            bluefin_pool_id       : v4,
            cetus_pool_id         : v0,
            x_sui_pool_id         : v1,
            y_sui_pool_id         : v2,
            expected_reward_count : arg6,
        };
        let v7 = GenericCetusXYRegistered{
            registry_id           : v3,
            cetus_route_id        : 0x2::object::id<GenericCetusXYCap<T2, T3, T1>>(&v5),
            cross_venue_route_id  : 0x2::object::id<GenericBluefinCetusXYCap<T0, T1, T2, T3>>(&v6),
            cetus_pool_id         : v0,
            x_sui_pool_id         : v1,
            y_sui_pool_id         : v2,
            bluefin_pool_id       : v4,
            expected_reward_count : arg6,
        };
        0x2::event::emit<GenericCetusXYRegistered>(v7);
        0x2::transfer::public_transfer<GenericCetusXYCap<T2, T3, T1>>(v5, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<GenericBluefinCetusXYCap<T0, T1, T2, T3>>(v6, 0x2::tx_context::sender(arg7));
    }

    public fun register_generic_cetus_xy_reward_route<T0, T1, T2, T3>(arg0: &Registry, arg1: &AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x2::object::id<Registry>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3);
        assert!(v1 != v2, 12);
        let v3 = GenericCetusXYRewardRouteCap<T0, T1, T2, T3>{
            id                 : 0x2::object::new(arg4),
            registry_id        : v0,
            cetus_pool_id      : v1,
            reward_sui_pool_id : v2,
        };
        let v4 = GenericCetusXYRewardRegistered{
            registry_id        : v0,
            reward_route_id    : 0x2::object::id<GenericCetusXYRewardRouteCap<T0, T1, T2, T3>>(&v3),
            cetus_pool_id      : v1,
            reward_sui_pool_id : v2,
            direct_sui         : false,
        };
        0x2::event::emit<GenericCetusXYRewardRegistered>(v4);
        0x2::transfer::public_transfer<GenericCetusXYRewardRouteCap<T0, T1, T2, T3>>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun register_generic_cetus_xy_sui_reward<T0, T1, T2>(arg0: &Registry, arg1: &AdminCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = 0x2::object::id<Registry>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        let v2 = GenericCetusXYSuiRewardCap<T0, T1, T2>{
            id            : 0x2::object::new(arg3),
            registry_id   : v0,
            cetus_pool_id : v1,
        };
        let v3 = GenericCetusXYRewardRegistered{
            registry_id        : v0,
            reward_route_id    : 0x2::object::id<GenericCetusXYSuiRewardCap<T0, T1, T2>>(&v2),
            cetus_pool_id      : v1,
            reward_sui_pool_id : v1,
            direct_sui         : true,
        };
        0x2::event::emit<GenericCetusXYRewardRegistered>(v3);
        0x2::transfer::public_transfer<GenericCetusXYSuiRewardCap<T0, T1, T2>>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun rotate_bluefin_deep_sui_to_cetus_usdc_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>, arg3: &BluefinDeepRewardAdapter<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: u64, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1);
        assert_route_bluefin_to_cetus<T0, T1, T2>(arg1, arg2);
        assert_bluefin_deep_reward_adapter<T0, T1>(arg1, arg3);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v1, v2, v3, v4) = close_bluefin_with_fees<T0, T1>(arg0, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg14, 4);
        assert!(v10 >= arg15, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg16, 6);
        0x2::balance::send_funds<T1>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        assert!(0x2::balance::value<T0>(&v8) >= arg9, 7);
        let v13 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T0>(&mut v8, arg9));
        0x2::balance::join<T1>(&mut v7, v13);
        assert!(0x2::balance::value<T1>(&v7) >= arg10, 7);
        let v14 = swap_cetus_b_to_a<T2, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v7, arg10));
        let (v15, v16) = centered_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T1>(arg8), arg11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T1>(arg8));
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T2, T1>(arg7, arg8, v15, v16, arg22);
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T2, T1>(arg7, arg8, &mut v17, arg12, arg13, arg0);
        let (v19, v20) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T2, T1>(&v18);
        assert!(0x2::balance::value<T2>(&v14) >= v19, 8);
        assert!(0x2::balance::value<T1>(&v7) >= v20, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T2, T1>(arg7, arg8, 0x2::balance::split<T2>(&mut v14, v19), 0x2::balance::split<T1>(&mut v7, v20), v18);
        let v21 = 0x2::balance::value<T0>(&v8);
        let v22 = 0x2::balance::value<T2>(&v14);
        let v23 = 0x2::balance::value<T1>(&v7);
        assert!(v19 >= arg17, 8);
        assert!(v20 >= arg18, 9);
        assert!(v21 <= arg19, 10);
        assert!(v22 <= arg20, 10);
        assert!(v23 <= arg21, 11);
        let v24 = BluefinToCetusRotated{
            reward_deep           : 0x2::balance::value<T0>(&v0),
            fee_deep              : 0x2::balance::value<T0>(&v6),
            fee_sui               : 0x2::balance::value<T1>(&v5),
            profit_sui            : v12,
            source_principal_deep : v9,
            source_principal_sui  : v10,
            principal_deep_to_sui : arg9,
            principal_deep_as_sui : 0x2::balance::value<T1>(&v13),
            principal_sui_to_usdc : arg10,
            principal_usdc_out    : 0x2::balance::value<T2>(&v14),
            tick_lower            : v15,
            tick_upper            : v16,
            deposited_usdc        : v19,
            deposited_sui         : v20,
            residual_deep         : v21,
            residual_usdc         : v22,
            residual_sui          : v23,
        };
        0x2::event::emit<BluefinToCetusRotated>(v24);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v17, 0x2::tx_context::sender(arg22));
        let v25 = 0x2::tx_context::sender(arg22);
        transfer_nonzero<T0>(v8, v25, arg22);
        let v26 = 0x2::tx_context::sender(arg22);
        transfer_nonzero<T2>(v14, v26, arg22);
        let v27 = 0x2::tx_context::sender(arg22);
        transfer_nonzero<T1>(v7, v27, arg22);
    }

    public fun rotate_cetus_reward_usdc_sui_to_bluefin_deep_sui<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>, arg3: &CetusRewardToSuiAdapter<T0, T1, T3>, arg4: &CetusSuiRewardAdapter<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg10: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg12: u64, arg13: u64, arg14: u32, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1);
        assert_route_cetus_to_bluefin<T0, T1, T2>(arg1, arg2);
        assert_cetus_reward_to_sui_adapter<T0, T1, T3>(arg1, arg3);
        assert_cetus_sui_reward_adapter<T0, T1>(arg1, arg4);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg5, arg6, &arg7, arg8, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg5, arg6, &arg7, arg8, true, arg0);
        let (v2, v3, v4, v5) = close_cetus_with_fees<T0, T1>(arg0, arg5, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg17, 4);
        assert!(v11 >= arg18, 5);
        let v12 = swap_cetus_a_to_b<T3, T1>(arg0, arg5, arg9, v0);
        let v13 = swap_cetus_a_to_b<T0, T1>(arg0, arg5, arg6, v7);
        0x2::balance::join<T1>(&mut v1, v12);
        0x2::balance::join<T1>(&mut v1, v6);
        0x2::balance::join<T1>(&mut v1, v13);
        let v14 = 0x2::balance::value<T1>(&v1);
        assert!(v14 >= arg19, 6);
        0x2::balance::send_funds<T1>(v1, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        assert!(0x2::balance::value<T0>(&v9) >= arg12, 7);
        let v15 = swap_cetus_a_to_b<T0, T1>(arg0, arg5, arg6, 0x2::balance::split<T0>(&mut v9, arg12));
        0x2::balance::join<T1>(&mut v8, v15);
        assert!(0x2::balance::value<T1>(&v8) >= arg13, 7);
        let v16 = swap_bluefin_b_to_a<T2, T1>(arg0, arg10, arg11, 0x2::balance::split<T1>(&mut v8, arg13));
        let (v17, v18) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T2, T1>(arg11), arg14, 1);
        let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T2, T1>(arg10, arg11, v17, v18, arg25);
        let (v20, v21, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T2, T1>(arg0, arg10, arg11, &mut v19, v16, v8, arg15, arg16);
        let v24 = v22;
        v8 = v23;
        let v25 = 0x2::balance::value<T0>(&v9);
        let v26 = 0x2::balance::value<T2>(&v24);
        let v27 = 0x2::balance::value<T1>(&v8);
        assert!(v20 >= arg20, 8);
        assert!(v21 >= arg21, 9);
        assert!(v25 <= arg22, 10);
        assert!(v26 <= arg23, 10);
        assert!(v27 <= arg24, 11);
        let v28 = CetusRewardToBluefinRotated{
            reward_amount         : 0x2::balance::value<T3>(&v0),
            reward_sui            : 0x2::balance::value<T1>(&v1) + 0x2::balance::value<T1>(&v12),
            fee_usdc              : 0x2::balance::value<T0>(&v7),
            fee_sui               : 0x2::balance::value<T1>(&v6),
            profit_sui            : v14,
            source_principal_usdc : v10,
            source_principal_sui  : v11,
            principal_usdc_to_sui : arg12,
            principal_usdc_as_sui : 0x2::balance::value<T1>(&v15),
            principal_sui_to_deep : arg13,
            principal_deep_out    : 0x2::balance::value<T2>(&v16),
            tick_lower            : v17,
            tick_upper            : v18,
            deposited_deep        : v20,
            deposited_sui         : v21,
            residual_usdc         : v25,
            residual_deep         : v26,
            residual_sui          : v27,
        };
        0x2::event::emit<CetusRewardToBluefinRotated>(v28);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg25));
        let v29 = 0x2::tx_context::sender(arg25);
        transfer_nonzero<T0>(v9, v29, arg25);
        let v30 = 0x2::tx_context::sender(arg25);
        transfer_nonzero<T2>(v24, v30, arg25);
        let v31 = 0x2::tx_context::sender(arg25);
        transfer_nonzero<T1>(v8, v31, arg25);
    }

    public fun rotate_cetus_usdc_sui_to_bluefin_deep_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &CetusUsdcSuiToBluefinDeepSuiCap<T0, T1, T2>, arg3: &CetusDeepRewardAdapter<T0, T1, T2>, arg4: &CetusSuiRewardAdapter<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg11: u64, arg12: u64, arg13: u32, arg14: u64, arg15: bool, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1);
        assert_route_cetus_to_bluefin<T0, T1, T2>(arg1, arg2);
        assert_cetus_deep_reward_adapter<T0, T1, T2>(arg1, arg3);
        assert_cetus_sui_reward_adapter<T0, T1>(arg1, arg4);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg5, arg6, &arg7, arg8, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg5, arg6, &arg7, arg8, true, arg0);
        let (v2, v3, v4, v5) = close_cetus_with_fees<T0, T1>(arg0, arg5, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg16, 4);
        assert!(v11 >= arg17, 5);
        let v12 = swap_bluefin_a_to_b<T2, T1>(arg0, arg9, arg10, v0);
        let v13 = swap_cetus_a_to_b<T0, T1>(arg0, arg5, arg6, v7);
        0x2::balance::join<T1>(&mut v1, v12);
        0x2::balance::join<T1>(&mut v1, v6);
        0x2::balance::join<T1>(&mut v1, v13);
        let v14 = 0x2::balance::value<T1>(&v1);
        assert!(v14 >= arg18, 6);
        0x2::balance::send_funds<T1>(v1, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        assert!(0x2::balance::value<T0>(&v9) >= arg11, 7);
        let v15 = swap_cetus_a_to_b<T0, T1>(arg0, arg5, arg6, 0x2::balance::split<T0>(&mut v9, arg11));
        0x2::balance::join<T1>(&mut v8, v15);
        assert!(0x2::balance::value<T1>(&v8) >= arg12, 7);
        let v16 = swap_bluefin_b_to_a<T2, T1>(arg0, arg9, arg10, 0x2::balance::split<T1>(&mut v8, arg12));
        let (v17, v18) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T2, T1>(arg10), arg13, 1);
        let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T2, T1>(arg9, arg10, v17, v18, arg24);
        let (v20, v21, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T2, T1>(arg0, arg9, arg10, &mut v19, v16, v8, arg14, arg15);
        let v24 = v22;
        v8 = v23;
        let v25 = 0x2::balance::value<T0>(&v9);
        let v26 = 0x2::balance::value<T2>(&v24);
        let v27 = 0x2::balance::value<T1>(&v8);
        assert!(v20 >= arg19, 8);
        assert!(v21 >= arg20, 9);
        assert!(v25 <= arg21, 10);
        assert!(v26 <= arg22, 10);
        assert!(v27 <= arg23, 11);
        let v28 = CetusToBluefinRotated{
            reward_deep           : 0x2::balance::value<T2>(&v0),
            reward_sui            : 0x2::balance::value<T1>(&v1),
            fee_usdc              : 0x2::balance::value<T0>(&v7),
            fee_sui               : 0x2::balance::value<T1>(&v6),
            profit_sui            : v14,
            source_principal_usdc : v10,
            source_principal_sui  : v11,
            principal_usdc_to_sui : arg11,
            principal_usdc_as_sui : 0x2::balance::value<T1>(&v15),
            principal_sui_to_deep : arg12,
            principal_deep_out    : 0x2::balance::value<T2>(&v16),
            tick_lower            : v17,
            tick_upper            : v18,
            deposited_deep        : v20,
            deposited_sui         : v21,
            residual_usdc         : v25,
            residual_deep         : v26,
            residual_sui          : v27,
        };
        0x2::event::emit<CetusToBluefinRotated>(v28);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg24));
        let v29 = 0x2::tx_context::sender(arg24);
        transfer_nonzero<T0>(v9, v29, arg24);
        let v30 = 0x2::tx_context::sender(arg24);
        transfer_nonzero<T2>(v24, v30, arg24);
        let v31 = 0x2::tx_context::sender(arg24);
        transfer_nonzero<T1>(v8, v31, arg24);
    }

    public fun split_bluefin_deep_sui_and_deep_blue<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &AdminCap, arg3: &BluefinDeepRewardAdapter<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: bool, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1);
        assert_admin(arg1, arg2);
        assert_bluefin_deep_reward_adapter<T0, T1>(arg1, arg3);
        assert!(arg11 > 0 && arg12 > 0, 3);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v1, v2, v3, v4) = close_bluefin_with_fees<T0, T1>(arg0, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg19, 4);
        assert!(v10 >= arg20, 5);
        assert!(v9 >= arg8, 7);
        assert!(v10 >= arg9, 7);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg21, 6);
        0x2::balance::send_funds<T1>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        let v13 = 0x2::balance::split<T0>(&mut v8, arg8);
        let v14 = swap_bluefin_b_to_a<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T1>(&mut v7, arg9));
        0x2::balance::join<T0>(&mut v13, v14);
        assert!(0x2::balance::value<T0>(&v13) >= arg10, 7);
        let v15 = swap_bluefin_a_to_b<T0, T2>(arg0, arg4, arg7, 0x2::balance::split<T0>(&mut v13, arg10));
        let v16 = 0;
        if (arg14 > 0) {
            if (arg13) {
                assert!(0x2::balance::value<T0>(&v8) >= arg14, 7);
                let v17 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T0>(&mut v8, arg14));
                v16 = 0x2::balance::value<T1>(&v17);
                0x2::balance::join<T1>(&mut v7, v17);
            } else {
                assert!(0x2::balance::value<T1>(&v7) >= arg14, 7);
                let v18 = swap_bluefin_b_to_a<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T1>(&mut v7, arg14));
                v16 = 0x2::balance::value<T0>(&v18);
                0x2::balance::join<T0>(&mut v8, v18);
            };
        };
        let (v19, v20) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg11, 1);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v19, v20, arg29);
        let (v22, v23, v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v21, v8, v7, arg15, arg16);
        let v26 = v25;
        let (v27, v28) = active_spacing_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg7), arg12);
        let v29 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T2>(arg4, arg7, v27, v28, arg29);
        let (v30, v31, v32, v33) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg4, arg7, &mut v29, v13, v15, arg17, arg18);
        let v34 = v33;
        let v35 = v24;
        0x2::balance::join<T0>(&mut v35, v32);
        let v36 = 0x2::balance::value<T0>(&v35);
        let v37 = 0x2::balance::value<T1>(&v26);
        let v38 = 0x2::balance::value<T2>(&v34);
        assert!(v22 >= arg22, 8);
        assert!(v23 >= arg23, 9);
        assert!(v30 >= arg24, 8);
        assert!(v31 >= arg25, 9);
        assert!(v36 <= arg26, 10);
        assert!(v37 <= arg27, 11);
        assert!(v38 <= arg28, 11);
        let v39 = DualBluefinPortfolioOpened{
            reward_deep              : 0x2::balance::value<T0>(&v0),
            fee_deep                 : 0x2::balance::value<T0>(&v6),
            fee_sui                  : 0x2::balance::value<T1>(&v5),
            profit_sui               : v12,
            source_principal_deep    : v9,
            source_principal_sui     : v10,
            secondary_principal_deep : arg8,
            secondary_principal_sui  : arg9,
            secondary_sui_as_deep    : 0x2::balance::value<T0>(&v14),
            secondary_deep_to_blue   : arg10,
            secondary_blue_out       : 0x2::balance::value<T2>(&v15),
            primary_swap_deep_to_sui : arg13,
            primary_swap_input       : arg14,
            primary_swap_output      : v16,
            primary_tick_lower       : v19,
            primary_tick_upper       : v20,
            secondary_tick_lower     : v27,
            secondary_tick_upper     : v28,
            primary_deposited_deep   : v22,
            primary_deposited_sui    : v23,
            secondary_deposited_deep : v30,
            secondary_deposited_blue : v31,
            primary_liquidity        : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v21),
            secondary_liquidity      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v29),
            residual_deep            : v36,
            residual_sui             : v37,
            residual_blue            : v38,
        };
        0x2::event::emit<DualBluefinPortfolioOpened>(v39);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg29));
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v29, 0x2::tx_context::sender(arg29));
        let v40 = 0x2::tx_context::sender(arg29);
        transfer_nonzero<T0>(v35, v40, arg29);
        let v41 = 0x2::tx_context::sender(arg29);
        transfer_nonzero<T1>(v26, v41, arg29);
        let v42 = 0x2::tx_context::sender(arg29);
        transfer_nonzero<T2>(v34, v42, arg29);
    }

    public fun split_bluefin_deep_sui_with_cetus_usdc_sui<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &Registry, arg2: &BluefinDeepSuiToCetusUsdcSuiCap<T0, T1, T2>, arg3: &BluefinDeepRewardAdapter<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: u64, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: &mut 0x2::tx_context::TxContext) {
        assert_registry(arg1);
        assert_route_bluefin_to_cetus<T0, T1, T2>(arg1, arg2);
        assert_bluefin_deep_reward_adapter<T0, T1>(arg1, arg3);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v1, v2, v3, v4) = close_bluefin_with_fees<T0, T1>(arg0, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg17, 4);
        assert!(v10 >= arg18, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg19, 6);
        0x2::balance::send_funds<T1>(v11, @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292);
        assert!(v9 >= arg9, 7);
        assert!(v10 >= arg10, 7);
        let v13 = swap_bluefin_a_to_b<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T0>(&mut v8, arg9));
        0x2::balance::join<T1>(&mut v13, 0x2::balance::split<T1>(&mut v7, arg10));
        assert!(0x2::balance::value<T1>(&v13) >= arg11, 7);
        let v14 = swap_cetus_b_to_a<T2, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v13, arg11));
        let (v15, v16) = centered_range(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg12, 1);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v15, v16, arg27);
        let (v18, v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v17, v8, v7, arg13, arg14);
        v8 = v20;
        v7 = v21;
        let (v22, v23) = active_spacing_range(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T1>(arg8), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T1>(arg8));
        let v24 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T2, T1>(arg7, arg8, v22, v23, arg27);
        let v25 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T2, T1>(arg7, arg8, &mut v24, arg15, arg16, arg0);
        let (v26, v27) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T2, T1>(&v25);
        assert!(0x2::balance::value<T2>(&v14) >= v26, 8);
        assert!(0x2::balance::value<T1>(&v13) >= v27, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T2, T1>(arg7, arg8, 0x2::balance::split<T2>(&mut v14, v26), 0x2::balance::split<T1>(&mut v13, v27), v25);
        let v28 = 0x2::balance::value<T0>(&v8);
        let v29 = 0x2::balance::value<T2>(&v14);
        let v30 = 0x2::balance::value<T1>(&v7) + 0x2::balance::value<T1>(&v13);
        assert!(v18 >= arg20, 8);
        assert!(v19 >= arg21, 9);
        assert!(v26 >= arg22, 8);
        assert!(v27 >= arg23, 9);
        assert!(v28 <= arg24, 10);
        assert!(v29 <= arg25, 10);
        assert!(v30 <= arg26, 11);
        let v31 = BluefinCetusPortfolioOpenedV2{
            reward_deep            : 0x2::balance::value<T0>(&v0),
            fee_deep               : 0x2::balance::value<T0>(&v6),
            fee_sui                : 0x2::balance::value<T1>(&v5),
            profit_sui             : v12,
            source_principal_deep  : v9,
            source_principal_sui   : v10,
            cetus_principal_deep   : arg9,
            cetus_principal_sui    : arg10,
            cetus_deep_as_sui      : 0x2::balance::value<T1>(&v13),
            cetus_sui_to_usdc      : arg11,
            cetus_usdc_out         : 0x2::balance::value<T2>(&v14),
            bluefin_tick_lower     : v15,
            bluefin_tick_upper     : v16,
            cetus_tick_lower       : v22,
            cetus_tick_upper       : v23,
            bluefin_deposited_deep : v18,
            bluefin_deposited_sui  : v19,
            cetus_deposited_usdc   : v26,
            cetus_deposited_sui    : v27,
            bluefin_liquidity      : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v17),
            cetus_liquidity        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v24),
            residual_deep          : v28,
            residual_usdc          : v29,
            residual_sui           : v30,
        };
        0x2::event::emit<BluefinCetusPortfolioOpenedV2>(v31);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v17, 0x2::tx_context::sender(arg27));
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v24, 0x2::tx_context::sender(arg27));
        0x2::balance::join<T1>(&mut v7, v13);
        let v32 = 0x2::tx_context::sender(arg27);
        transfer_nonzero<T0>(v8, v32, arg27);
        let v33 = 0x2::tx_context::sender(arg27);
        transfer_nonzero<T2>(v14, v33, arg27);
        let v34 = 0x2::tx_context::sender(arg27);
        transfer_nonzero<T1>(v7, v34, arg27);
    }

    fun swap_bluefin_a_to_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            0x2::balance::zero<T1>()
        } else {
            let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, v0, 4295048017 + 1);
            0x2::balance::join<T0>(&mut arg3, v2);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
            v3
        }
    }

    fun swap_bluefin_b_to_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            0x2::balance::zero<T0>()
        } else {
            let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, v0, 79226673515401279992447579055 - 1);
            0x2::balance::join<T1>(&mut arg3, v3);
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
            v2
        }
    }

    fun swap_cetus_a_to_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            0x2::balance::zero<T1>()
        } else {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, true, true, v0, 4295048017 + 1, arg0);
            0x2::balance::join<T0>(&mut arg3, v2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, arg3, 0x2::balance::zero<T1>(), v4);
            v3
        }
    }

    fun swap_cetus_b_to_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T1>(&arg3);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            0x2::balance::zero<T0>()
        } else {
            let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, true, v0, 79226673515401279992447579055 - 1, arg0);
            0x2::balance::join<T1>(&mut arg3, v3);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), arg3, v4);
            v2
        }
    }

    fun transfer_nonzero<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

