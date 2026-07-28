module 0x83fd84081a3b0defa67e712991fd46927ded832a226daa8ca5de336f028cf5f5::m_j74zfwk4x2 {
    struct T_mxfoob7xa4 has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct T_gc6rj26lvo has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_crf2gz6ikb<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_ony7fldlkz<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_ffbhaz5mux<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_3wk4gy3ybf<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_wq752b2wj2<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_yd6dm5rbzl<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct T_rypypwh3yl<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        primary_pool_id: 0x2::object::ID,
        farm_pool_id: 0x2::object::ID,
        sui_usdc_pool_id: 0x2::object::ID,
    }

    struct T_egfxhjnl23<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        x_sui_pool_id: 0x2::object::ID,
        y_sui_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
    }

    struct T_ooc7i2sp27<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        bluefin_position_id: 0x2::object::ID,
        owner_authority: address,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct T_cyke2d2qxe<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        owner_authority: address,
    }

    struct T_pnb4cyyddi<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        bluefin_position_id: 0x2::object::ID,
        owner_authority: address,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct T_nm3mwh55xe<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        source_bluefin_pool_id: 0x2::object::ID,
        target_bluefin_pool_id: 0x2::object::ID,
        owner_authority: address,
        target_tick_spacing: u32,
        allowed_cetus_pool_ids: vector<0x2::object::ID>,
    }

    struct T_jqabux35vc<phantom T0, phantom T1, phantom T2, phantom T3, phantom T4, phantom T5> {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_bluefin_pool_id: 0x2::object::ID,
        target_bluefin_pool_id: 0x2::object::ID,
        owner_authority: address,
        source_managed_cap_id: 0x2::object::ID,
        source_allocation_cap_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        source_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
        supplied_principal_a: u64,
        supplied_principal_b: u64,
        total_principal_a: u64,
        total_principal_b: u64,
        authenticated_cetus_pool_ids: vector<0x2::object::ID>,
    }

    struct T_gexrfk364t<phantom T0, phantom T1> {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        owner_authority: address,
        source_allocation_cap_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        source_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        income_deep: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        supplied_principal_deep: u64,
        supplied_principal_sui: u64,
        principal_deep_before_swap: u64,
        principal_sui_before_swap: u64,
    }

    struct T_firwujlzgn<phantom T0, phantom T1, phantom T2, phantom T3> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        x_sui_pool_id: 0x2::object::ID,
        y_sui_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
    }

    struct T_jf5gusnm2a<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
        expected_reward_types: vector<0x1::type_name::TypeName>,
    }

    struct T_mxzfe3z2ef<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        bluefin_x_sui_pool_id: 0x2::object::ID,
    }

    struct T_xm5f56dnqx<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
        expected_reward_types: vector<0x1::type_name::TypeName>,
    }

    struct T_6q63tjexs3<phantom T0, phantom T1, phantom T2, phantom T3> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        reward_sui_pool_id: 0x2::object::ID,
    }

    struct T_ubv6jvfaql<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
    }

    struct T_b2qzkyfcoy<phantom T0> {
        source_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_count: u8,
        expected_reward_count: u8,
        reward_types: vector<0x1::type_name::TypeName>,
        reward_amounts: vector<u64>,
        reward_sui: 0x2::balance::Balance<T0>,
    }

    struct T_qyii7utb72 has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        profit_recipient: address,
    }

    struct T_pg3wrruijq has copy, drop {
        registry_id: 0x2::object::ID,
        adapter_kind: u8,
    }

    struct T_snlr6qndrx has copy, drop {
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

    struct T_3rv4mbcnwu has copy, drop {
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

    struct T_bfzf3klfie has copy, drop {
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

    struct T_3ppapdtrov has copy, drop {
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

    struct T_cvwku25yiz has copy, drop {
        reward_x: u64,
        reward_sui: u64,
        reward_external: u64,
        external_as_sui: u64,
        profit_sui: u64,
    }

    struct T_ytvkmwpm56 has copy, drop {
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

    struct T_rns7moamu6 has copy, drop {
        registry_id: 0x2::object::ID,
        cetus_route_id: 0x2::object::ID,
        cross_venue_route_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        x_sui_pool_id: 0x2::object::ID,
        y_sui_pool_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
    }

    struct T_42oy2hnj7u has copy, drop {
        registry_id: 0x2::object::ID,
        reward_route_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        reward_sui_pool_id: 0x2::object::ID,
        direct_sui: bool,
    }

    struct T_u4lbmw6naw has copy, drop {
        registry_id: 0x2::object::ID,
        cetus_route_id: 0x2::object::ID,
        cross_venue_route_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        expected_reward_count: u8,
    }

    struct T_neomuo6i3a has copy, drop {
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

    struct T_fmfrdcdr5i has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_amounts: vector<u64>,
        reward_sui: u64,
        fee_x: u64,
        fee_sui: u64,
        profit_sui: u64,
    }

    struct T_ffxknvwuk2 has copy, drop {
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

    struct T_ezf5bhou6h has copy, drop {
        route_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        input_sui: u64,
        sui_to_x: u64,
        x_out: u64,
        deposited_x: u64,
        deposited_sui: u64,
        residual_x: u64,
        residual_sui: u64,
    }

    struct T_wpgurru6oy has copy, drop {
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

    struct T_4p4xrvbftx has copy, drop {
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

    struct T_4zjtv5aucr has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_amounts: vector<u64>,
        reward_sui: u64,
        fee_x: u64,
        fee_y: u64,
        profit_sui: u64,
    }

    struct T_ggnn4cyo76 has copy, drop {
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

    struct T_khgkiuh77r has copy, drop {
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

    struct T_vfgcikdmyu has copy, drop {
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

    struct T_rr5a36qqwe has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        bluefin_x_sui_pool_id: 0x2::object::ID,
    }

    struct T_6wj7wkz3ts has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        primary_pool_id: 0x2::object::ID,
        farm_pool_id: 0x2::object::ID,
        sui_usdc_pool_id: 0x2::object::ID,
    }

    struct T_njqc6cqy4v has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        bluefin_position_id: 0x2::object::ID,
        owner_authority: address,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct T_6zt2xaixlo has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        owner_authority: address,
    }

    struct T_ubatmpwltf has copy, drop {
        registry_id: 0x2::object::ID,
        managed_cap_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        bluefin_position_id: 0x2::object::ID,
        owner_authority: address,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct T_eatvlkc6ni has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_bluefin_pool_id: 0x2::object::ID,
        target_bluefin_pool_id: 0x2::object::ID,
        owner_authority: address,
        target_tick_spacing: u32,
        allowed_cetus_pool_ids: vector<0x2::object::ID>,
    }

    struct T_lh5ool3awd has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_managed_cap_id: 0x2::object::ID,
        source_allocation_cap_id: 0x2::object::ID,
        source_bluefin_pool_id: 0x2::object::ID,
        target_bluefin_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        owner_authority: address,
        source_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
        supplied_principal_a: u64,
        supplied_principal_b: u64,
        total_principal_a: u64,
        total_principal_b: u64,
    }

    struct T_3mj2kxfbqq has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_managed_cap_id: 0x2::object::ID,
        source_allocation_cap_id: 0x2::object::ID,
        replacement_managed_cap_id: 0x2::object::ID,
        replacement_allocation_cap_id: 0x2::object::ID,
        source_bluefin_pool_id: 0x2::object::ID,
        target_bluefin_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        target_position_id: 0x2::object::ID,
        owner_authority: address,
        authenticated_cetus_pool_ids: vector<0x2::object::ID>,
        source_liquidity: u128,
        replacement_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        target_tick_lower: u32,
        target_tick_upper: u32,
        reward_amount: u64,
        fee_a: u64,
        fee_b: u64,
        source_principal_a: u64,
        source_principal_b: u64,
        supplied_principal_a: u64,
        supplied_principal_b: u64,
        target_balance_a: u64,
        target_balance_b: u64,
        deposited_a: u64,
        deposited_b: u64,
        residual_a: u64,
        residual_b: u64,
        income_sui: u64,
    }

    struct T_nmzuqxolwi has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_allocation_cap_id: 0x2::object::ID,
        replacement_allocation_cap_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        owner_authority: address,
        source_liquidity: u128,
        replacement_liquidity: u128,
        source_tick_lower: u32,
        source_tick_upper: u32,
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        income_deep_input: u64,
        income_deep_as_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        supplied_principal_deep: u64,
        supplied_principal_sui: u64,
        principal_swap_deep_to_sui: bool,
        principal_swap_input: u64,
        principal_swap_output: u64,
        tick_lower: u32,
        tick_upper: u32,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct T_mz37rife4q has copy, drop {
        registry_id: 0x2::object::ID,
        route_id: 0x2::object::ID,
        source_cap_id: 0x2::object::ID,
        replacement_cap_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        replacement_position_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        owner_authority: address,
        source_tick_lower: u32,
        source_tick_upper: u32,
        replacement_tick_lower: u32,
        replacement_tick_upper: u32,
    }

    struct T_aupl55qkhu has copy, drop {
        route_id: 0x2::object::ID,
        source_pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        liquidity_before: u128,
        liquidity_delta: u128,
        liquidity_after: u128,
        output_deep: u64,
        output_sui: u64,
    }

    struct T_omweb27yyd has copy, drop {
        route_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity_before: u128,
        liquidity_after: u128,
        deposited_deep: u64,
        deposited_sui: u64,
        residual_deep: u64,
        residual_sui: u64,
    }

    struct T_dcdkys6rqi has copy, drop {
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

    struct T_7jtx2pvic5 has copy, drop {
        route_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_usdc: u64,
        profit_sui: u64,
    }

    struct T_3avwk6jpa2 has copy, drop {
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_usdc: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_usdc: u64,
        input_sui: u64,
        normalized_principal_sui: u64,
        sui_to_deep: u64,
        deep_out: u64,
        sui_to_usdc: u64,
        usdc_out: u64,
        deposited_deep: u64,
        deposited_usdc: u64,
        residual_deep: u64,
        residual_sui: u64,
        residual_usdc: u64,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct T_fkvklvwuxs has copy, drop {
        route_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        input_sui: u64,
        sui_to_deep: u64,
        deep_out: u64,
        sui_to_usdc: u64,
        usdc_out: u64,
        deposited_deep: u64,
        deposited_usdc: u64,
        residual_deep: u64,
        residual_sui: u64,
        residual_usdc: u64,
    }

    struct T_3kz5nkps3l has copy, drop {
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_sui: u64,
        profit_sui: u64,
        source_principal_deep: u64,
        source_principal_sui: u64,
        principal_sui_to_usdc: u64,
        principal_usdc_out: u64,
        swap_deep_to_usdc: bool,
        swap_input: u64,
        swap_output: u64,
        deposited_deep: u64,
        deposited_usdc: u64,
        residual_deep: u64,
        residual_sui: u64,
        residual_usdc: u64,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct T_4vpin3vzge has copy, drop {
        route_id: 0x2::object::ID,
        source_kai_position_id: 0x2::object::ID,
        destination_position_id: 0x2::object::ID,
        input_deep: u64,
        input_sui: u64,
        principal_sui_to_usdc: u64,
        principal_usdc_out: u64,
        swap_deep_to_usdc: bool,
        swap_input: u64,
        swap_output: u64,
        deposited_deep: u64,
        deposited_usdc: u64,
        residual_deep: u64,
        residual_sui: u64,
        residual_usdc: u64,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct T_j5ce66psm4 has copy, drop {
        route_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        reward_deep: u64,
        fee_deep: u64,
        fee_usdc: u64,
        source_principal_deep: u64,
        source_principal_usdc: u64,
        output_deep: u64,
        output_sui: u64,
    }

    struct T_gpm75ke2wc has copy, drop {
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

    struct T_zhpqctcqfm has copy, drop {
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

    struct T_mlujnkc2ww has copy, drop {
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

    public fun f_2agkzmzso3<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        assert!(arg1.expected_reward_count == 1, 13);
        f_nrbwjbbixy<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun f_2clmukbnmg<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        f_73sxgdbci3<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x1::vector::empty<0x1::type_name::TypeName>(), arg4);
    }

    public fun f_2la2ujw2u7<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_gc6rj26lvo, arg3: &T_ffbhaz5mux<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: bool, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: &mut 0x2::tx_context::TxContext) {
        f_544rze3u32(arg1);
        f_zyotjhy6mn(arg1, arg2);
        f_wzox2mblzz<T0, T1>(arg1, arg3);
        assert!(arg11 > 0 && arg12 > 0, 3);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T1>(arg0, arg4, arg5, arg6);
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
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg21, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v13 = 0x2::balance::split<T0>(&mut v8, arg8);
        let v14 = f_c4ffbqp2ie<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T1>(&mut v7, arg9));
        0x2::balance::join<T0>(&mut v13, v14);
        assert!(0x2::balance::value<T0>(&v13) >= arg10, 7);
        let v15 = f_bu4nlbma3l<T0, T2>(arg0, arg4, arg7, 0x2::balance::split<T0>(&mut v13, arg10));
        let v16 = 0;
        if (arg14 > 0) {
            if (arg13) {
                assert!(0x2::balance::value<T0>(&v8) >= arg14, 7);
                let v17 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T0>(&mut v8, arg14));
                v16 = 0x2::balance::value<T1>(&v17);
                0x2::balance::join<T1>(&mut v7, v17);
            } else {
                assert!(0x2::balance::value<T1>(&v7) >= arg14, 7);
                let v18 = f_c4ffbqp2ie<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T1>(&mut v7, arg14));
                v16 = 0x2::balance::value<T0>(&v18);
                0x2::balance::join<T0>(&mut v8, v18);
            };
        };
        let (v19, v20) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg11, 1);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v19, v20, arg29);
        let (v22, v23, v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v21, v8, v7, arg15, arg16);
        let v26 = v25;
        let (v27, v28) = f_pzzwrq6ooc(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg7), arg12);
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
        let v39 = T_3ppapdtrov{
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
        0x2::event::emit<T_3ppapdtrov>(v39);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg29));
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v29, 0x2::tx_context::sender(arg29));
        let v40 = 0x2::tx_context::sender(arg29);
        f_jk6cxnkjme<T0>(v35, v40, arg29);
        let v41 = 0x2::tx_context::sender(arg29);
        f_jk6cxnkjme<T1>(v26, v41, arg29);
        let v42 = 0x2::tx_context::sender(arg29);
        f_jk6cxnkjme<T2>(v34, v42, arg29);
    }

    public fun f_2zfwuj6kmw<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_jf5gusnm2a<T0, T1>, arg3: &T_mxzfe3z2ef<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: T_b2qzkyfcoy<T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: u64) {
        f_yq55f2eibc<T0, T1>(arg1, arg2, arg5);
        f_acy22dxebs<T0, T1>(arg1, arg3, arg5, arg9);
        f_h76ndz3c44<T1>(&arg7, &arg2.expected_reward_types);
        let (v0, v1) = f_55o2ioxfmc<T0, T1, T1>(arg5, arg6, arg7);
        let v2 = v1;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg4, arg5, arg6, true);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::join<T1>(&mut v2, f_bu4nlbma3l<T0, T1>(arg0, arg8, arg9, v6));
        0x2::balance::join<T1>(&mut v2, v5);
        let v7 = 0x2::balance::value<T1>(&v2);
        assert!(v7 >= arg10, 6);
        let v8 = T_fmfrdcdr5i{
            route_id       : 0x2::object::id<T_jf5gusnm2a<T0, T1>>(arg2),
            source_pool_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5),
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg6),
            reward_amounts : v0,
            reward_sui     : 0x2::balance::value<T1>(&v2),
            fee_x          : 0x2::balance::value<T0>(&v6),
            fee_sui        : 0x2::balance::value<T1>(&v5),
            profit_sui     : v7,
        };
        0x2::event::emit<T_fmfrdcdr5i>(v8);
        0x2::balance::send_funds<T1>(v2, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
    }

    public fun f_32hlbrrkxx<T0, T1, T2, T3>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        assert!(arg6 <= 3, 13);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>>(arg5);
        assert!(v0 != v1, 12);
        assert!(v0 != v2, 12);
        assert!(v1 != v2, 12);
        let v3 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v5 = T_egfxhjnl23<T2, T3, T1>{
            id                    : 0x2::object::new(arg7),
            registry_id           : v3,
            cetus_pool_id         : v0,
            x_sui_pool_id         : v1,
            y_sui_pool_id         : v2,
            expected_reward_count : arg6,
        };
        let v6 = T_firwujlzgn<T0, T1, T2, T3>{
            id                    : 0x2::object::new(arg7),
            registry_id           : v3,
            bluefin_pool_id       : v4,
            cetus_pool_id         : v0,
            x_sui_pool_id         : v1,
            y_sui_pool_id         : v2,
            expected_reward_count : arg6,
        };
        let v7 = T_rns7moamu6{
            registry_id           : v3,
            cetus_route_id        : 0x2::object::id<T_egfxhjnl23<T2, T3, T1>>(&v5),
            cross_venue_route_id  : 0x2::object::id<T_firwujlzgn<T0, T1, T2, T3>>(&v6),
            cetus_pool_id         : v0,
            x_sui_pool_id         : v1,
            y_sui_pool_id         : v2,
            bluefin_pool_id       : v4,
            expected_reward_count : arg6,
        };
        0x2::event::emit<T_rns7moamu6>(v7);
        0x2::transfer::public_transfer<T_egfxhjnl23<T2, T3, T1>>(v5, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<T_firwujlzgn<T0, T1, T2, T3>>(v6, 0x2::tx_context::sender(arg7));
    }

    fun f_34gg3zt5u2<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_yd6dm5rbzl<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
    }

    fun f_3juarfjuea<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_crf2gz6ikb<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
    }

    fun f_3tscjyxrml<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_egfxhjnl23<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        f_ri5xyeurpi<T0, T1, T2>(arg0, arg1, arg2);
        assert!(arg1.x_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg3), 12);
        assert!(arg1.y_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg4), 12);
    }

    public fun f_45hyat575c<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_cyke2d2qxe<T0, T1>, arg3: T_gexrfk364t<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x2::balance::Balance<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: u32, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) {
        f_nf63pwnxpm<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, arg9, arg10, arg11, arg12, 0, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, false, arg21);
    }

    public fun f_522gnhkn2p<T0, T1, T2, T3>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_original_ids<T3>());
        f_73sxgdbci3<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun f_544ngyxjy3<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        assert!(arg1.expected_reward_count == 3, 13);
        f_nrbwjbbixy<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun f_544rze3u32(arg0: &T_mxfoob7xa4) {
        assert!(arg0.profit_recipient == @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, 2);
    }

    fun f_55o2ioxfmc<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: T_b2qzkyfcoy<T2>) : (vector<u64>, 0x2::balance::Balance<T2>) {
        f_femq3j54qj<T0, T1, T2>(arg0, arg1, &arg2);
        assert!(arg2.reward_count == arg2.expected_reward_count, 13);
        let T_b2qzkyfcoy {
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

    fun f_5fdzll7c7q<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u32, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, &mut arg7);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T2>(arg0, arg3, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T2>(&v7);
        assert!(v9 >= arg12, 4);
        assert!(v10 >= arg13, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, v6);
        let v12 = f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, v5);
        0x2::balance::join<T1>(&mut v11, v12);
        let v13 = 0x2::balance::value<T1>(&v11);
        assert!(v13 >= arg14, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v14 = f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, v7);
        let v15 = 0x2::balance::value<T1>(&v14);
        if (arg8 > 0) {
            assert!(0x2::balance::value<T0>(&v8) >= arg8, 7);
            let v16 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v8, arg8));
            0x2::balance::join<T1>(&mut v14, v16);
        };
        let (v17, v18) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), arg9, 1);
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
        let v26 = T_zhpqctcqfm{
            route_id                : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
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
        0x2::event::emit<T_zhpqctcqfm>(v26);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg19));
        let v27 = 0x2::tx_context::sender(arg19);
        f_jk6cxnkjme<T0>(v8, v27, arg19);
        let v28 = 0x2::tx_context::sender(arg19);
        f_jk6cxnkjme<T1>(v14, v28, arg19);
    }

    public fun f_5gdxwl6opl<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_xm5f56dnqx<T0, T1, T2>, arg3: &T_mxzfe3z2ef<T2, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg6: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: T_b2qzkyfcoy<T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        f_r6xm6lybcg<T0, T1, T2>(arg1, arg2, arg10, arg5);
        f_acy22dxebs<T2, T1>(arg1, arg3, arg5, arg9);
        f_h76ndz3c44<T1>(&arg7, &arg2.expected_reward_types);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg5);
        let (v1, v2) = f_55o2ioxfmc<T2, T1, T1>(arg5, &arg6, arg7);
        let v3 = v2;
        let (v4, v5, v6, v7) = f_nffcbvjolt<T2, T1>(arg0, arg4, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T2>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg15, 4);
        assert!(v13 >= arg16, 5);
        let v14 = f_bu4nlbma3l<T2, T1>(arg0, arg8, arg9, v9);
        0x2::balance::join<T1>(&mut v3, v14);
        0x2::balance::join<T1>(&mut v3, v8);
        let v15 = 0x2::balance::value<T1>(&v3);
        assert!(v15 >= arg18, 6);
        0x2::balance::send_funds<T1>(v3, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        0x2::balance::join<T1>(&mut v10, f_bu4nlbma3l<T2, T1>(arg0, arg8, arg9, v11));
        let v16 = 0x2::balance::value<T1>(&v10);
        assert!(v16 >= arg17, 5);
        assert!(v16 >= arg11, 7);
        let v17 = f_c4ffbqp2ie<T0, T1>(arg0, arg8, arg10, 0x2::balance::split<T1>(&mut v10, arg11));
        let (v18, v19) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg10), arg12, 1);
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
        let v29 = T_wpgurru6oy{
            route_id                : 0x2::object::id<T_xm5f56dnqx<T0, T1, T2>>(arg2),
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
        0x2::event::emit<T_wpgurru6oy>(v29);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v20, 0x2::tx_context::sender(arg23));
        let v30 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T0>(v26, v30, arg23);
        let v31 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T1>(v25, v31, arg23);
    }

    public fun f_5lqzu3iphb<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_cyke2d2qxe<T0, T1>, arg3: T_ooc7i2sp27<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: u128, arg10: u32, arg11: u32, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, T_gexrfk364t<T0, T1>) {
        f_544rze3u32(arg1);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg1);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v2 = arg2.owner_authority;
        assert!(arg2.registry_id == v0, 1);
        assert!(arg2.bluefin_pool_id == v1, 12);
        assert!(v2 == 0x2::tx_context::sender(arg14), 15);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.bluefin_pool_id == v1, 12);
        assert!(arg3.bluefin_position_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg6), 14);
        assert!(arg3.owner_authority == v2, 15);
        assert!(arg3.tick_lower == arg10, 3);
        assert!(arg3.tick_upper == arg11, 3);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg10), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg11)), 3);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg6);
        assert!(v3 > 0, 21);
        assert!(v3 == arg9, 21);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v5, v6, v7, v8) = f_bmn6w76gxr<T0, T1>(arg0, arg4, arg5, arg6);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let v12 = v5;
        let v13 = 0x2::balance::value<T0>(&v12);
        let v14 = 0x2::balance::value<T1>(&v11);
        assert!(v13 >= arg12, 4);
        assert!(v14 >= arg13, 5);
        0x2::balance::join<T0>(&mut v10, v4);
        0x2::balance::join<T0>(&mut v12, arg7);
        0x2::balance::join<T1>(&mut v11, arg8);
        let v15 = T_gexrfk364t<T0, T1>{
            registry_id                : v0,
            route_id                   : 0x2::object::id<T_cyke2d2qxe<T0, T1>>(arg2),
            bluefin_pool_id            : v1,
            cetus_pool_id              : arg2.cetus_pool_id,
            owner_authority            : v2,
            source_allocation_cap_id   : 0x2::object::id<T_ooc7i2sp27<T0, T1>>(&arg3),
            source_position_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg6),
            source_liquidity           : v3,
            source_tick_lower          : arg10,
            source_tick_upper          : arg11,
            reward_deep                : 0x2::balance::value<T0>(&v4),
            fee_deep                   : 0x2::balance::value<T0>(&v10),
            fee_sui                    : 0x2::balance::value<T1>(&v9),
            income_deep                : 0x2::balance::value<T0>(&v10),
            source_principal_deep      : v13,
            source_principal_sui       : v14,
            supplied_principal_deep    : 0x2::balance::value<T0>(&arg7),
            supplied_principal_sui     : 0x2::balance::value<T1>(&arg8),
            principal_deep_before_swap : 0x2::balance::value<T0>(&v12),
            principal_sui_before_swap  : 0x2::balance::value<T1>(&v11),
        };
        let T_ooc7i2sp27 {
            id                  : v16,
            registry_id         : _,
            bluefin_pool_id     : _,
            bluefin_position_id : _,
            owner_authority     : _,
            tick_lower          : _,
            tick_upper          : _,
        } = arg3;
        0x2::object::delete(v16);
        (v10, v9, v12, v11, v15)
    }

    public fun f_6coluxz5bh<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        assert!(arg1.expected_reward_count == 2, 13);
        f_nrbwjbbixy<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun f_6r6hl7jgbu<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_ony7fldlkz<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
    }

    fun f_73iy37j75h<T0, T1, T2, T3>(arg0: &T_mxfoob7xa4, arg1: &T_6q63tjexs3<T0, T1, T2, T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.reward_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3), 12);
    }

    fun f_73sxgdbci3<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: vector<0x1::type_name::TypeName>, arg5: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = (0x1::vector::length<0x1::type_name::TypeName>(&arg4) as u8);
        assert!(v0 <= 3, 13);
        let v1 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3);
        assert!(v2 != v3, 12);
        let v4 = T_jf5gusnm2a<T2, T1>{
            id                    : 0x2::object::new(arg5),
            registry_id           : v1,
            cetus_pool_id         : v3,
            expected_reward_count : v0,
            expected_reward_types : arg4,
        };
        let v5 = T_xm5f56dnqx<T0, T1, T2>{
            id                    : 0x2::object::new(arg5),
            registry_id           : v1,
            bluefin_pool_id       : v2,
            cetus_pool_id         : v3,
            expected_reward_count : v0,
            expected_reward_types : f_vcqbamacfl<T2, T1>(&v4),
        };
        let v6 = T_u4lbmw6naw{
            registry_id           : v1,
            cetus_route_id        : 0x2::object::id<T_jf5gusnm2a<T2, T1>>(&v4),
            cross_venue_route_id  : 0x2::object::id<T_xm5f56dnqx<T0, T1, T2>>(&v5),
            cetus_pool_id         : v3,
            bluefin_pool_id       : v2,
            expected_reward_count : v0,
        };
        0x2::event::emit<T_u4lbmw6naw>(v6);
        0x2::transfer::public_transfer<T_jf5gusnm2a<T2, T1>>(v4, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<T_xm5f56dnqx<T0, T1, T2>>(v5, 0x2::tx_context::sender(arg5));
    }

    public fun f_7atwyedvra<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_jf5gusnm2a<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        f_yq55f2eibc<T0, T1>(arg1, arg2, arg4);
        let v0 = 0x2::coin::into_balance<T1>(arg6);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 >= arg7, 7);
        let v2 = f_dpuj5ffjbe<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v0, arg7));
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg4, arg5, arg8, arg9, arg0);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        assert!(0x2::balance::value<T0>(&v2) >= v4, 8);
        assert!(0x2::balance::value<T1>(&v0) >= v5, 9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg3, arg4, 0x2::balance::split<T0>(&mut v2, v4), 0x2::balance::split<T1>(&mut v0, v5), v3);
        let v6 = 0x2::balance::value<T0>(&v2);
        let v7 = 0x2::balance::value<T1>(&v0);
        assert!(v4 >= arg10, 8);
        assert!(v5 >= arg11, 9);
        assert!(v6 <= arg12, 10);
        assert!(v7 <= arg13, 11);
        let v8 = T_ezf5bhou6h{
            route_id      : 0x2::object::id<T_jf5gusnm2a<T0, T1>>(arg2),
            pool_id       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            position_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg5),
            input_sui     : v1,
            sui_to_x      : arg7,
            x_out         : 0x2::balance::value<T0>(&v2),
            deposited_x   : v4,
            deposited_sui : v5,
            residual_x    : v6,
            residual_sui  : v7,
        };
        0x2::event::emit<T_ezf5bhou6h>(v8);
        let v9 = 0x2::tx_context::sender(arg14);
        f_jk6cxnkjme<T0>(v2, v9, arg14);
        let v10 = 0x2::tx_context::sender(arg14);
        f_jk6cxnkjme<T1>(v0, v10, arg14);
    }

    fun f_7visyj3cvq<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_3wk4gy3ybf<T0, T1, T2>) {
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
    }

    public fun f_7xh3iskhc6<T0, T1, T2, T3>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg4: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>>(arg3);
        assert!(v1 != v2, 12);
        let v3 = T_6q63tjexs3<T0, T1, T2, T3>{
            id                 : 0x2::object::new(arg4),
            registry_id        : v0,
            cetus_pool_id      : v1,
            reward_sui_pool_id : v2,
        };
        let v4 = T_42oy2hnj7u{
            registry_id        : v0,
            reward_route_id    : 0x2::object::id<T_6q63tjexs3<T0, T1, T2, T3>>(&v3),
            cetus_pool_id      : v1,
            reward_sui_pool_id : v2,
            direct_sui         : false,
        };
        0x2::event::emit<T_42oy2hnj7u>(v4);
        0x2::transfer::public_transfer<T_6q63tjexs3<T0, T1, T2, T3>>(v3, 0x2::tx_context::sender(arg4));
    }

    fun f_a2douypn3u<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(arg3);
        if (v0 > 0 || v1 > 0) {
            let (_, _, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
            (v6, v7)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        }
    }

    fun f_acy22dxebs<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_mxzfe3z2ef<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) {
        f_544rze3u32(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.bluefin_x_sui_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 12);
    }

    public fun f_amxmokiy4g<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_jf5gusnm2a<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: T_b2qzkyfcoy<T1>, arg7: bool, arg8: u64, arg9: u32, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        f_yq55f2eibc<T0, T1>(arg1, arg2, arg4);
        f_h76ndz3c44<T1>(&arg6, &arg2.expected_reward_types);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4);
        let (v1, v2) = f_55o2ioxfmc<T0, T1, T1>(arg4, &arg5, arg6);
        let v3 = v2;
        let (v4, v5, v6, v7) = f_nffcbvjolt<T0, T1>(arg0, arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg12, 4);
        assert!(v13 >= arg13, 5);
        let v14 = f_qaaj652tac<T0, T1>(arg0, arg3, arg4, v9);
        0x2::balance::join<T1>(&mut v3, v14);
        0x2::balance::join<T1>(&mut v3, v8);
        let v15 = 0x2::balance::value<T1>(&v3);
        assert!(v15 >= arg14, 6);
        0x2::balance::send_funds<T1>(v3, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v16 = 0;
        if (arg8 > 0) {
            if (arg7) {
                assert!(0x2::balance::value<T0>(&v11) >= arg8, 7);
                let v17 = f_qaaj652tac<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v11, arg8));
                v16 = 0x2::balance::value<T1>(&v17);
                0x2::balance::join<T1>(&mut v10, v17);
            } else {
                assert!(0x2::balance::value<T1>(&v10) >= arg8, 7);
                let v18 = f_dpuj5ffjbe<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v10, arg8));
                v16 = 0x2::balance::value<T0>(&v18);
                0x2::balance::join<T0>(&mut v11, v18);
            };
        };
        let (v19, v20) = f_je4ayhnzei(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg4), arg9, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4));
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
        let v27 = T_ffxknvwuk2{
            route_id                : 0x2::object::id<T_jf5gusnm2a<T0, T1>>(arg2),
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
        0x2::event::emit<T_ffxknvwuk2>(v27);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v21, 0x2::tx_context::sender(arg19));
        let v28 = 0x2::tx_context::sender(arg19);
        f_jk6cxnkjme<T0>(v11, v28, arg19);
        let v29 = 0x2::tx_context::sender(arg19);
        f_jk6cxnkjme<T1>(v10, v29, arg19);
    }

    public fun f_anobqjutok<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = T_mxzfe3z2ef<T0, T1>{
            id                    : 0x2::object::new(arg4),
            registry_id           : 0x2::object::id<T_mxfoob7xa4>(arg0),
            cetus_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            bluefin_x_sui_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
        };
        let v1 = T_rr5a36qqwe{
            registry_id           : 0x2::object::id<T_mxfoob7xa4>(arg0),
            route_id              : 0x2::object::id<T_mxzfe3z2ef<T0, T1>>(&v0),
            cetus_pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            bluefin_x_sui_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
        };
        0x2::event::emit<T_rr5a36qqwe>(v1);
        0x2::transfer::public_transfer<T_mxzfe3z2ef<T0, T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun f_aqg2vkacbo<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_ony7fldlkz<T0, T1, T2>, arg3: &T_3wk4gy3ybf<T0, T1, T2>, arg4: &T_wq752b2wj2<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg11: u64, arg12: u64, arg13: u32, arg14: u64, arg15: bool, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: &mut 0x2::tx_context::TxContext) {
        f_544rze3u32(arg1);
        f_6r6hl7jgbu<T0, T1, T2>(arg1, arg2);
        f_7visyj3cvq<T0, T1, T2>(arg1, arg3);
        f_ihsag5x73k<T0, T1>(arg1, arg4);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg5, arg6, &arg7, arg8, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg5, arg6, &arg7, arg8, true, arg0);
        let (v2, v3, v4, v5) = f_nffcbvjolt<T0, T1>(arg0, arg5, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg16, 4);
        assert!(v11 >= arg17, 5);
        let v12 = f_bu4nlbma3l<T2, T1>(arg0, arg9, arg10, v0);
        let v13 = f_qaaj652tac<T0, T1>(arg0, arg5, arg6, v7);
        0x2::balance::join<T1>(&mut v1, v12);
        0x2::balance::join<T1>(&mut v1, v6);
        0x2::balance::join<T1>(&mut v1, v13);
        let v14 = 0x2::balance::value<T1>(&v1);
        assert!(v14 >= arg18, 6);
        0x2::balance::send_funds<T1>(v1, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        assert!(0x2::balance::value<T0>(&v9) >= arg11, 7);
        let v15 = f_qaaj652tac<T0, T1>(arg0, arg5, arg6, 0x2::balance::split<T0>(&mut v9, arg11));
        0x2::balance::join<T1>(&mut v8, v15);
        assert!(0x2::balance::value<T1>(&v8) >= arg12, 7);
        let v16 = f_c4ffbqp2ie<T2, T1>(arg0, arg9, arg10, 0x2::balance::split<T1>(&mut v8, arg12));
        let (v17, v18) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T2, T1>(arg10), arg13, 1);
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
        let v28 = T_mlujnkc2ww{
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
        0x2::event::emit<T_mlujnkc2ww>(v28);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg24));
        let v29 = 0x2::tx_context::sender(arg24);
        f_jk6cxnkjme<T0>(v9, v29, arg24);
        let v30 = 0x2::tx_context::sender(arg24);
        f_jk6cxnkjme<T2>(v24, v30, arg24);
        let v31 = 0x2::tx_context::sender(arg24);
        f_jk6cxnkjme<T1>(v8, v31, arg24);
    }

    fun f_bginnogns7<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: 0x2::balance::Balance<T2>) : 0x2::balance::Balance<T2> {
        0x2::balance::join<T2>(&mut arg6, f_qaaj652tac<T0, T2>(arg0, arg1, arg2, arg4));
        0x2::balance::join<T2>(&mut arg6, f_qaaj652tac<T1, T2>(arg0, arg1, arg3, arg5));
        arg6
    }

    fun f_bmn6w76gxr<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = &mut arg3;
        let (v1, v2) = f_a2douypn3u<T0, T1>(arg0, arg1, arg2, v0);
        let v3 = v2;
        let v4 = v1;
        let (_, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg0);
        let v9 = &mut arg3;
        let (v10, v11) = f_a2douypn3u<T0, T1>(arg0, arg1, arg2, v9);
        0x2::balance::join<T0>(&mut v4, v10);
        0x2::balance::join<T1>(&mut v3, v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        (v7, v8, v4, v3)
    }

    public fun f_bpjfrhig7i<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_ooc7i2sp27<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        f_rheym3dvtv<T0, T1>(arg1, arg2, arg4, arg5, arg14);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2.tick_lower)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2.tick_upper)), 19);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        assert!(v1 >= arg10, 8);
        assert!(v2 >= arg11, 9);
        assert!(v7 <= arg12, 10);
        assert!(v8 <= arg13, 11);
        let v9 = T_omweb27yyd{
            route_id         : 0x2::object::id<T_ooc7i2sp27<T0, T1>>(arg2),
            pool_id          : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4),
            position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg5),
            liquidity_before : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg5),
            liquidity_after  : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg5),
            deposited_deep   : v1,
            deposited_sui    : v2,
            residual_deep    : v7,
            residual_sui     : v8,
        };
        0x2::event::emit<T_omweb27yyd>(v9);
        (v6, v5)
    }

    fun f_bti62a7pgx<T0, T1, T2, T3>(arg0: &T_mxfoob7xa4, arg1: &T_firwujlzgn<T0, T1, T2, T3>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>) {
        f_544rze3u32(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg3), 12);
        assert!(arg1.x_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4), 12);
        assert!(arg1.y_sui_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>>(arg5), 12);
    }

    public fun f_bu3h3z26bl<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_egfxhjnl23<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: T_b2qzkyfcoy<T2>, arg9: u64) {
        f_3tscjyxrml<T0, T1, T2>(arg1, arg2, arg4, arg6, arg7);
        assert!(arg8.expected_reward_count == arg2.expected_reward_count, 13);
        let (v0, v1) = f_55o2ioxfmc<T0, T1, T2>(arg4, arg5, arg8);
        let v2 = v1;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, arg5, true);
        let v5 = v4;
        let v6 = v3;
        let v7 = f_bginnogns7<T0, T1, T2>(arg0, arg3, arg6, arg7, v6, v5, v2);
        let v8 = 0x2::balance::value<T2>(&v7);
        assert!(v8 >= arg9, 6);
        let v9 = T_4zjtv5aucr{
            route_id       : 0x2::object::id<T_egfxhjnl23<T0, T1, T2>>(arg2),
            source_pool_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg5),
            reward_amounts : v0,
            reward_sui     : 0x2::balance::value<T2>(&v2),
            fee_x          : 0x2::balance::value<T0>(&v6),
            fee_y          : 0x2::balance::value<T1>(&v5),
            profit_sui     : v8,
        };
        0x2::event::emit<T_4zjtv5aucr>(v9);
        0x2::balance::send_funds<T2>(v7, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
    }

    fun f_bu4nlbma3l<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
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

    fun f_c4ffbqp2ie<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
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

    public fun f_clxi4parxf<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_ony7fldlkz<T0, T1, T2>, arg3: &T_yd6dm5rbzl<T0, T1, T3>, arg4: &T_wq752b2wj2<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg10: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg12: u64, arg13: u64, arg14: u32, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: &mut 0x2::tx_context::TxContext) {
        f_544rze3u32(arg1);
        f_6r6hl7jgbu<T0, T1, T2>(arg1, arg2);
        f_34gg3zt5u2<T0, T1, T3>(arg1, arg3);
        f_ihsag5x73k<T0, T1>(arg1, arg4);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg5, arg6, &arg7, arg8, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg5, arg6, &arg7, arg8, true, arg0);
        let (v2, v3, v4, v5) = f_nffcbvjolt<T0, T1>(arg0, arg5, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg17, 4);
        assert!(v11 >= arg18, 5);
        let v12 = f_qaaj652tac<T3, T1>(arg0, arg5, arg9, v0);
        let v13 = f_qaaj652tac<T0, T1>(arg0, arg5, arg6, v7);
        0x2::balance::join<T1>(&mut v1, v12);
        0x2::balance::join<T1>(&mut v1, v6);
        0x2::balance::join<T1>(&mut v1, v13);
        let v14 = 0x2::balance::value<T1>(&v1);
        assert!(v14 >= arg19, 6);
        0x2::balance::send_funds<T1>(v1, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        assert!(0x2::balance::value<T0>(&v9) >= arg12, 7);
        let v15 = f_qaaj652tac<T0, T1>(arg0, arg5, arg6, 0x2::balance::split<T0>(&mut v9, arg12));
        0x2::balance::join<T1>(&mut v8, v15);
        assert!(0x2::balance::value<T1>(&v8) >= arg13, 7);
        let v16 = f_c4ffbqp2ie<T2, T1>(arg0, arg10, arg11, 0x2::balance::split<T1>(&mut v8, arg13));
        let (v17, v18) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T2, T1>(arg11), arg14, 1);
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
        let v28 = T_vfgcikdmyu{
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
        0x2::event::emit<T_vfgcikdmyu>(v28);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg25));
        let v29 = 0x2::tx_context::sender(arg25);
        f_jk6cxnkjme<T0>(v9, v29, arg25);
        let v30 = 0x2::tx_context::sender(arg25);
        f_jk6cxnkjme<T2>(v24, v30, arg25);
        let v31 = 0x2::tx_context::sender(arg25);
        f_jk6cxnkjme<T1>(v8, v31, arg25);
    }

    public fun f_cql2cbynud<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_egfxhjnl23<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T2> {
        assert!(arg1.expected_reward_count == 0, 13);
        f_v7oysm456v<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun f_d3gjr2h4xb<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3);
        assert!(v1 != v2, 12);
        let v3 = T_cyke2d2qxe<T0, T1>{
            id              : 0x2::object::new(arg5),
            registry_id     : v0,
            bluefin_pool_id : v1,
            cetus_pool_id   : v2,
            owner_authority : arg4,
        };
        let v4 = T_6zt2xaixlo{
            registry_id     : v0,
            route_id        : 0x2::object::id<T_cyke2d2qxe<T0, T1>>(&v3),
            bluefin_pool_id : v1,
            cetus_pool_id   : v2,
            owner_authority : arg4,
        };
        0x2::event::emit<T_6zt2xaixlo>(v4);
        0x2::transfer::public_transfer<T_cyke2d2qxe<T0, T1>>(v3, arg4);
    }

    fun f_dpuj5ffjbe<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
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

    public fun f_dsbxfdlei5<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = T_rypypwh3yl<T0, T1, T2>{
            id               : 0x2::object::new(arg5),
            registry_id      : 0x2::object::id<T_mxfoob7xa4>(arg0),
            primary_pool_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            farm_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg3),
            sui_usdc_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4),
        };
        let v1 = T_6wj7wkz3ts{
            registry_id      : 0x2::object::id<T_mxfoob7xa4>(arg0),
            route_id         : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(&v0),
            primary_pool_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            farm_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg3),
            sui_usdc_pool_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4),
        };
        0x2::event::emit<T_6wj7wkz3ts>(v1);
        0x2::transfer::public_transfer<T_rypypwh3yl<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun f_e5u3hjxfj6<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        assert!(arg1.expected_reward_count == 3, 13);
        f_nrbwjbbixy<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun f_ervptq24ln<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        assert!(arg1.expected_reward_count == 2, 13);
        f_nrbwjbbixy<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun f_eshx6fwhzt<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_ubv6jvfaql<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
    }

    public fun f_f34hf6zk2m<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        let v2 = T_ubv6jvfaql<T0, T1, T2>{
            id            : 0x2::object::new(arg3),
            registry_id   : v0,
            cetus_pool_id : v1,
        };
        let v3 = T_42oy2hnj7u{
            registry_id        : v0,
            reward_route_id    : 0x2::object::id<T_ubv6jvfaql<T0, T1, T2>>(&v2),
            cetus_pool_id      : v1,
            reward_sui_pool_id : v1,
            direct_sui         : true,
        };
        0x2::event::emit<T_42oy2hnj7u>(v3);
        0x2::transfer::public_transfer<T_ubv6jvfaql<T0, T1, T2>>(v2, 0x2::tx_context::sender(arg3));
    }

    fun f_femq3j54qj<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &T_b2qzkyfcoy<T2>) {
        assert!(arg2.source_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0), 12);
        assert!(arg2.position_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1), 14);
        assert!(arg2.expected_reward_count <= 3, 13);
        assert!(arg2.reward_count <= arg2.expected_reward_count, 13);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.reward_types) == (arg2.reward_count as u64), 13);
        assert!(0x1::vector::length<u64>(&arg2.reward_amounts) == (arg2.reward_count as u64), 13);
    }

    public fun f_gfqffjsmn5<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_firwujlzgn<T0, T1, T2, T3>, arg3: &T_ffbhaz5mux<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg11: u64, arg12: u64, arg13: u64, arg14: u32, arg15: u32, arg16: u64, arg17: bool, arg18: u64, arg19: bool, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: u64, arg32: &mut 0x2::tx_context::TxContext) {
        f_bti62a7pgx<T0, T1, T2, T3>(arg1, arg2, arg5, arg8, arg9, arg10);
        f_wzox2mblzz<T0, T1>(arg1, arg3);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v2, v3, v4, v5) = f_bmn6w76gxr<T0, T1>(arg0, arg4, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg20, 4);
        assert!(v11 >= arg21, 5);
        0x2::balance::join<T0>(&mut v7, v1);
        let v12 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, v7);
        0x2::balance::join<T1>(&mut v12, v6);
        let v13 = 0x2::balance::value<T1>(&v12);
        assert!(v13 >= arg23, 6);
        0x2::balance::send_funds<T1>(v12, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v14 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, v9);
        0x2::balance::join<T1>(&mut v8, v14);
        let v15 = 0x2::balance::value<T1>(&v8);
        assert!(v15 >= arg22, 5);
        assert!(v15 >= arg11, 7);
        let v16 = f_c4ffbqp2ie<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T1>(&mut v8, arg11));
        assert!(0x2::balance::value<T1>(&v8) >= arg12, 7);
        let v17 = f_dpuj5ffjbe<T2, T1>(arg0, arg7, arg9, 0x2::balance::split<T1>(&mut v8, arg12));
        assert!(0x2::balance::value<T1>(&v8) >= arg13, 7);
        let v18 = f_dpuj5ffjbe<T3, T1>(arg0, arg7, arg10, 0x2::balance::split<T1>(&mut v8, arg13));
        let (v19, v20) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg14, 1);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v19, v20, arg32);
        let (v22, v23, v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v21, v16, v8, arg16, arg17);
        let v26 = v25;
        let v27 = v24;
        let (v28, v29) = f_je4ayhnzei(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T3>(arg8), arg15, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T3>(arg8));
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
        let v38 = T_4p4xrvbftx{
            route_id                    : 0x2::object::id<T_firwujlzgn<T0, T1, T2, T3>>(arg2),
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
        0x2::event::emit<T_4p4xrvbftx>(v38);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg32));
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v30, 0x2::tx_context::sender(arg32));
        let v39 = 0x2::tx_context::sender(arg32);
        f_jk6cxnkjme<T0>(v27, v39, arg32);
        let v40 = 0x2::tx_context::sender(arg32);
        f_jk6cxnkjme<T1>(v26, v40, arg32);
        let v41 = 0x2::tx_context::sender(arg32);
        f_jk6cxnkjme<T2>(v17, v41, arg32);
        let v42 = 0x2::tx_context::sender(arg32);
        f_jk6cxnkjme<T3>(v18, v42, arg32);
    }

    public fun f_gp3jwpd4cq<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_mxzfe3z2ef<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: &mut T_b2qzkyfcoy<T1>, arg10: u64) {
        f_544rze3u32(arg1);
        f_acy22dxebs<T0, T1>(arg1, arg2, arg4, arg8);
        f_femq3j54qj<T0, T1, T1>(arg4, arg5, arg9);
        assert!(arg9.reward_count < arg9.expected_reward_count, 13);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg9.reward_types, &v0), 13);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = f_bu4nlbma3l<T0, T1>(arg0, arg7, arg8, v1);
        assert!(0x2::balance::value<T1>(&v2) >= arg10, 6);
        0x2::balance::join<T1>(&mut arg9.reward_sui, v2);
        arg9.reward_count = arg9.reward_count + 1;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg9.reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg9.reward_amounts, 0x2::balance::value<T0>(&v1));
    }

    public fun f_gq64q6hjgi<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_crf2gz6ikb<T0, T1, T2>, arg3: &T_ffbhaz5mux<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: u64, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        f_544rze3u32(arg1);
        f_3juarfjuea<T0, T1, T2>(arg1, arg2);
        f_wzox2mblzz<T0, T1>(arg1, arg3);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T1>(arg0, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg14, 4);
        assert!(v10 >= arg15, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg16, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        assert!(0x2::balance::value<T0>(&v8) >= arg9, 7);
        let v13 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T0>(&mut v8, arg9));
        0x2::balance::join<T1>(&mut v7, v13);
        assert!(0x2::balance::value<T1>(&v7) >= arg10, 7);
        let v14 = f_dpuj5ffjbe<T2, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v7, arg10));
        let (v15, v16) = f_je4ayhnzei(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T1>(arg8), arg11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T1>(arg8));
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
        let v24 = T_snlr6qndrx{
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
        0x2::event::emit<T_snlr6qndrx>(v24);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v17, 0x2::tx_context::sender(arg22));
        let v25 = 0x2::tx_context::sender(arg22);
        f_jk6cxnkjme<T0>(v8, v25, arg22);
        let v26 = 0x2::tx_context::sender(arg22);
        f_jk6cxnkjme<T2>(v14, v26, arg22);
        let v27 = 0x2::tx_context::sender(arg22);
        f_jk6cxnkjme<T1>(v7, v27, arg22);
    }

    fun f_gu7lcpv3om<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_rypypwh3yl<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>) {
        f_544rze3u32(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.primary_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.farm_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg3), 12);
        assert!(arg1.sui_usdc_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4), 12);
    }

    public fun f_h2xfspzg7i<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = T_wq752b2wj2<T0, T1>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<T_mxfoob7xa4>(arg0),
        };
        let v1 = T_pg3wrruijq{
            registry_id  : 0x2::object::id<T_mxfoob7xa4>(arg0),
            adapter_kind : 5,
        };
        0x2::event::emit<T_pg3wrruijq>(v1);
        0x2::transfer::public_transfer<T_wq752b2wj2<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun f_h76ndz3c44<T0>(arg0: &T_b2qzkyfcoy<T0>, arg1: &vector<0x1::type_name::TypeName>) {
        let v0 = 0x1::vector::length<0x1::type_name::TypeName>(arg1);
        assert!(arg0.expected_reward_count == (v0 as u8), 13);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.reward_types) == v0, 13);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.reward_types, v1) == 0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v1), 13);
            v1 = v1 + 1;
        };
    }

    public fun f_hm5dd3xqcm<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u32, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        f_5fdzll7c7q<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public fun f_hr4f45yu3q<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u32, arg5: u32, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5)), 3);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3);
        let v3 = T_pnb4cyyddi<T0, T1, T2>{
            id                  : 0x2::object::new(arg7),
            registry_id         : v0,
            bluefin_pool_id     : v1,
            bluefin_position_id : v2,
            owner_authority     : arg6,
            tick_lower          : arg4,
            tick_upper          : arg5,
        };
        let v4 = T_ubatmpwltf{
            registry_id         : v0,
            managed_cap_id      : 0x2::object::id<T_pnb4cyyddi<T0, T1, T2>>(&v3),
            bluefin_pool_id     : v1,
            bluefin_position_id : v2,
            owner_authority     : arg6,
            tick_lower          : arg4,
            tick_upper          : arg5,
        };
        0x2::event::emit<T_ubatmpwltf>(v4);
        0x2::transfer::public_transfer<T_pnb4cyyddi<T0, T1, T2>>(v3, arg6);
    }

    public fun f_htsqdue46g<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u32, arg5: u32, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5)), 3);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v1 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3);
        let v3 = T_ooc7i2sp27<T0, T1>{
            id                  : 0x2::object::new(arg7),
            registry_id         : v0,
            bluefin_pool_id     : v1,
            bluefin_position_id : v2,
            owner_authority     : arg6,
            tick_lower          : arg4,
            tick_upper          : arg5,
        };
        let v4 = T_njqc6cqy4v{
            registry_id         : v0,
            route_id            : 0x2::object::id<T_ooc7i2sp27<T0, T1>>(&v3),
            bluefin_pool_id     : v1,
            bluefin_position_id : v2,
            owner_authority     : arg6,
            tick_lower          : arg4,
            tick_upper          : arg5,
        };
        0x2::event::emit<T_njqc6cqy4v>(v4);
        0x2::transfer::public_transfer<T_ooc7i2sp27<T0, T1>>(v3, arg6);
    }

    public fun f_i4t5i5cocr<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = T_yd6dm5rbzl<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<T_mxfoob7xa4>(arg0),
        };
        let v1 = T_pg3wrruijq{
            registry_id  : 0x2::object::id<T_mxfoob7xa4>(arg0),
            adapter_kind : 6,
        };
        0x2::event::emit<T_pg3wrruijq>(v1);
        0x2::transfer::public_transfer<T_yd6dm5rbzl<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun f_ieuhr2tywp<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_jf5gusnm2a<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: T_b2qzkyfcoy<T1>, arg7: u64) {
        f_yq55f2eibc<T0, T1>(arg1, arg2, arg4);
        f_h76ndz3c44<T1>(&arg6, &arg2.expected_reward_types);
        let (v0, v1) = f_55o2ioxfmc<T0, T1, T1>(arg4, arg5, arg6);
        let v2 = v1;
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, arg5, true);
        let v5 = v4;
        let v6 = v3;
        let v7 = f_qaaj652tac<T0, T1>(arg0, arg3, arg4, v6);
        0x2::balance::join<T1>(&mut v2, v7);
        0x2::balance::join<T1>(&mut v2, v5);
        let v8 = 0x2::balance::value<T1>(&v2);
        assert!(v8 >= arg7, 6);
        let v9 = T_fmfrdcdr5i{
            route_id       : 0x2::object::id<T_jf5gusnm2a<T0, T1>>(arg2),
            source_pool_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4),
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg5),
            reward_amounts : v0,
            reward_sui     : 0x2::balance::value<T1>(&v2),
            fee_x          : 0x2::balance::value<T0>(&v6),
            fee_sui        : 0x2::balance::value<T1>(&v5),
            profit_sui     : v8,
        };
        0x2::event::emit<T_fmfrdcdr5i>(v9);
        0x2::balance::send_funds<T1>(v2, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
    }

    public fun f_igulbax7yd<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>, arg3: T_jqabux35vc<T0, T1, T2, T3, T4, T5>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg6: 0x2::balance::Balance<T3>, arg7: 0x2::balance::Balance<T4>, arg8: 0x2::balance::Balance<0x2::sui::SUI>, arg9: u32, arg10: u32, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u128, arg28: &mut 0x2::tx_context::TxContext) {
        f_jfvr7fjrid<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg28);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg1);
        let v1 = 0x2::object::id<T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg5);
        let v3 = arg2.owner_authority;
        assert!(arg2.target_bluefin_pool_id == v2, 12);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.route_id == v1, 1);
        assert!(arg3.source_bluefin_pool_id == arg2.source_bluefin_pool_id, 12);
        assert!(arg3.target_bluefin_pool_id == v2, 12);
        assert!(arg3.owner_authority == v3, 15);
        let v4 = 0x1::vector::length<0x2::object::ID>(&arg3.authenticated_cetus_pool_ids);
        assert!(v4 > 0, 23);
        assert!(v4 == 0x1::vector::length<0x2::object::ID>(&arg2.allowed_cetus_pool_ids), 23);
        let v5 = 0;
        while (v5 < v4) {
            assert!(0x1::vector::contains<0x2::object::ID>(&arg2.allowed_cetus_pool_ids, 0x1::vector::borrow<0x2::object::ID>(&arg3.authenticated_cetus_pool_ids, v5)), 25);
            v5 = v5 + 1;
        };
        let v6 = 0x2::balance::value<T3>(&arg6);
        let v7 = 0x2::balance::value<T4>(&arg7);
        assert!(v6 >= arg13, 28);
        assert!(v6 <= arg14, 26);
        assert!(v7 >= arg15, 28);
        assert!(v7 <= arg16, 26);
        let v8 = arg2.target_tick_spacing;
        assert!(v8 > 0 && v8 <= 1000000, 27);
        let (v9, v10) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T3, T4>(arg5), v8 * 2, v8);
        assert!(arg9 == v9, 3);
        assert!(arg10 == v10, 3);
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T3, T4>(arg4, arg5, arg9, arg10, arg28);
        let v12 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v11);
        let (v13, v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T3, T4>(arg0, arg4, arg5, &mut v11, arg6, arg7, arg11, arg12);
        let v17 = v16;
        let v18 = v15;
        let v19 = 0x2::balance::value<T3>(&v18);
        let v20 = 0x2::balance::value<T4>(&v17);
        assert!(v13 >= arg17, 28);
        assert!(v13 <= arg18, 26);
        assert!(v14 >= arg19, 28);
        assert!(v14 <= arg20, 26);
        assert!(v19 >= arg21, 28);
        assert!(v19 <= arg22, 26);
        assert!(v20 >= arg23, 28);
        assert!(v20 <= arg24, 26);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v11);
        assert!(v21 > 0, 21);
        assert!(v21 >= arg27, 21);
        let v22 = 0x2::balance::value<0x2::sui::SUI>(&arg8);
        assert!(v22 >= arg25, 28);
        assert!(v22 <= arg26, 26);
        if (v22 > 0) {
            0x2::balance::send_funds<0x2::sui::SUI>(arg8, arg1.profit_recipient);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg8);
        };
        let v23 = T_pnb4cyyddi<T3, T4, T5>{
            id                  : 0x2::object::new(arg28),
            registry_id         : v0,
            bluefin_pool_id     : v2,
            bluefin_position_id : v12,
            owner_authority     : v3,
            tick_lower          : arg9,
            tick_upper          : arg10,
        };
        let v24 = T_ooc7i2sp27<T3, T4>{
            id                  : 0x2::object::new(arg28),
            registry_id         : v0,
            bluefin_pool_id     : v2,
            bluefin_position_id : v12,
            owner_authority     : v3,
            tick_lower          : arg9,
            tick_upper          : arg10,
        };
        let v25 = T_3mj2kxfbqq{
            registry_id                   : v0,
            route_id                      : v1,
            source_managed_cap_id         : arg3.source_managed_cap_id,
            source_allocation_cap_id      : arg3.source_allocation_cap_id,
            replacement_managed_cap_id    : 0x2::object::id<T_pnb4cyyddi<T3, T4, T5>>(&v23),
            replacement_allocation_cap_id : 0x2::object::id<T_ooc7i2sp27<T3, T4>>(&v24),
            source_bluefin_pool_id        : arg3.source_bluefin_pool_id,
            target_bluefin_pool_id        : v2,
            source_position_id            : arg3.source_position_id,
            target_position_id            : v12,
            owner_authority               : v3,
            authenticated_cetus_pool_ids  : arg3.authenticated_cetus_pool_ids,
            source_liquidity              : arg3.source_liquidity,
            replacement_liquidity         : v21,
            source_tick_lower             : arg3.source_tick_lower,
            source_tick_upper             : arg3.source_tick_upper,
            target_tick_lower             : arg9,
            target_tick_upper             : arg10,
            reward_amount                 : arg3.reward_amount,
            fee_a                         : arg3.fee_a,
            fee_b                         : arg3.fee_b,
            source_principal_a            : arg3.source_principal_a,
            source_principal_b            : arg3.source_principal_b,
            supplied_principal_a          : arg3.supplied_principal_a,
            supplied_principal_b          : arg3.supplied_principal_b,
            target_balance_a              : v6,
            target_balance_b              : v7,
            deposited_a                   : v13,
            deposited_b                   : v14,
            residual_a                    : v19,
            residual_b                    : v20,
            income_sui                    : v22,
        };
        0x2::event::emit<T_3mj2kxfbqq>(v25);
        let T_jqabux35vc {
            registry_id                  : _,
            route_id                     : _,
            source_bluefin_pool_id       : _,
            target_bluefin_pool_id       : _,
            owner_authority              : _,
            source_managed_cap_id        : _,
            source_allocation_cap_id     : _,
            source_position_id           : _,
            source_liquidity             : _,
            source_tick_lower            : _,
            source_tick_upper            : _,
            reward_amount                : _,
            fee_a                        : _,
            fee_b                        : _,
            source_principal_a           : _,
            source_principal_b           : _,
            supplied_principal_a         : _,
            supplied_principal_b         : _,
            total_principal_a            : _,
            total_principal_b            : _,
            authenticated_cetus_pool_ids : _,
        } = arg3;
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v11, v3);
        f_jk6cxnkjme<T3>(v18, v3, arg28);
        f_jk6cxnkjme<T4>(v17, v3, arg28);
        0x2::transfer::public_transfer<T_pnb4cyyddi<T3, T4, T5>>(v23, v3);
        0x2::transfer::public_transfer<T_ooc7i2sp27<T3, T4>>(v24, v3);
    }

    fun f_ihsag5x73k<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_wq752b2wj2<T0, T1>) {
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
    }

    public fun f_in6zmp275s<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: &mut 0x2::tx_context::TxContext) {
        f_o7zn4sd4fo<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27);
    }

    fun f_je4ayhnzei(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32, arg2: u32) : (u32, u32) {
        assert!(arg2 > 0, 3);
        assert!(arg1 >= arg2, 3);
        assert!(arg1 % arg2 == 0, 3);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg2);
        if (arg1 == 2 && arg2 == 1) {
            return (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))))
        };
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

    fun f_jfvr7fjrid<T0, T1, T2, T3, T4, T5>(arg0: &T_mxfoob7xa4, arg1: &T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>, arg2: &0x2::tx_context::TxContext) {
        f_544rze3u32(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.owner_authority == 0x2::tx_context::sender(arg2), 15);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.allowed_cetus_pool_ids) > 0, 23);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.allowed_cetus_pool_ids) <= 2, 24);
        assert!(arg1.target_tick_spacing > 0 && arg1.target_tick_spacing <= 1000000, 27);
    }

    fun f_jk6cxnkjme<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun f_jlsunzyj4h<T0, T1, T2, T3, T4, T5>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg4: vector<0x2::object::ID>, arg5: u32, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg4);
        assert!(v0 > 0, 23);
        assert!(v0 <= 2, 24);
        assert!(arg5 > 0 && arg5 <= 1000000, 27);
        let v1 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2);
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg3);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow<0x2::object::ID>(&arg4, v4);
            assert!(*v5 != v2, 12);
            assert!(*v5 != v3, 12);
            v4 = v4 + 1;
        };
        let v6 = T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>{
            id                     : 0x2::object::new(arg7),
            registry_id            : v1,
            source_bluefin_pool_id : v2,
            target_bluefin_pool_id : v3,
            owner_authority        : arg6,
            target_tick_spacing    : arg5,
            allowed_cetus_pool_ids : arg4,
        };
        let v7 = T_eatvlkc6ni{
            registry_id            : v1,
            route_id               : 0x2::object::id<T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>>(&v6),
            source_bluefin_pool_id : v2,
            target_bluefin_pool_id : v3,
            owner_authority        : arg6,
            target_tick_spacing    : arg5,
            allowed_cetus_pool_ids : v6.allowed_cetus_pool_ids,
        };
        0x2::event::emit<T_eatvlkc6ni>(v7);
        0x2::transfer::public_transfer<T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>>(v6, arg6);
    }

    public fun f_jomcmjagv2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, &mut arg7);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T2>(arg0, arg3, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T2>(&v7);
        assert!(v9 >= arg8, 4);
        assert!(v10 >= arg9, 5);
        0x2::balance::join<T0>(&mut v8, v0);
        0x2::balance::join<T0>(&mut v8, v6);
        0x2::balance::join<T2>(&mut v7, v5);
        let v11 = f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, v7);
        let v12 = T_j5ce66psm4{
            route_id              : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
            source_position_id    : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            reward_deep           : 0x2::balance::value<T0>(&v0),
            fee_deep              : 0x2::balance::value<T0>(&v6),
            fee_usdc              : 0x2::balance::value<T2>(&v5),
            source_principal_deep : v9,
            source_principal_usdc : v10,
            output_deep           : 0x2::balance::value<T0>(&v8),
            output_sui            : 0x2::balance::value<T1>(&v11),
        };
        0x2::event::emit<T_j5ce66psm4>(v12);
        (v8, v11)
    }

    public fun f_k2aazgwrxg<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_crf2gz6ikb<T0, T1, T2>, arg3: &T_ffbhaz5mux<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: u64, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: &mut 0x2::tx_context::TxContext) {
        f_544rze3u32(arg1);
        f_3juarfjuea<T0, T1, T2>(arg1, arg2);
        f_wzox2mblzz<T0, T1>(arg1, arg3);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T1>(arg0, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg17, 4);
        assert!(v10 >= arg18, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg19, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        assert!(v9 >= arg9, 7);
        assert!(v10 >= arg10, 7);
        let v13 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T0>(&mut v8, arg9));
        0x2::balance::join<T1>(&mut v13, 0x2::balance::split<T1>(&mut v7, arg10));
        assert!(0x2::balance::value<T1>(&v13) >= arg11, 7);
        let v14 = f_dpuj5ffjbe<T2, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v13, arg11));
        let (v15, v16) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg12, 1);
        let v17 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v15, v16, arg27);
        let (v18, v19, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v17, v8, v7, arg13, arg14);
        v8 = v20;
        v7 = v21;
        let (v22, v23) = f_pzzwrq6ooc(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T1>(arg8), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T1>(arg8));
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
        let v31 = T_bfzf3klfie{
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
        0x2::event::emit<T_bfzf3klfie>(v31);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v17, 0x2::tx_context::sender(arg27));
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v24, 0x2::tx_context::sender(arg27));
        0x2::balance::join<T1>(&mut v7, v13);
        let v32 = 0x2::tx_context::sender(arg27);
        f_jk6cxnkjme<T0>(v8, v32, arg27);
        let v33 = 0x2::tx_context::sender(arg27);
        f_jk6cxnkjme<T2>(v14, v33, arg27);
        let v34 = 0x2::tx_context::sender(arg27);
        f_jk6cxnkjme<T1>(v7, v34, arg27);
    }

    public fun f_k7ksotyg3s<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = T_crf2gz6ikb<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<T_mxfoob7xa4>(arg0),
        };
        let v1 = T_pg3wrruijq{
            registry_id  : 0x2::object::id<T_mxfoob7xa4>(arg0),
            adapter_kind : 1,
        };
        0x2::event::emit<T_pg3wrruijq>(v1);
        0x2::transfer::public_transfer<T_crf2gz6ikb<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun f_lhy5bl7zi2(arg0: &mut T_mxfoob7xa4, arg1: &T_gc6rj26lvo) {
        assert!(arg0.profit_recipient == @0xa40759d45016da48ec08b52907582e69d9c0de9c1ce719331a409e6e15533292, 2);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 0);
        assert!(0x2::object::id<T_gc6rj26lvo>(arg1) == arg0.admin_cap_id, 0);
        arg0.profit_recipient = @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498;
    }

    public fun f_ll7icl67qx<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_gc6rj26lvo, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T1>, arg10: u64, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        f_544rze3u32(arg1);
        f_zyotjhy6mn(arg1, arg2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg3, arg4, &arg5, arg6, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg3, arg4, &arg5, arg6, true, arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg3, arg4, &arg5, arg6, true, arg0);
        let (v3, v4, v5, v6) = f_nffcbvjolt<T0, T1>(arg0, arg3, arg4, arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = 0x2::balance::value<T0>(&v10);
        let v12 = 0x2::balance::value<T1>(&v9);
        assert!(v11 >= arg15, 4);
        assert!(v12 >= arg16, 5);
        0x2::balance::join<T0>(&mut v8, v0);
        let v13 = f_qaaj652tac<T0, T1>(arg0, arg3, arg4, v8);
        0x2::balance::join<T1>(&mut v1, v7);
        0x2::balance::join<T1>(&mut v1, v13);
        0x2::balance::join<T1>(&mut v1, f_qaaj652tac<T3, T1>(arg0, arg3, arg7, v2));
        let v14 = 0x2::balance::value<T1>(&v1);
        assert!(v14 >= arg17, 6);
        0x2::balance::send_funds<T1>(v1, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        assert!(v11 >= arg10, 7);
        let v15 = f_qaaj652tac<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v10, arg10));
        0x2::balance::join<T1>(&mut v9, v15);
        assert!(0x2::balance::value<T1>(&v9) >= arg11, 7);
        let v16 = f_c4ffbqp2ie<T2, T1>(arg0, arg8, arg9, 0x2::balance::split<T1>(&mut v9, arg11));
        let (v17, v18) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T2, T1>(arg9), arg12, 1);
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
        let v29 = T_ytvkmwpm56{
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
        0x2::event::emit<T_ytvkmwpm56>(v29);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg23));
        let v30 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T0>(v10, v30, arg23);
        let v31 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T2>(v25, v31, arg23);
        let v32 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T1>(v24, v32, arg23);
    }

    public fun f_lq6mmndltr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_xm5f56dnqx<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: T_b2qzkyfcoy<T1>, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: u64, arg10: u32, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) {
        f_r6xm6lybcg<T0, T1, T2>(arg1, arg2, arg8, arg4);
        f_h76ndz3c44<T1>(&arg6, &arg2.expected_reward_types);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg4);
        let (v1, v2) = f_55o2ioxfmc<T2, T1, T1>(arg4, &arg5, arg6);
        let v3 = v2;
        let (v4, v5, v6, v7) = f_nffcbvjolt<T2, T1>(arg0, arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T2>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg13, 4);
        assert!(v13 >= arg14, 5);
        let v14 = f_qaaj652tac<T2, T1>(arg0, arg3, arg4, v9);
        0x2::balance::join<T1>(&mut v3, v14);
        0x2::balance::join<T1>(&mut v3, v8);
        let v15 = 0x2::balance::value<T1>(&v3);
        assert!(v15 >= arg16, 6);
        0x2::balance::send_funds<T1>(v3, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        0x2::balance::join<T1>(&mut v10, f_qaaj652tac<T2, T1>(arg0, arg3, arg4, v11));
        let v16 = 0x2::balance::value<T1>(&v10);
        assert!(v16 >= arg15, 5);
        assert!(v16 >= arg9, 7);
        let v17 = f_c4ffbqp2ie<T0, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v10, arg9));
        let (v18, v19) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg8), arg10, 1);
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
        let v29 = T_wpgurru6oy{
            route_id                : 0x2::object::id<T_xm5f56dnqx<T0, T1, T2>>(arg2),
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
        0x2::event::emit<T_wpgurru6oy>(v29);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v20, 0x2::tx_context::sender(arg21));
        let v30 = 0x2::tx_context::sender(arg21);
        f_jk6cxnkjme<T0>(v26, v30, arg21);
        let v31 = 0x2::tx_context::sender(arg21);
        f_jk6cxnkjme<T1>(v25, v31, arg21);
    }

    public(friend) fun f_m3reoebeqh(arg0: u32, arg1: u32) : (u32, u32) {
        f_pzzwrq6ooc(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), arg1)
    }

    public fun f_m5oxe432yv<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: bool, arg10: u64, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg3, arg4, &mut arg7);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T1>(arg0, arg3, arg4, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg14, 4);
        assert!(v10 >= arg15, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg16, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v13 = if (arg8 == 18446744073709551615) {
            0x2::balance::value<T1>(&v7)
        } else {
            arg8
        };
        assert!(0x2::balance::value<T1>(&v7) >= v13, 7);
        let v14 = f_bu4nlbma3l<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T1>(&mut v7, v13));
        let v15 = 0x2::balance::value<T2>(&v14);
        let v16 = if (arg10 == 0) {
            0
        } else if (arg9) {
            assert!(0x2::balance::value<T0>(&v8) >= arg10, 7);
            let v17 = f_bu4nlbma3l<T1, T2>(arg0, arg3, arg6, f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v8, arg10)));
            0x2::balance::join<T2>(&mut v14, v17);
            0x2::balance::value<T2>(&v17)
        } else {
            assert!(0x2::balance::value<T2>(&v14) >= arg10, 7);
            let v18 = f_c4ffbqp2ie<T0, T1>(arg0, arg3, arg4, f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T2>(&mut v14, arg10)));
            0x2::balance::join<T0>(&mut v8, v18);
            0x2::balance::value<T0>(&v18)
        };
        let (v19, v20) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg5), arg11, 1);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T2>(arg3, arg5, v19, v20, arg22);
        let v22 = if (arg12 == 18446744073709551615) {
            if (arg13) {
                let v23 = 0x2::balance::value<T0>(&v8);
                assert!(v23 > arg19, 8);
                v23 - arg19
            } else {
                let v24 = 0x2::balance::value<T2>(&v14);
                assert!(v24 > arg21, 9);
                v24 - arg21
            }
        } else {
            arg12
        };
        let (v25, v26, v27, v28) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg3, arg5, &mut v21, v8, v14, v22, arg13);
        v8 = v27;
        v14 = v28;
        let v29 = 0x2::balance::value<T0>(&v8);
        let v30 = 0x2::balance::value<T1>(&v7);
        let v31 = 0x2::balance::value<T2>(&v14);
        assert!(v25 >= arg17, 8);
        assert!(v26 >= arg18, 9);
        assert!(v29 <= arg19, 10);
        assert!(v30 <= arg20, 11);
        assert!(v31 <= arg21, 11);
        let v32 = T_3kz5nkps3l{
            route_id                : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v21),
            reward_deep             : 0x2::balance::value<T0>(&v0),
            fee_deep                : 0x2::balance::value<T0>(&v6),
            fee_sui                 : 0x2::balance::value<T1>(&v5),
            profit_sui              : v12,
            source_principal_deep   : v9,
            source_principal_sui    : v10,
            principal_sui_to_usdc   : v13,
            principal_usdc_out      : v15,
            swap_deep_to_usdc       : arg9,
            swap_input              : arg10,
            swap_output             : v16,
            deposited_deep          : v25,
            deposited_usdc          : v26,
            residual_deep           : v29,
            residual_sui            : v30,
            residual_usdc           : v31,
            tick_lower              : v19,
            tick_upper              : v20,
        };
        0x2::event::emit<T_3kz5nkps3l>(v32);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg22));
        let v33 = 0x2::tx_context::sender(arg22);
        f_jk6cxnkjme<T0>(v8, v33, arg22);
        let v34 = 0x2::tx_context::sender(arg22);
        f_jk6cxnkjme<T1>(v7, v34, arg22);
        let v35 = 0x2::tx_context::sender(arg22);
        f_jk6cxnkjme<T2>(v14, v35, arg22);
    }

    public fun f_mdiqwuuo3w<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x2::coin::into_balance<T1>(arg8);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 >= arg9 + arg10, 7);
        let v2 = f_c4ffbqp2ie<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v0, arg9));
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = f_bu4nlbma3l<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T1>(&mut v0, arg10));
        let v5 = 0x2::balance::value<T2>(&v4);
        let v6 = if (arg11 == 18446744073709551615) {
            if (arg12) {
                assert!(v3 > arg15, 8);
                v3 - arg15
            } else {
                assert!(v5 > arg17, 9);
                v5 - arg17
            }
        } else {
            arg11
        };
        let (v7, v8, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg3, arg5, arg7, v2, v4, v6, arg12);
        let v11 = v10;
        let v12 = v9;
        let v13 = 0x2::balance::value<T0>(&v12);
        let v14 = 0x2::balance::value<T1>(&v0);
        let v15 = 0x2::balance::value<T2>(&v11);
        assert!(v7 >= arg13, 8);
        assert!(v8 >= arg14, 9);
        assert!(v13 <= arg15, 10);
        assert!(v14 <= arg16, 11);
        assert!(v15 <= arg17, 11);
        let v16 = T_fkvklvwuxs{
            route_id       : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
            position_id    : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg7),
            input_sui      : v1,
            sui_to_deep    : arg9,
            deep_out       : v3,
            sui_to_usdc    : arg10,
            usdc_out       : v5,
            deposited_deep : v7,
            deposited_usdc : v8,
            residual_deep  : v13,
            residual_sui   : v14,
            residual_usdc  : v15,
        };
        0x2::event::emit<T_fkvklvwuxs>(v16);
        let v17 = 0x2::tx_context::sender(arg18);
        f_jk6cxnkjme<T0>(v12, v17, arg18);
        let v18 = 0x2::tx_context::sender(arg18);
        f_jk6cxnkjme<T1>(v0, v18, arg18);
        let v19 = 0x2::tx_context::sender(arg18);
        f_jk6cxnkjme<T2>(v11, v19, arg18);
    }

    public fun f_mdv33ttpbd<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: bool, arg9: u64, arg10: u32, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, &mut arg7);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T2>(arg0, arg3, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T2>(&v7);
        assert!(v9 >= arg13, 4);
        assert!(v10 >= arg14, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, v6);
        let v12 = f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, v5);
        0x2::balance::join<T1>(&mut v11, v12);
        let v13 = 0x2::balance::value<T1>(&v11);
        assert!(v13 >= arg15, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v14 = if (arg9 == 0) {
            0
        } else if (arg8) {
            assert!(0x2::balance::value<T0>(&v8) >= arg9, 7);
            let v15 = f_bu4nlbma3l<T1, T2>(arg0, arg3, arg6, f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v8, arg9)));
            0x2::balance::join<T2>(&mut v7, v15);
            0x2::balance::value<T2>(&v15)
        } else {
            assert!(0x2::balance::value<T2>(&v7) >= arg9, 7);
            let v16 = f_c4ffbqp2ie<T0, T1>(arg0, arg3, arg4, f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T2>(&mut v7, arg9)));
            0x2::balance::join<T0>(&mut v8, v16);
            0x2::balance::value<T0>(&v16)
        };
        let (v17, v18) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg5), arg10, 1);
        let v19 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T2>(arg3, arg5, v17, v18, arg20);
        let v20 = if (arg11 == 18446744073709551615) {
            if (arg12) {
                let v21 = 0x2::balance::value<T0>(&v8);
                assert!(v21 > arg18, 8);
                v21 - arg18
            } else {
                let v22 = 0x2::balance::value<T2>(&v7);
                assert!(v22 > arg19, 9);
                v22 - arg19
            }
        } else {
            arg11
        };
        let (v23, v24, v25, v26) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg3, arg5, &mut v19, v8, v7, v20, arg12);
        v8 = v25;
        v7 = v26;
        let v27 = 0x2::balance::value<T0>(&v8);
        let v28 = 0x2::balance::value<T2>(&v7);
        assert!(v23 >= arg16, 8);
        assert!(v24 >= arg17, 9);
        assert!(v27 <= arg18, 10);
        assert!(v28 <= arg19, 11);
        let v29 = T_gpm75ke2wc{
            route_id                : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
            source_position_id      : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v19),
            reward_deep             : 0x2::balance::value<T0>(&v0),
            fee_deep                : 0x2::balance::value<T0>(&v6),
            fee_usdc                : 0x2::balance::value<T2>(&v5),
            profit_sui              : v13,
            source_principal_deep   : v9,
            source_principal_usdc   : v10,
            swap_deep_to_usdc       : arg8,
            swap_input              : arg9,
            swap_output             : v14,
            deposited_deep          : v23,
            deposited_usdc          : v24,
            residual_deep           : v27,
            residual_usdc           : v28,
            tick_lower              : v17,
            tick_upper              : v18,
        };
        0x2::event::emit<T_gpm75ke2wc>(v29);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v19, 0x2::tx_context::sender(arg20));
        let v30 = 0x2::tx_context::sender(arg20);
        f_jk6cxnkjme<T0>(v8, v30, arg20);
        let v31 = 0x2::tx_context::sender(arg20);
        f_jk6cxnkjme<T2>(v7, v31, arg20);
    }

    public fun f_mopah36tcb<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_6q63tjexs3<T0, T1, T2, T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg8: &mut T_b2qzkyfcoy<T2>, arg9: u64) {
        f_544rze3u32(arg1);
        f_73iy37j75h<T0, T1, T2, T3>(arg1, arg2, arg4, arg7);
        f_femq3j54qj<T0, T1, T2>(arg4, arg5, arg8);
        assert!(arg8.reward_count < arg8.expected_reward_count, 13);
        let v0 = 0x1::type_name::with_original_ids<T3>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg8.reward_types, &v0), 13);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T3>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = f_qaaj652tac<T3, T2>(arg0, arg3, arg7, v1);
        assert!(0x2::balance::value<T2>(&v2) >= arg9, 6);
        0x2::balance::join<T2>(&mut arg8.reward_sui, v2);
        arg8.reward_count = arg8.reward_count + 1;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg8.reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg8.reward_amounts, 0x2::balance::value<T3>(&v1));
    }

    public fun f_mvx4uvdo2d<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        assert!(arg1.expected_reward_count == 1, 13);
        f_nrbwjbbixy<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun f_nf63pwnxpm<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_cyke2d2qxe<T0, T1>, arg3: T_gexrfk364t<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x2::balance::Balance<T1>, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u32, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: bool, arg24: &mut 0x2::tx_context::TxContext) {
        f_544rze3u32(arg1);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg1);
        let v1 = 0x2::object::id<T_cyke2d2qxe<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v3 = arg2.owner_authority;
        assert!(arg2.registry_id == v0, 1);
        assert!(arg2.bluefin_pool_id == v2, 12);
        assert!(v3 == 0x2::tx_context::sender(arg24), 15);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.route_id == v1, 1);
        assert!(arg3.bluefin_pool_id == v2, 12);
        assert!(arg3.cetus_pool_id == arg2.cetus_pool_id, 12);
        assert!(arg3.owner_authority == v3, 15);
        assert!(arg16 == 2 || arg16 == 4, 20);
        let v4 = 0x2::balance::value<T1>(&arg8);
        assert!(v4 >= arg3.fee_sui, 22);
        let v5 = v4 - arg3.fee_sui;
        if (arg23) {
            assert!(arg9 == v5, 22);
        };
        if (arg3.income_deep == 0) {
            assert!(v5 == 0, 22);
            assert!(arg10 == 0, 6);
        } else {
            assert!(arg10 > 0, 6);
            assert!(v5 >= arg10, 6);
        };
        assert!(v4 >= arg11, 6);
        if (v4 > 0) {
            0x2::balance::send_funds<T1>(arg8, arg1.profit_recipient);
        } else {
            0x2::balance::destroy_zero<T1>(arg8);
        };
        let v6 = 0x2::balance::value<T0>(&arg6);
        let v7 = 0x2::balance::value<T1>(&arg7);
        let v8 = if (arg13 == 0) {
            assert!(arg15 == 0, 7);
            assert!(v6 == arg3.principal_deep_before_swap, 22);
            assert!(v7 == arg3.principal_sui_before_swap, 22);
            0
        } else if (arg12) {
            assert!(arg15 > 0, 7);
            assert!(arg3.principal_deep_before_swap >= arg13, 7);
            assert!(v6 <= arg3.principal_deep_before_swap, 22);
            assert!(v6 + arg13 == arg3.principal_deep_before_swap, 22);
            assert!(v7 >= arg3.principal_sui_before_swap, 22);
            v7 - arg3.principal_sui_before_swap
        } else {
            assert!(arg15 > 0, 7);
            assert!(arg3.principal_sui_before_swap >= arg13, 7);
            assert!(v7 <= arg3.principal_sui_before_swap, 22);
            assert!(v7 + arg13 == arg3.principal_sui_before_swap, 22);
            assert!(v6 >= arg3.principal_deep_before_swap, 22);
            v6 - arg3.principal_deep_before_swap
        };
        if (arg23) {
            assert!(arg14 == v8, 22);
        };
        assert!(v8 >= arg15, 7);
        let (v9, v10) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg16, 1);
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v9, v10, arg24);
        let v12 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v11);
        let (v13, v14, v15, v16) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v11, arg6, arg7, arg17, arg18);
        let v17 = v16;
        let v18 = v15;
        let v19 = 0x2::balance::value<T0>(&v18);
        let v20 = 0x2::balance::value<T1>(&v17);
        assert!(v13 >= arg19, 8);
        assert!(v14 >= arg20, 9);
        assert!(v19 <= arg21, 10);
        assert!(v20 <= arg22, 11);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v11);
        assert!(v21 > 0, 21);
        let v22 = T_ooc7i2sp27<T0, T1>{
            id                  : 0x2::object::new(arg24),
            registry_id         : v0,
            bluefin_pool_id     : v2,
            bluefin_position_id : v12,
            owner_authority     : v3,
            tick_lower          : v9,
            tick_upper          : v10,
        };
        let v23 = 0x2::object::id<T_ooc7i2sp27<T0, T1>>(&v22);
        let v24 = T_nmzuqxolwi{
            registry_id                   : v0,
            route_id                      : v1,
            source_allocation_cap_id      : arg3.source_allocation_cap_id,
            replacement_allocation_cap_id : v23,
            bluefin_pool_id               : v2,
            cetus_pool_id                 : arg3.cetus_pool_id,
            source_position_id            : arg3.source_position_id,
            destination_position_id       : v12,
            owner_authority               : v3,
            source_liquidity              : arg3.source_liquidity,
            replacement_liquidity         : v21,
            source_tick_lower             : arg3.source_tick_lower,
            source_tick_upper             : arg3.source_tick_upper,
            reward_deep                   : arg3.reward_deep,
            fee_deep                      : arg3.fee_deep,
            fee_sui                       : arg3.fee_sui,
            income_deep_input             : arg3.income_deep,
            income_deep_as_sui            : v5,
            profit_sui                    : v4,
            source_principal_deep         : arg3.source_principal_deep,
            source_principal_sui          : arg3.source_principal_sui,
            supplied_principal_deep       : arg3.supplied_principal_deep,
            supplied_principal_sui        : arg3.supplied_principal_sui,
            principal_swap_deep_to_sui    : arg12,
            principal_swap_input          : arg13,
            principal_swap_output         : v8,
            tick_lower                    : v9,
            tick_upper                    : v10,
            deposited_deep                : v13,
            deposited_sui                 : v14,
            residual_deep                 : v19,
            residual_sui                  : v20,
        };
        0x2::event::emit<T_nmzuqxolwi>(v24);
        let v25 = T_mz37rife4q{
            registry_id             : v0,
            route_id                : v1,
            source_cap_id           : arg3.source_allocation_cap_id,
            replacement_cap_id      : v23,
            source_position_id      : arg3.source_position_id,
            replacement_position_id : v12,
            bluefin_pool_id         : v2,
            owner_authority         : v3,
            source_tick_lower       : arg3.source_tick_lower,
            source_tick_upper       : arg3.source_tick_upper,
            replacement_tick_lower  : v9,
            replacement_tick_upper  : v10,
        };
        0x2::event::emit<T_mz37rife4q>(v25);
        let T_gexrfk364t {
            registry_id                : _,
            route_id                   : _,
            bluefin_pool_id            : _,
            cetus_pool_id              : _,
            owner_authority            : _,
            source_allocation_cap_id   : _,
            source_position_id         : _,
            source_liquidity           : _,
            source_tick_lower          : _,
            source_tick_upper          : _,
            reward_deep                : _,
            fee_deep                   : _,
            fee_sui                    : _,
            income_deep                : _,
            source_principal_deep      : _,
            source_principal_sui       : _,
            supplied_principal_deep    : _,
            supplied_principal_sui     : _,
            principal_deep_before_swap : _,
            principal_sui_before_swap  : _,
        } = arg3;
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v11, v3);
        0x2::transfer::public_transfer<T_ooc7i2sp27<T0, T1>>(v22, v3);
        f_jk6cxnkjme<T0>(v18, v3, arg24);
        f_jk6cxnkjme<T1>(v17, v3, arg24);
    }

    fun f_nffcbvjolt<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
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

    public fun f_nrbwjbbixy<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        f_yq55f2eibc<T0, T1>(arg0, arg1, arg2);
        T_b2qzkyfcoy<T1>{
            source_pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            position_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3),
            reward_count          : 0,
            expected_reward_count : arg1.expected_reward_count,
            reward_types          : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reward_amounts        : vector[],
            reward_sui            : 0x2::balance::zero<T1>(),
        }
    }

    fun f_o7zn4sd4fo<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u64, arg10: u64, arg11: u32, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: &mut 0x2::tx_context::TxContext) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg3, arg4, &mut arg7);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T1>(arg0, arg3, arg4, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        assert!(v9 >= arg17, 4);
        assert!(v10 >= arg18, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, v6);
        0x2::balance::join<T1>(&mut v11, v5);
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg19, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        assert!(0x2::balance::value<T0>(&v8) >= arg8, 7);
        let v13 = 0x2::balance::split<T0>(&mut v8, arg8);
        if (0x2::balance::value<T1>(&v7) < arg9) {
            assert!(0x2::balance::value<T0>(&v8) >= arg8, 7);
            let v14 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v8, arg8));
            0x2::balance::join<T1>(&mut v7, v14);
        };
        assert!(0x2::balance::value<T1>(&v7) >= arg9, 7);
        let v15 = f_bu4nlbma3l<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T1>(&mut v7, arg9));
        let v16 = v15;
        if (arg10 > 0) {
            assert!(0x2::balance::value<T1>(&v7) >= arg10, 7);
            let v17 = f_c4ffbqp2ie<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v7, arg10));
            0x2::balance::join<T0>(&mut v8, v17);
        };
        let (v18, v19) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg4), arg11, 1);
        let v20 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg4, v18, v19, arg27);
        let (v21, v22, v23, v24) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg3, arg4, &mut v20, v8, v7, arg13, arg14);
        v8 = v23;
        v7 = v24;
        let (v25, v26) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg5), arg12, 1);
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
        let v35 = T_dcdkys6rqi{
            route_id               : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
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
        0x2::event::emit<T_dcdkys6rqi>(v35);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v20, 0x2::tx_context::sender(arg27));
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v27, 0x2::tx_context::sender(arg27));
        let v36 = 0x2::tx_context::sender(arg27);
        f_jk6cxnkjme<T0>(v8, v36, arg27);
        let v37 = 0x2::tx_context::sender(arg27);
        f_jk6cxnkjme<T1>(v7, v37, arg27);
        let v38 = 0x2::tx_context::sender(arg27);
        f_jk6cxnkjme<T2>(v16, v38, arg27);
    }

    public fun f_ohb377aipg<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u32, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        f_5fdzll7c7q<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public fun f_ohcn35erzz<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_firwujlzgn<T0, T1, T2, T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T1>, arg8: T_b2qzkyfcoy<T1>, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        f_bti62a7pgx<T0, T1, T2, T3>(arg1, arg2, arg10, arg4, arg6, arg7);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4);
        assert!(arg8.expected_reward_count == arg2.expected_reward_count, 13);
        let (v1, v2) = f_55o2ioxfmc<T2, T3, T1>(arg4, &arg5, arg8);
        let v3 = v2;
        let (v4, v5, v6, v7) = f_nffcbvjolt<T2, T3>(arg0, arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T2>(&v11);
        let v13 = 0x2::balance::value<T3>(&v10);
        assert!(v12 >= arg15, 4);
        assert!(v13 >= arg16, 5);
        let v14 = f_bginnogns7<T2, T3, T1>(arg0, arg3, arg6, arg7, v9, v8, v3);
        let v15 = 0x2::balance::value<T1>(&v14);
        assert!(v15 >= arg18, 6);
        0x2::balance::send_funds<T1>(v14, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v16 = f_qaaj652tac<T2, T1>(arg0, arg3, arg6, v11);
        0x2::balance::join<T1>(&mut v16, f_qaaj652tac<T3, T1>(arg0, arg3, arg7, v10));
        let v17 = 0x2::balance::value<T1>(&v16);
        assert!(v17 >= arg17, 5);
        assert!(v17 >= arg11, 7);
        let v18 = f_c4ffbqp2ie<T0, T1>(arg0, arg9, arg10, 0x2::balance::split<T1>(&mut v16, arg11));
        let (v19, v20) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg10), arg12, 1);
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
        let v30 = T_khgkiuh77r{
            route_id                : 0x2::object::id<T_firwujlzgn<T0, T1, T2, T3>>(arg2),
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
        0x2::event::emit<T_khgkiuh77r>(v30);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg23));
        let v31 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T0>(v27, v31, arg23);
        let v32 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T1>(v26, v32, arg23);
    }

    public fun f_oiuhcecg6b<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_egfxhjnl23<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T2> {
        assert!(arg1.expected_reward_count == 2, 13);
        f_v7oysm456v<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun f_olyrew5rw4<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg0);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3);
        let v3 = T_6q63tjexs3<T0, T1, T1, T2>{
            id                 : 0x2::object::new(arg4),
            registry_id        : v0,
            cetus_pool_id      : v1,
            reward_sui_pool_id : v2,
        };
        let v4 = T_42oy2hnj7u{
            registry_id        : v0,
            reward_route_id    : 0x2::object::id<T_6q63tjexs3<T0, T1, T1, T2>>(&v3),
            cetus_pool_id      : v1,
            reward_sui_pool_id : v2,
            direct_sui         : false,
        };
        0x2::event::emit<T_42oy2hnj7u>(v4);
        0x2::transfer::public_transfer<T_6q63tjexs3<T0, T1, T1, T2>>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun f_pp6v7j62pm<T0, T1, T2, T3, T4>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T4>());
        f_73sxgdbci3<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun f_pyetovrkt4<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_jf5gusnm2a<T0, T1>, arg3: &T_mxzfe3z2ef<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: T_b2qzkyfcoy<T1>, arg8: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg9: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg10: bool, arg11: u64, arg12: u32, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        f_yq55f2eibc<T0, T1>(arg1, arg2, arg5);
        f_acy22dxebs<T0, T1>(arg1, arg3, arg5, arg9);
        f_h76ndz3c44<T1>(&arg7, &arg2.expected_reward_types);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5);
        let (v1, v2) = f_55o2ioxfmc<T0, T1, T1>(arg5, &arg6, arg7);
        let v3 = v2;
        let (v4, v5, v6, v7) = f_nffcbvjolt<T0, T1>(arg0, arg4, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg15, 4);
        assert!(v13 >= arg16, 5);
        let v14 = f_bu4nlbma3l<T0, T1>(arg0, arg8, arg9, v9);
        0x2::balance::join<T1>(&mut v3, v14);
        0x2::balance::join<T1>(&mut v3, v8);
        let v15 = 0x2::balance::value<T1>(&v3);
        assert!(v15 >= arg17, 6);
        0x2::balance::send_funds<T1>(v3, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v16 = 0;
        if (arg11 > 0) {
            if (arg10) {
                assert!(0x2::balance::value<T0>(&v11) >= arg11, 7);
                let v17 = f_bu4nlbma3l<T0, T1>(arg0, arg8, arg9, 0x2::balance::split<T0>(&mut v11, arg11));
                v16 = 0x2::balance::value<T1>(&v17);
                0x2::balance::join<T1>(&mut v10, v17);
            } else {
                assert!(0x2::balance::value<T1>(&v10) >= arg11, 7);
                let v18 = f_c4ffbqp2ie<T0, T1>(arg0, arg8, arg9, 0x2::balance::split<T1>(&mut v10, arg11));
                v16 = 0x2::balance::value<T0>(&v18);
                0x2::balance::join<T0>(&mut v11, v18);
            };
        };
        let (v19, v20) = f_je4ayhnzei(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5), arg12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg5));
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
        let v29 = T_ffxknvwuk2{
            route_id                : 0x2::object::id<T_jf5gusnm2a<T0, T1>>(arg2),
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
        0x2::event::emit<T_ffxknvwuk2>(v29);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v21, 0x2::tx_context::sender(arg22));
        let v30 = 0x2::tx_context::sender(arg22);
        f_jk6cxnkjme<T0>(v11, v30, arg22);
        let v31 = 0x2::tx_context::sender(arg22);
        f_jk6cxnkjme<T1>(v10, v31, arg22);
    }

    public fun f_pyphaevxui<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_6q63tjexs3<T0, T1, T1, T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut T_b2qzkyfcoy<T1>, arg8: u64) {
        f_544rze3u32(arg1);
        f_73iy37j75h<T0, T1, T1, T0>(arg1, arg2, arg4, arg4);
        f_femq3j54qj<T0, T1, T1>(arg4, arg5, arg7);
        assert!(arg7.reward_count < arg7.expected_reward_count, 13);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg7.reward_types, &v0), 13);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = f_qaaj652tac<T0, T1>(arg0, arg3, arg4, v1);
        assert!(0x2::balance::value<T1>(&v2) >= arg8, 6);
        0x2::balance::join<T1>(&mut arg7.reward_sui, v2);
        arg7.reward_count = arg7.reward_count + 1;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg7.reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg7.reward_amounts, 0x2::balance::value<T0>(&v1));
    }

    fun f_pzzwrq6ooc(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : (u32, u32) {
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

    public fun f_q2s2ynuy5s<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>, arg5: u32, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>>(arg4));
        f_jlsunzyj4h<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v0, arg5, arg6, arg7);
    }

    fun f_qaaj652tac<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
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

    public fun f_qphdhxe7ci<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = T_ony7fldlkz<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<T_mxfoob7xa4>(arg0),
        };
        let v1 = T_pg3wrruijq{
            registry_id  : 0x2::object::id<T_mxfoob7xa4>(arg0),
            adapter_kind : 2,
        };
        0x2::event::emit<T_pg3wrruijq>(v1);
        0x2::transfer::public_transfer<T_ony7fldlkz<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun f_qxp7l7tqe2<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_egfxhjnl23<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T2> {
        assert!(arg1.expected_reward_count == 3, 13);
        f_v7oysm456v<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun f_r3bimc2tgi<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        assert!(arg1.expected_reward_count == 0, 13);
        f_nrbwjbbixy<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun f_r6xm6lybcg<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_xm5f56dnqx<T0, T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>) {
        f_544rze3u32(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>(arg3), 12);
    }

    public fun f_rg5ewziipj<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T1> {
        assert!(arg1.expected_reward_count == 0, 13);
        f_nrbwjbbixy<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun f_rheym3dvtv<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_ooc7i2sp27<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &0x2::tx_context::TxContext) {
        f_544rze3u32(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.bluefin_pool_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 12);
        assert!(arg1.bluefin_position_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), 14);
        assert!(arg1.owner_authority == 0x2::tx_context::sender(arg4), 15);
    }

    fun f_ri5xyeurpi<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_egfxhjnl23<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        f_544rze3u32(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
    }

    public fun f_s7hao3l475<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_egfxhjnl23<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T2> {
        assert!(arg1.expected_reward_count == 1, 13);
        f_v7oysm456v<T0, T1, T2>(arg0, arg1, arg2, arg3)
    }

    public fun f_t2asdhfmgm<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_ooc7i2sp27<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg6: u128, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        f_rheym3dvtv<T0, T1>(arg1, arg2, arg4, arg5, arg10);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg5);
        assert!(arg6 > 0, 16);
        assert!(v0 > arg6, 16);
        assert!(arg6 <= v0 / 2, 17);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg4, arg5, arg6, arg0);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg5);
        assert!(v7 == v0 - arg6, 16);
        assert!(v7 >= arg9, 18);
        let v8 = 0x2::balance::value<T0>(&v6);
        let v9 = 0x2::balance::value<T1>(&v5);
        assert!(v8 >= arg7, 4);
        assert!(v9 >= arg8, 5);
        let v10 = T_aupl55qkhu{
            route_id           : 0x2::object::id<T_ooc7i2sp27<T0, T1>>(arg2),
            source_pool_id     : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg4),
            source_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg5),
            liquidity_before   : v0,
            liquidity_delta    : arg6,
            liquidity_after    : v7,
            output_deep        : v8,
            output_sui         : v9,
        };
        0x2::event::emit<T_aupl55qkhu>(v10);
        (v6, v5)
    }

    public fun f_tcbhwmrnnc<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64, arg9: u64, arg10: u32, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: bool, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: &mut 0x2::tx_context::TxContext) {
        f_o7zn4sd4fo<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26);
    }

    public fun f_tm7h5otehv<T0, T1, T2, T3, T4, T5>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T4>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::with_original_ids<T5>());
        f_73sxgdbci3<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun f_u2ub2xavt3<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_xm5f56dnqx<T0, T1, T2>, arg3: &T_ffbhaz5mux<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: u64, arg10: u64, arg11: u64, arg12: u32, arg13: u32, arg14: u64, arg15: bool, arg16: u64, arg17: bool, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: &mut 0x2::tx_context::TxContext) {
        f_r6xm6lybcg<T0, T1, T2>(arg1, arg2, arg5, arg8);
        f_wzox2mblzz<T0, T1>(arg1, arg3);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T0>(arg0, arg4, arg5, &mut arg6);
        let (v2, v3, v4, v5) = f_bmn6w76gxr<T0, T1>(arg0, arg4, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        assert!(v10 >= arg18, 4);
        assert!(v11 >= arg19, 5);
        0x2::balance::join<T0>(&mut v7, v1);
        let v12 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, v7);
        0x2::balance::join<T1>(&mut v12, v6);
        let v13 = 0x2::balance::value<T1>(&v12);
        assert!(v13 >= arg21, 6);
        0x2::balance::send_funds<T1>(v12, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v14 = f_bu4nlbma3l<T0, T1>(arg0, arg4, arg5, v9);
        0x2::balance::join<T1>(&mut v8, v14);
        let v15 = 0x2::balance::value<T1>(&v8);
        assert!(v15 >= arg20, 5);
        assert!(0x2::balance::value<T1>(&v8) >= arg10, 7);
        let v16 = f_dpuj5ffjbe<T2, T1>(arg0, arg7, arg8, 0x2::balance::split<T1>(&mut v8, arg10));
        assert!(0x2::balance::value<T1>(&v8) >= arg11, 7);
        let v17 = 0x2::balance::split<T1>(&mut v8, arg11);
        assert!(0x2::balance::value<T1>(&v8) >= arg9, 7);
        let v18 = f_c4ffbqp2ie<T0, T1>(arg0, arg4, arg5, 0x2::balance::split<T1>(&mut v8, arg9));
        let (v19, v20) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg5), arg12, 1);
        let v21 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg5, v19, v20, arg30);
        let (v22, v23, v24, v25) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg4, arg5, &mut v21, v18, v8, arg14, arg15);
        let v26 = v25;
        let v27 = v24;
        let (v28, v29) = f_je4ayhnzei(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T2, T1>(arg8), arg13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T2, T1>(arg8));
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
        let v38 = T_neomuo6i3a{
            route_id                    : 0x2::object::id<T_xm5f56dnqx<T0, T1, T2>>(arg2),
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
        0x2::event::emit<T_neomuo6i3a>(v38);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v21, 0x2::tx_context::sender(arg30));
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v30, 0x2::tx_context::sender(arg30));
        0x2::balance::join<T1>(&mut v26, v17);
        let v39 = 0x2::tx_context::sender(arg30);
        f_jk6cxnkjme<T0>(v27, v39, arg30);
        let v40 = 0x2::tx_context::sender(arg30);
        f_jk6cxnkjme<T1>(v26, v40, arg30);
        let v41 = 0x2::tx_context::sender(arg30);
        f_jk6cxnkjme<T2>(v16, v41, arg30);
    }

    public(friend) fun f_uxgus47d27(arg0: u32, arg1: u32, arg2: u32) : (u32, u32) {
        f_je4ayhnzei(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0), arg1, arg2)
    }

    public fun f_v36oudzi2x<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = T_ffbhaz5mux<T0, T1>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<T_mxfoob7xa4>(arg0),
        };
        let v1 = T_pg3wrruijq{
            registry_id  : 0x2::object::id<T_mxfoob7xa4>(arg0),
            adapter_kind : 3,
        };
        0x2::event::emit<T_pg3wrruijq>(v1);
        0x2::transfer::public_transfer<T_ffbhaz5mux<T0, T1>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun f_v7oysm456v<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_egfxhjnl23<T0, T1, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : T_b2qzkyfcoy<T2> {
        f_ri5xyeurpi<T0, T1, T2>(arg0, arg1, arg2);
        T_b2qzkyfcoy<T2>{
            source_pool_id        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            position_id           : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3),
            reward_count          : 0,
            expected_reward_count : arg1.expected_reward_count,
            reward_types          : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reward_amounts        : vector[],
            reward_sui            : 0x2::balance::zero<T2>(),
        }
    }

    fun f_vcqbamacfl<T0, T1>(arg0: &T_jf5gusnm2a<T0, T1>) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.expected_reward_types)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.expected_reward_types, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun f_vhqnhbghpl<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_egfxhjnl23<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg8: T_b2qzkyfcoy<T2>, arg9: bool, arg10: u64, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) {
        f_3tscjyxrml<T0, T1, T2>(arg1, arg2, arg4, arg6, arg7);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4);
        assert!(arg8.expected_reward_count == arg2.expected_reward_count, 13);
        let (v1, v2) = f_55o2ioxfmc<T0, T1, T2>(arg4, &arg5, arg8);
        let v3 = v2;
        let (v4, v5, v6, v7) = f_nffcbvjolt<T0, T1>(arg0, arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T0>(&v11);
        let v13 = 0x2::balance::value<T1>(&v10);
        assert!(v12 >= arg14, 4);
        assert!(v13 >= arg15, 5);
        let v14 = f_bginnogns7<T0, T1, T2>(arg0, arg3, arg6, arg7, v9, v8, v3);
        let v15 = 0x2::balance::value<T2>(&v14);
        assert!(v15 >= arg16, 6);
        0x2::balance::send_funds<T2>(v14, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v16 = 0;
        if (arg10 > 0) {
            if (arg9) {
                assert!(0x2::balance::value<T0>(&v11) >= arg10, 7);
                let v17 = f_qaaj652tac<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut v11, arg10));
                v16 = 0x2::balance::value<T1>(&v17);
                0x2::balance::join<T1>(&mut v10, v17);
            } else {
                assert!(0x2::balance::value<T1>(&v10) >= arg10, 7);
                let v18 = f_dpuj5ffjbe<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v10, arg10));
                v16 = 0x2::balance::value<T0>(&v18);
                0x2::balance::join<T0>(&mut v11, v18);
            };
        };
        let (v19, v20) = f_je4ayhnzei(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg4), arg11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4));
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
        let v27 = T_ggnn4cyo76{
            route_id                : 0x2::object::id<T_egfxhjnl23<T0, T1, T2>>(arg2),
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
        0x2::event::emit<T_ggnn4cyo76>(v27);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v21, 0x2::tx_context::sender(arg21));
        let v28 = 0x2::tx_context::sender(arg21);
        f_jk6cxnkjme<T0>(v11, v28, arg21);
        let v29 = 0x2::tx_context::sender(arg21);
        f_jk6cxnkjme<T1>(v10, v29, arg21);
    }

    public fun f_vn5wejmayt<T0, T1, T2>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &mut 0x2::tx_context::TxContext) {
        f_zyotjhy6mn(arg0, arg1);
        let v0 = T_3wk4gy3ybf<T0, T1, T2>{
            id          : 0x2::object::new(arg2),
            registry_id : 0x2::object::id<T_mxfoob7xa4>(arg0),
        };
        let v1 = T_pg3wrruijq{
            registry_id  : 0x2::object::id<T_mxfoob7xa4>(arg0),
            adapter_kind : 4,
        };
        0x2::event::emit<T_pg3wrruijq>(v1);
        0x2::transfer::public_transfer<T_3wk4gy3ybf<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun f_vqd6htlvwm<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>, arg3: T_pnb4cyyddi<T0, T1, T2>, arg4: T_ooc7i2sp27<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: u128, arg11: u32, arg12: u32, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, T_jqabux35vc<T0, T1, T2, T3, T4, T5>) {
        f_jfvr7fjrid<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg15);
        let v0 = 0x2::object::id<T_mxfoob7xa4>(arg1);
        let v1 = 0x2::object::id<T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>>(arg2);
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6);
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7);
        let v4 = arg2.owner_authority;
        assert!(arg2.source_bluefin_pool_id == v2, 12);
        assert!(arg3.registry_id == v0, 1);
        assert!(arg3.bluefin_pool_id == v2, 12);
        assert!(arg3.bluefin_position_id == v3, 14);
        assert!(arg3.owner_authority == v4, 15);
        assert!(arg3.tick_lower == arg11, 3);
        assert!(arg3.tick_upper == arg12, 3);
        assert!(arg4.registry_id == v0, 1);
        assert!(arg4.bluefin_pool_id == v2, 12);
        assert!(arg4.bluefin_position_id == v3, 14);
        assert!(arg4.owner_authority == v4, 15);
        assert!(arg4.tick_lower == arg11, 3);
        assert!(arg4.tick_upper == arg12, 3);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg11), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg12)), 3);
        let v5 = 0x2::object::id<T_pnb4cyyddi<T0, T1, T2>>(&arg3);
        let v6 = 0x2::object::id<T_ooc7i2sp27<T0, T1>>(&arg4);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg7);
        assert!(v7 > 0, 21);
        assert!(v7 == arg10, 21);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg5, arg6, &mut arg7);
        let v9 = 0x2::balance::value<T2>(&v8);
        let (v10, v11, v12, v13) = f_bmn6w76gxr<T0, T1>(arg0, arg5, arg6, arg7);
        let v14 = v13;
        let v15 = v12;
        let v16 = v11;
        let v17 = v10;
        let v18 = 0x2::balance::value<T0>(&v17);
        let v19 = 0x2::balance::value<T1>(&v16);
        let v20 = 0x2::balance::value<T0>(&v15);
        let v21 = 0x2::balance::value<T1>(&v14);
        assert!(v18 >= arg13, 4);
        assert!(v19 >= arg14, 5);
        let v22 = 0x2::balance::value<T0>(&arg8);
        let v23 = 0x2::balance::value<T1>(&arg9);
        0x2::balance::join<T0>(&mut v17, arg8);
        0x2::balance::join<T1>(&mut v16, arg9);
        let v24 = 0x2::balance::value<T0>(&v17);
        let v25 = 0x2::balance::value<T1>(&v16);
        let v26 = T_jqabux35vc<T0, T1, T2, T3, T4, T5>{
            registry_id                  : v0,
            route_id                     : v1,
            source_bluefin_pool_id       : v2,
            target_bluefin_pool_id       : arg2.target_bluefin_pool_id,
            owner_authority              : v4,
            source_managed_cap_id        : v5,
            source_allocation_cap_id     : v6,
            source_position_id           : v3,
            source_liquidity             : v7,
            source_tick_lower            : arg11,
            source_tick_upper            : arg12,
            reward_amount                : v9,
            fee_a                        : v20,
            fee_b                        : v21,
            source_principal_a           : v18,
            source_principal_b           : v19,
            supplied_principal_a         : v22,
            supplied_principal_b         : v23,
            total_principal_a            : v24,
            total_principal_b            : v25,
            authenticated_cetus_pool_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v27 = T_lh5ool3awd{
            registry_id              : v0,
            route_id                 : v1,
            source_managed_cap_id    : v5,
            source_allocation_cap_id : v6,
            source_bluefin_pool_id   : v2,
            target_bluefin_pool_id   : arg2.target_bluefin_pool_id,
            source_position_id       : v3,
            owner_authority          : v4,
            source_liquidity         : v7,
            source_tick_lower        : arg11,
            source_tick_upper        : arg12,
            reward_amount            : v9,
            fee_a                    : v20,
            fee_b                    : v21,
            source_principal_a       : v18,
            source_principal_b       : v19,
            supplied_principal_a     : v22,
            supplied_principal_b     : v23,
            total_principal_a        : v24,
            total_principal_b        : v25,
        };
        0x2::event::emit<T_lh5ool3awd>(v27);
        let T_pnb4cyyddi {
            id                  : v28,
            registry_id         : _,
            bluefin_pool_id     : _,
            bluefin_position_id : _,
            owner_authority     : _,
            tick_lower          : _,
            tick_upper          : _,
        } = arg3;
        let T_ooc7i2sp27 {
            id                  : v35,
            registry_id         : _,
            bluefin_pool_id     : _,
            bluefin_position_id : _,
            owner_authority     : _,
            tick_lower          : _,
            tick_upper          : _,
        } = arg4;
        0x2::object::delete(v28);
        0x2::object::delete(v35);
        (v17, v16, v8, v15, v14, v26)
    }

    public fun f_vtvqttvkpm<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_gc6rj26lvo, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg8: u64) {
        f_544rze3u32(arg1);
        f_zyotjhy6mn(arg1, arg2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg3, arg4, arg5, arg6, true, arg0);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg3, arg4, arg5, arg6, true, arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg4, arg5, arg6, true, arg0);
        let v3 = f_qaaj652tac<T2, T1>(arg0, arg3, arg7, v2);
        0x2::balance::join<T1>(&mut v1, f_qaaj652tac<T0, T1>(arg0, arg3, arg4, v0));
        0x2::balance::join<T1>(&mut v1, v3);
        let v4 = 0x2::balance::value<T1>(&v1);
        assert!(v4 >= arg8, 6);
        let v5 = T_cvwku25yiz{
            reward_x        : 0x2::balance::value<T0>(&v0),
            reward_sui      : 0x2::balance::value<T1>(&v1),
            reward_external : 0x2::balance::value<T2>(&v2),
            external_as_sui : 0x2::balance::value<T1>(&v3),
            profit_sui      : v4,
        };
        0x2::event::emit<T_cvwku25yiz>(v5);
        0x2::balance::send_funds<T1>(v1, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
    }

    public fun f_wh3c7vkhp7<T0, T1>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_cyke2d2qxe<T0, T1>, arg3: T_gexrfk364t<T0, T1>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x2::balance::Balance<T1>, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u32, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        f_nf63pwnxpm<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, true, arg23);
    }

    public fun f_woxatlemgu<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u32, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, &mut arg7);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T2>(arg0, arg3, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T2>(&v7);
        assert!(v9 >= arg14, 4);
        assert!(v10 >= arg15, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, v6);
        let v12 = f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, v5);
        0x2::balance::join<T1>(&mut v11, v12);
        let v13 = 0x2::balance::value<T1>(&v11);
        assert!(v13 >= arg17, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v14 = 0x2::coin::into_balance<T1>(arg8);
        let v15 = 0x2::balance::value<T1>(&v14);
        assert!(v15 >= arg16, 5);
        if (v9 > 0) {
            let v16 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, v8);
            0x2::balance::join<T1>(&mut v14, v16);
        } else {
            0x2::balance::destroy_zero<T0>(v8);
        };
        if (v10 > 0) {
            let v17 = f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, v7);
            0x2::balance::join<T1>(&mut v14, v17);
        } else {
            0x2::balance::destroy_zero<T2>(v7);
        };
        let v18 = 0x2::balance::value<T1>(&v14);
        assert!(v18 >= arg9 + arg10, 7);
        let v19 = f_c4ffbqp2ie<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T1>(&mut v14, arg9));
        let v20 = 0x2::balance::value<T0>(&v19);
        let v21 = f_bu4nlbma3l<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T1>(&mut v14, arg10));
        let v22 = 0x2::balance::value<T2>(&v21);
        let (v23, v24) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg5), arg11, 1);
        let v25 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T2>(arg3, arg5, v23, v24, arg23);
        let v26 = if (arg12 == 18446744073709551615) {
            if (arg13) {
                assert!(v20 > arg20, 8);
                v20 - arg20
            } else {
                assert!(v22 > arg22, 9);
                v22 - arg22
            }
        } else {
            arg12
        };
        let (v27, v28, v29, v30) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg3, arg5, &mut v25, v19, v21, v26, arg13);
        let v31 = v30;
        let v32 = v29;
        let v33 = 0x2::balance::value<T0>(&v32);
        let v34 = 0x2::balance::value<T1>(&v14);
        let v35 = 0x2::balance::value<T2>(&v31);
        assert!(v27 >= arg18, 8);
        assert!(v28 >= arg19, 9);
        assert!(v33 <= arg20, 10);
        assert!(v34 <= arg21, 11);
        assert!(v35 <= arg22, 11);
        let v36 = T_3avwk6jpa2{
            route_id                 : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
            source_position_id       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg7),
            destination_position_id  : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v25),
            reward_deep              : 0x2::balance::value<T0>(&v0),
            fee_deep                 : 0x2::balance::value<T0>(&v6),
            fee_usdc                 : 0x2::balance::value<T2>(&v5),
            profit_sui               : v13,
            source_principal_deep    : v9,
            source_principal_usdc    : v10,
            input_sui                : v15,
            normalized_principal_sui : v18,
            sui_to_deep              : arg9,
            deep_out                 : v20,
            sui_to_usdc              : arg10,
            usdc_out                 : v22,
            deposited_deep           : v27,
            deposited_usdc           : v28,
            residual_deep            : v33,
            residual_sui             : v34,
            residual_usdc            : v35,
            tick_lower               : v23,
            tick_upper               : v24,
        };
        0x2::event::emit<T_3avwk6jpa2>(v36);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v25, 0x2::tx_context::sender(arg23));
        let v37 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T0>(v32, v37, arg23);
        let v38 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T1>(v14, v38, arg23);
        let v39 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T2>(v31, v39, arg23);
    }

    fun f_wzox2mblzz<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_ffbhaz5mux<T0, T1>) {
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
    }

    public fun f_xfvp7ghevq<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: bool, arg9: u64, arg10: u32, arg11: u64, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, &mut arg7);
        let (v1, v2, v3, v4) = f_bmn6w76gxr<T0, T2>(arg0, arg3, arg5, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T2>(&v7);
        assert!(v9 >= arg13, 4);
        assert!(v10 >= arg14, 5);
        0x2::balance::join<T0>(&mut v6, v0);
        let v11 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, v6);
        0x2::balance::join<T1>(&mut v11, f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, v5));
        let v12 = 0x2::balance::value<T1>(&v11);
        assert!(v12 >= arg15, 6);
        0x2::balance::send_funds<T1>(v11, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
        let v13 = if (arg9 == 0) {
            0
        } else if (arg8) {
            assert!(0x2::balance::value<T0>(&v8) >= arg9, 7);
            let v14 = f_bu4nlbma3l<T0, T2>(arg0, arg3, arg5, 0x2::balance::split<T0>(&mut v8, arg9));
            0x2::balance::join<T2>(&mut v7, v14);
            0x2::balance::value<T2>(&v14)
        } else {
            assert!(0x2::balance::value<T2>(&v7) >= arg9, 7);
            let v15 = f_c4ffbqp2ie<T0, T2>(arg0, arg3, arg5, 0x2::balance::split<T2>(&mut v7, arg9));
            0x2::balance::join<T0>(&mut v8, v15);
            0x2::balance::value<T0>(&v15)
        };
        let (v16, v17) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg5), arg10, 1);
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
        let v25 = T_gpm75ke2wc{
            route_id                : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
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
        0x2::event::emit<T_gpm75ke2wc>(v25);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v18, 0x2::tx_context::sender(arg20));
        let v26 = 0x2::tx_context::sender(arg20);
        f_jk6cxnkjme<T0>(v8, v26, arg20);
        let v27 = 0x2::tx_context::sender(arg20);
        f_jk6cxnkjme<T2>(v7, v27, arg20);
    }

    public fun f_xh5r3d5nsd<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg8: u64) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T2, T0>(arg0, arg3, arg5, arg7);
        let (v1, v2) = f_a2douypn3u<T0, T2>(arg0, arg3, arg5, arg7);
        let v3 = v2;
        let v4 = v1;
        0x2::balance::join<T0>(&mut v4, v0);
        let v5 = f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, v4);
        0x2::balance::join<T1>(&mut v5, f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, v3));
        let v6 = 0x2::balance::value<T1>(&v5);
        assert!(v6 >= arg8, 6);
        let v7 = T_7jtx2pvic5{
            route_id    : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
            position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg7),
            reward_deep : 0x2::balance::value<T0>(&v0),
            fee_deep    : 0x2::balance::value<T0>(&v4),
            fee_usdc    : 0x2::balance::value<T2>(&v3),
            profit_sui  : v6,
        };
        0x2::event::emit<T_7jtx2pvic5>(v7);
        0x2::balance::send_funds<T1>(v5, @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498);
    }

    public fun f_xxdvusb6yi<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &T_mxfoob7xa4, arg1: &T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>, arg2: T_jqabux35vc<T0, T1, T2, T3, T4, T5>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>, arg4: &0x2::tx_context::TxContext) : T_jqabux35vc<T0, T1, T2, T3, T4, T5> {
        f_jfvr7fjrid<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg4);
        assert!(arg2.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg2.route_id == 0x2::object::id<T_nm3mwh55xe<T0, T1, T2, T3, T4, T5>>(arg1), 1);
        assert!(arg2.owner_authority == arg1.owner_authority, 15);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>>(arg3);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.allowed_cetus_pool_ids, &v0), 25);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg2.authenticated_cetus_pool_ids, &v0), 12);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2.authenticated_cetus_pool_ids) < 0x1::vector::length<0x2::object::ID>(&arg1.allowed_cetus_pool_ids), 24);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.authenticated_cetus_pool_ids, v0);
        arg2
    }

    public fun f_yizdeudg67<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_ubv6jvfaql<T0, T1, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut T_b2qzkyfcoy<T2>, arg8: u64) {
        f_544rze3u32(arg1);
        f_eshx6fwhzt<T0, T1, T2>(arg1, arg2, arg4);
        f_femq3j54qj<T0, T1, T2>(arg4, arg5, arg7);
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

    fun f_yq55f2eibc<T0, T1>(arg0: &T_mxfoob7xa4, arg1: &T_jf5gusnm2a<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        f_544rze3u32(arg0);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 1);
        assert!(arg1.cetus_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 12);
    }

    public fun f_zlfuusqcsv<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &T_mxfoob7xa4, arg2: &T_rypypwh3yl<T0, T1, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg7: 0x2::object::ID, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: u64, arg11: bool, arg12: u64, arg13: u32, arg14: u64, arg15: bool, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) {
        f_gu7lcpv3om<T0, T1, T2>(arg1, arg2, arg4, arg5, arg6);
        let v0 = 0x2::balance::value<T0>(&arg8);
        let v1 = 0x2::balance::value<T1>(&arg9);
        assert!(v0 >= arg16, 4);
        assert!(v1 >= arg17, 5);
        let v2 = if (arg10 == 18446744073709551615) {
            0x2::balance::value<T1>(&arg9)
        } else {
            arg10
        };
        assert!(0x2::balance::value<T1>(&arg9) >= v2, 7);
        let v3 = f_bu4nlbma3l<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T1>(&mut arg9, v2));
        let v4 = 0x2::balance::value<T2>(&v3);
        let v5 = if (arg12 == 0) {
            0
        } else if (arg11) {
            assert!(0x2::balance::value<T0>(&arg8) >= arg12, 7);
            let v6 = f_bu4nlbma3l<T1, T2>(arg0, arg3, arg6, f_bu4nlbma3l<T0, T1>(arg0, arg3, arg4, 0x2::balance::split<T0>(&mut arg8, arg12)));
            0x2::balance::join<T2>(&mut v3, v6);
            0x2::balance::value<T2>(&v6)
        } else {
            assert!(0x2::balance::value<T2>(&v3) >= arg12, 7);
            let v7 = f_c4ffbqp2ie<T0, T1>(arg0, arg3, arg4, f_c4ffbqp2ie<T1, T2>(arg0, arg3, arg6, 0x2::balance::split<T2>(&mut v3, arg12)));
            0x2::balance::join<T0>(&mut arg8, v7);
            0x2::balance::value<T0>(&v7)
        };
        let (v8, v9) = f_je4ayhnzei(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T2>(arg5), arg13, 1);
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T2>(arg3, arg5, v8, v9, arg23);
        let v11 = if (arg14 == 18446744073709551615) {
            if (arg15) {
                let v12 = 0x2::balance::value<T0>(&arg8);
                assert!(v12 > arg20, 8);
                v12 - arg20
            } else {
                let v13 = 0x2::balance::value<T2>(&v3);
                assert!(v13 > arg22, 9);
                v13 - arg22
            }
        } else {
            arg14
        };
        let (v14, v15, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T2>(arg0, arg3, arg5, &mut v10, arg8, v3, v11, arg15);
        arg8 = v16;
        v3 = v17;
        let v18 = 0x2::balance::value<T0>(&arg8);
        let v19 = 0x2::balance::value<T1>(&arg9);
        let v20 = 0x2::balance::value<T2>(&v3);
        assert!(v14 >= arg18, 8);
        assert!(v15 >= arg19, 9);
        assert!(v18 <= arg20, 10);
        assert!(v19 <= arg21, 11);
        assert!(v20 <= arg22, 11);
        let v21 = T_4vpin3vzge{
            route_id                : 0x2::object::id<T_rypypwh3yl<T0, T1, T2>>(arg2),
            source_kai_position_id  : arg7,
            destination_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v10),
            input_deep              : v0,
            input_sui               : v1,
            principal_sui_to_usdc   : v2,
            principal_usdc_out      : v4,
            swap_deep_to_usdc       : arg11,
            swap_input              : arg12,
            swap_output             : v5,
            deposited_deep          : v14,
            deposited_usdc          : v15,
            residual_deep           : v18,
            residual_sui            : v19,
            residual_usdc           : v20,
            tick_lower              : v8,
            tick_upper              : v9,
        };
        0x2::event::emit<T_4vpin3vzge>(v21);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v10, 0x2::tx_context::sender(arg23));
        let v22 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T0>(arg8, v22, arg23);
        let v23 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T1>(arg9, v23, arg23);
        let v24 = 0x2::tx_context::sender(arg23);
        f_jk6cxnkjme<T2>(v3, v24, arg23);
    }

    public fun f_zsnnshgoo5<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9>(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T8, T9>, arg6: u32, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>>(arg4);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T8, T9>>(arg5);
        assert!(v0 != v1, 12);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x2::object::ID>(v3, v0);
        0x1::vector::push_back<0x2::object::ID>(v3, v1);
        f_jlsunzyj4h<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, v2, arg6, arg7, arg8);
    }

    fun f_zyotjhy6mn(arg0: &T_mxfoob7xa4, arg1: &T_gc6rj26lvo) {
        assert!(arg0.profit_recipient == @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498, 2);
        assert!(arg1.registry_id == 0x2::object::id<T_mxfoob7xa4>(arg0), 0);
        assert!(0x2::object::id<T_gc6rj26lvo>(arg1) == arg0.admin_cap_id, 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = T_gc6rj26lvo{
            id          : 0x2::object::new(arg0),
            registry_id : v1,
        };
        let v3 = 0x2::object::id<T_gc6rj26lvo>(&v2);
        let v4 = T_mxfoob7xa4{
            id               : v0,
            admin_cap_id     : v3,
            profit_recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        let v5 = T_qyii7utb72{
            registry_id      : v1,
            admin_cap_id     : v3,
            profit_recipient : @0xa10aecd2e9e45698e8c36ccaf3c4ea51cdda87f3c098a71d1e77be3351000498,
        };
        0x2::event::emit<T_qyii7utb72>(v5);
        0x2::transfer::public_transfer<T_gc6rj26lvo>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<T_mxfoob7xa4>(v4);
    }

    // decompiled from Move bytecode v7
}

