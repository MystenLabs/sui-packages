module 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultsManager has store, key {
        id: 0x2::object::UID,
        index: u64,
        package_version: u64,
        vault_to_pool_maps: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        price_oracles: 0x2::table::Table<0x2::object::ID, OracleInfo>,
        acl: 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::ACL,
    }

    struct OracleInfo has drop, store {
        clmm_pool: 0x2::object::ID,
        slippage: u8,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        liquidity: u128,
        protocol_fee_rate: u64,
        is_pause: bool,
        positions: vector<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>,
        lp_token_treasury: 0x2::coin::TreasuryCap<T0>,
        harvest_assets: 0x2::bag::Bag,
        protocol_fees: 0x2::bag::Bag,
        max_quota: u128,
        status: u8,
        quota_based_type: 0x1::type_name::TypeName,
        finish_rebalance_threshold: u64,
        flash_loan_count: u8,
    }

    struct FlashLoanReceipt {
        vault_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
    }

    struct CreateEvent has copy, drop {
        id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        clmm_position: 0x2::object::ID,
        wrapped_position: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        lp_token_treasury: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        before_liquidity: u128,
        delta_liquidity: u128,
        before_supply: u64,
        lp_amount: u64,
    }

    struct RemoveEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lp_amount: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
        protocol_fee_a_amount: u64,
        protocol_fee_b_amount: u64,
    }

    struct ReinvestEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        remaining_amount_a: u64,
        remaining_amount_b: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
    }

    struct MigrateLiquidityEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_position: 0x2::object::ID,
        new_position: 0x2::object::ID,
        old_wrapped_position: 0x2::object::ID,
        new_wrapped_position: 0x2::object::ID,
        remaining_amount: u64,
        old_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_liquidity: u128,
        new_liquidity: u128,
        current_sqrt_price: u128,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        remaining_amount_a: u64,
        remaining_amount_b: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
    }

    struct FeeClaimedEvent has copy, drop {
        amount_a: u64,
        amount_b: u64,
        vault_id: 0x2::object::ID,
    }

    struct HarvestEvent has copy, drop {
        amount: u64,
        rewarder_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
    }

    struct RewarderClaimedEvent has copy, drop {
        amount: u64,
        rewarder_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
    }

    struct PauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct UnpauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct UpdateFeeRateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct ClaimProtocolFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct SetPackageVersionEvent has copy, drop {
        new_version: u64,
        old_version: u64,
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

    struct UpdateMaxQuotaEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_quota: u128,
        new_quota: u128,
    }

    struct UpdateRebalanceThresoldEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_thresold: u64,
        new_thresold: u64,
    }

    struct AddOraclePoolEvent has copy, drop {
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        oracle_pool: 0x2::object::ID,
        slippage: u8,
    }

    struct RemoveOraclePoolEvent has copy, drop {
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    struct UpdateSlippageEvent has copy, drop {
        old_slippage: u8,
        new_slippage: u8,
    }

    struct FlashLoanEvent has copy, drop {
        vault_id: 0x2::object::ID,
        loan_type: 0x1::type_name::TypeName,
        repay_type: 0x1::type_name::TypeName,
        amount: u64,
        repay_amount: u64,
        oracle_pool: 0x2::object::ID,
        current_sqrt_price: u128,
    }

    struct RepayFlashLoanEvent has copy, drop {
        vault_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    public fun remove<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x2::coin::Coin<T2>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        checked_package_version(arg0);
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(arg8 > 0, 5);
        assert!(0x2::coin::value<T2>(arg7) >= arg8, 9);
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions) == 1, 2);
        let (_, _) = collect_clmm_fee<T0, T1, T2>(arg1, arg3, arg5, arg6);
        let v2 = 0x1::vector::borrow_mut<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&mut arg1.positions, 0);
        let v3 = get_share_liquidity_by_amount(arg8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(v2)), total_token_amount<T2>(arg1));
        arg1.liquidity = arg1.liquidity - v3;
        let (v4, v5) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::remove_liquidity<T0, T1>(arg3, arg5, arg2, arg4, arg6, v2, v3, arg9, arg10, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::balance::value<T0>(&v7);
        let v9 = 0x2::balance::value<T1>(&v6);
        let (v10, v11) = if (arg1.protocol_fee_rate == 0) {
            (0, 0)
        } else {
            let v12 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v8, arg1.protocol_fee_rate, 10000);
            let v13 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v9, arg1.protocol_fee_rate, 10000);
            merge_protocol_asset<T0, T2>(arg1, 0x2::balance::split<T0>(&mut v7, v12));
            merge_protocol_asset<T1, T2>(arg1, 0x2::balance::split<T1>(&mut v6, v13));
            (v12, v13)
        };
        assert!(v8 - v10 >= arg9, 1);
        assert!(v9 - v11 >= arg10, 1);
        let v14 = RemoveEvent{
            vault_id              : 0x2::object::id<Vault<T2>>(arg1),
            lp_amount             : arg8,
            liquidity             : v3,
            amount_a              : v8,
            amount_b              : v9,
            protocol_fee_a_amount : v10,
            protocol_fee_b_amount : v11,
        };
        0x2::event::emit<RemoveEvent>(v14);
        0x2::coin::burn<T2>(&mut arg1.lp_token_treasury, 0x2::coin::split<T2>(arg7, arg8, arg12));
        (0x2::coin::from_balance<T0>(v7, arg12), 0x2::coin::from_balance<T1>(v6, arg12))
    }

    public fun collect_fee<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operation_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions) == 1, 2);
        let (v0, v1) = collect_clmm_fee<T0, T1, T2>(arg1, arg2, arg3, arg4);
        let v2 = FeeClaimedEvent{
            amount_a : v0,
            amount_b : v1,
            vault_id : 0x2::object::id<Vault<T2>>(arg1),
        };
        0x2::event::emit<FeeClaimedEvent>(v2);
    }

    public fun deposit<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        checked_package_version(arg0);
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions) == 1, 2);
        let (_, _) = collect_clmm_fee<T0, T1, T2>(arg1, arg3, arg5, arg6);
        let v2 = total_token_amount<T2>(arg1);
        let v3 = 0x1::vector::borrow_mut<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&mut arg1.positions, 0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(v3));
        let (v5, v6) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg5, arg2, arg4, arg6, v3, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v7 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(v3);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v7) - v4;
        arg1.liquidity = arg1.liquidity + v8;
        if (arg1.max_quota != 0) {
            let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v7);
            assert!(calculate_updated_quota<T0, T1>(arg6, arg1.quota_based_type, arg1.liquidity, v9, v10) <= arg1.max_quota, 16);
        };
        let v11 = get_lp_amount_by_liquidity(v2, v8, v4);
        assert!(v11 > 0, 5);
        assert!(v11 < ((18446744073709551616 - 1) as u128) - (v2 as u128), 4);
        0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v5, arg13), 0x2::tx_context::sender(arg13));
        0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v6, arg13), 0x2::tx_context::sender(arg13));
        let v12 = DepositEvent{
            vault_id         : 0x2::object::id<Vault<T2>>(arg1),
            before_liquidity : v4,
            delta_liquidity  : v8,
            before_supply    : v2,
            lp_amount        : (v11 as u64),
        };
        0x2::event::emit<DepositEvent>(v12);
        0x2::coin::mint<T2>(&mut arg1.lp_token_treasury, (v11 as u64), arg13)
    }

    public fun harvest<T0, T1>(arg0: &VaultsManager, arg1: &mut Vault<T1>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operation_role(arg0, 0x2::tx_context::sender(arg6));
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions) == 1, 2);
        let v0 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::harvest<T0>(arg3, arg2, arg4, 0x1::vector::borrow<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions, 0), arg5);
        merge_harvest_asset<T0, T1>(arg1, v0);
        let v1 = HarvestEvent{
            amount        : 0x2::balance::value<T0>(&v0),
            rewarder_type : 0x1::type_name::get<T0>(),
            vault_id      : 0x2::object::id<Vault<T1>>(arg1),
        };
        0x2::event::emit<HarvestEvent>(v1);
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address) {
        checked_package_version(arg1);
        0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun add_oracle_pool<T0, T1>(arg0: &mut VaultsManager, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = new_pool_key<T0, T1>();
        assert!(!0x2::table::contains<0x2::object::ID, OracleInfo>(&arg0.price_oracles, v0), 22);
        let v1 = OracleInfo{
            clmm_pool : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            slippage  : arg2,
        };
        0x2::table::add<0x2::object::ID, OracleInfo>(&mut arg0.price_oracles, v0, v1);
        let v2 = AddOraclePoolEvent{
            coin_a      : 0x1::type_name::get<T0>(),
            coin_b      : 0x1::type_name::get<T1>(),
            oracle_pool : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            slippage    : arg2,
        };
        0x2::event::emit<AddOraclePoolEvent>(v2);
    }

    fun calculate_updated_quota<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: u128, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let (v1, v2) = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::utils::get_amount_by_liquidity(arg3, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), v0, arg2, true);
        assert!(0x1::type_name::get<T0>() == arg1 || 0x1::type_name::get<T1>() == arg1, 19);
        let v3 = 0x1::type_name::get<T0>() == arg1;
        get_tvl_of_based_coin(v0, v1, v2, v3)
    }

    fun check_is_fix_coin_a(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u64, arg5: u64) : (bool, u64, u64) {
        let (_, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(arg0, arg1, arg2, arg3, arg4, true);
        assert!(v1 == arg4, 100);
        if (v2 <= arg5) {
            return (true, v1, v2)
        };
        let (_, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(arg0, arg1, arg2, arg3, arg5, false);
        assert!(v5 == arg5, 100);
        (false, v4, v5)
    }

    public fun check_operation_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::has_role(&arg0.acl, arg1, 1) || 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::has_role(&arg0.acl, arg1, 2), 12);
    }

    public fun check_pool_manager_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::has_role(&arg0.acl, arg1, 3), 13);
    }

    public fun check_protocol_fee_claim_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::has_role(&arg0.acl, arg1, 0), 11);
    }

    public fun check_rebalance_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::has_role(&arg0.acl, arg1, 2), 12);
    }

    public fun check_reinvest_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::has_role(&arg0.acl, arg1, 1), 12);
    }

    public fun checked_package_version(arg0: &VaultsManager) {
        assert!(4 >= arg0.package_version, 3);
    }

    public fun claim_protocol_fee<T0, T1>(arg0: &VaultsManager, arg1: &mut Vault<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = take_protocol_asset<T0, T1>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = ClaimProtocolFeeEvent{
            vault_id  : 0x2::object::id<Vault<T1>>(arg1),
            amount    : 0x2::balance::value<T0>(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v1);
    }

    fun collect_clmm_fee<T0, T1, T2>(arg0: &mut Vault<T2>, arg1: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u64, u64) {
        let (v0, v1) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::collect_fee<T0, T1>(arg1, arg2, arg3, 0x1::vector::borrow<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg0.positions, 0), true);
        let v2 = v1;
        let v3 = v0;
        merge_harvest_asset<T0, T2>(arg0, v3);
        merge_harvest_asset<T1, T2>(arg0, v2);
        (0x2::balance::value<T0>(&v3), 0x2::balance::value<T1>(&v2))
    }

    public fun collect_rewarder<T0, T1, T2, T3>(arg0: &VaultsManager, arg1: &mut Vault<T3>, arg2: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operation_role(arg0, 0x2::tx_context::sender(arg7));
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions) == 1, 2);
        let v0 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::collect_clmm_reward<T2, T0, T1>(arg2, arg3, arg4, 0x1::vector::borrow<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions, 0), arg5, 0x2::coin::zero<T2>(arg7), true, arg6, arg7);
        merge_harvest_asset<T2, T3>(arg1, v0);
        let v1 = RewarderClaimedEvent{
            amount        : 0x2::balance::value<T2>(&v0),
            rewarder_type : 0x1::type_name::get<T2>(),
            vault_id      : 0x2::object::id<Vault<T3>>(arg1),
        };
        0x2::event::emit<RewarderClaimedEvent>(v1);
    }

    public fun create_vault<T0, T1, T2>(arg0: &mut VaultsManager, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u32, arg8: u32, arg9: bool, arg10: u128, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg13));
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 14);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg5, arg6, arg7, arg8, arg13);
        let v1 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::deposit(arg3, arg2, arg4, v0, arg12, arg13);
        let v2 = if (arg9) {
            0x1::type_name::get<T0>()
        } else {
            0x1::type_name::get<T1>()
        };
        let v3 = 0x1::vector::empty<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>();
        0x1::vector::push_back<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&mut v3, v1);
        let v4 = Vault<T2>{
            id                         : 0x2::object::new(arg13),
            pool                       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6),
            liquidity                  : 0,
            protocol_fee_rate          : 0,
            is_pause                   : false,
            positions                  : v3,
            lp_token_treasury          : arg1,
            harvest_assets             : 0x2::bag::new(arg13),
            protocol_fees              : 0x2::bag::new(arg13),
            max_quota                  : arg10,
            status                     : 1,
            quota_based_type           : v2,
            finish_rebalance_threshold : arg11,
            flash_loan_count           : 0,
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.vault_to_pool_maps, 0x2::object::id<Vault<T2>>(&v4), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6));
        let v5 = CreateEvent{
            id                : 0x2::object::id<Vault<T2>>(&v4),
            clmm_pool         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6),
            clmm_position     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            wrapped_position  : 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&v1),
            tick_lower        : arg7,
            tick_upper        : arg8,
            lp_token_treasury : 0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg1),
        };
        0x2::event::emit<CreateEvent>(v5);
        0x2::transfer::share_object<Vault<T2>>(v4);
    }

    public fun flash_loan<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, FlashLoanReceipt) {
        checked_package_version(arg0);
        check_operation_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(!arg1.is_pause, 6);
        assert!(arg3 > 0, 24);
        assert!(arg1.flash_loan_count == 0, 27);
        arg1.flash_loan_count = arg1.flash_loan_count + 1;
        let v0 = new_pool_key<T0, T1>();
        assert!(0x2::table::contains<0x2::object::ID, OracleInfo>(&arg0.price_oracles, v0), 23);
        let v1 = 0x2::table::borrow<0x2::object::ID, OracleInfo>(&arg0.price_oracles, v0);
        assert!(v1.clmm_pool == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 26);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v3 = (v2 as u256) * 100000000000000000000 / 18446744073709551616;
        let (v4, v5, v6) = if (arg4) {
            let v7 = take_harvest_asset_by_amount<T0, T2>(arg1, arg3);
            (0x2::coin::from_balance<T0>(v7, arg5), 0x2::coin::zero<T1>(arg5), (((arg3 as u256) * v3 * v3 / 100000000000000000000 / 100000000000000000000) as u64))
        } else {
            let v8 = take_harvest_asset_by_amount<T1, T2>(arg1, arg3);
            (0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(v8, arg5), (((arg3 as u256) * 100000000000000000000 / v3 * v3 / 100000000000000000000) as u64))
        };
        let v9 = v6 - v6 * (v1.slippage as u64) / 2000;
        let (v10, v11) = if (arg4) {
            (0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
        } else {
            (0x1::type_name::get<T1>(), 0x1::type_name::get<T0>())
        };
        let v12 = FlashLoanReceipt{
            vault_id     : 0x2::object::id<Vault<T2>>(arg1),
            repay_type   : v11,
            repay_amount : v9,
        };
        let v13 = FlashLoanEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            loan_type          : v10,
            repay_type         : v11,
            amount             : arg3,
            repay_amount       : v9,
            oracle_pool        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            current_sqrt_price : v2,
        };
        0x2::event::emit<FlashLoanEvent>(v13);
        (v4, v5, v12)
    }

    fun get_lp_amount_by_liquidity(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg0 == 0) {
            return arg1
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, arg2)
    }

    public fun get_position_amounts<T0, T1, T2>(arg0: &Vault<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) : (u64, u64) {
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg0.positions) == 1, 2);
        let v0 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(0x1::vector::borrow<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg0.positions, 0));
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
        0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::utils::get_amount_by_liquidity(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), get_share_liquidity_by_amount(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), total_token_amount<T2>(arg0)), false)
    }

    fun get_share_liquidity_by_amount(arg0: u64, arg1: u128, arg2: u64) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, (arg2 as u128))
    }

    fun get_tvl_of_based_coin(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : u128 {
        let v0 = (arg0 as u256) * 100000000000000000000 / 18446744073709551616;
        if (arg3) {
            (arg1 as u128) + (((arg2 as u256) * 100000000000000000000 / v0 * v0 / 100000000000000000000) as u128)
        } else {
            (arg2 as u128) + (((arg1 as u256) * v0 * v0 / 100000000000000000000 / 100000000000000000000) as u128)
        }
    }

    fun harvest_assets_amount<T0, T1>(arg0: &Vault<T1>) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.harvest_assets, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.harvest_assets, v0))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultsManager{
            id                 : 0x2::object::new(arg0),
            index              : 0,
            package_version    : 4,
            vault_to_pool_maps : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            price_oracles      : 0x2::table::new<0x2::object::ID, OracleInfo>(arg0),
            acl                : 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::acl::new(arg0),
        };
        let v2 = InitEvent{
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            manager_id   : 0x2::object::id<VaultsManager>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
        let v3 = &mut v1;
        set_roles(&v0, v3, 0x2::tx_context::sender(arg0), 0 | 1 << 3 | 1 << 1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultsManager>(v1);
    }

    fun merge_harvest_asset<T0, T1>(arg0: &mut Vault<T1>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.harvest_assets, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.harvest_assets, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.harvest_assets, v0, arg1);
        };
    }

    fun merge_protocol_asset<T0, T1>(arg0: &mut Vault<T1>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0, arg1);
        };
    }

    public fun migrate_liquidity<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: u64, arg9: u32, arg10: u32, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_rebalance_role(arg0, 0x2::tx_context::sender(arg12));
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions) == 1, 2);
        arg1.status = 2;
        let v0 = 0x1::vector::pop_back<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&mut arg1.positions);
        let v1 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(&v0);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v1);
        let (v4, v5) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::close_position<T0, T1>(arg3, arg2, arg4, arg5, arg6, v0, arg7, arg8, arg11);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x2::balance::value<T0>(&v7);
        let v9 = 0x2::balance::value<T1>(&v6);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg5, arg6, arg9, arg10, arg12);
        let v11 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::deposit(arg3, arg2, arg4, v10, arg11, arg12);
        let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(&v11));
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6);
        let (v15, v16, v17) = check_is_fix_coin_a(v12, v13, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg6), v14, v8, v9);
        let (v18, v19) = if (v15) {
            (v8, v17 + v17 * (0x2::table::borrow<0x2::object::ID, OracleInfo>(&arg0.price_oracles, new_pool_key<T0, T1>()).slippage as u64) / 2000)
        } else {
            (v16 + v16 * (0x2::table::borrow<0x2::object::ID, OracleInfo>(&arg0.price_oracles, new_pool_key<T0, T1>()).slippage as u64) / 2000, v9)
        };
        let (v20, v21) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg5, arg2, arg4, arg6, &mut v11, 0x2::coin::from_balance<T0>(v7, arg12), 0x2::coin::from_balance<T1>(v6, arg12), v18, v19, v15, arg11, arg12);
        let v22 = v21;
        let v23 = v20;
        let v24 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(&v11));
        assert!(v24 > 0, 30);
        arg1.liquidity = v24;
        let v25 = if (v15) {
            assert!(0x2::balance::value<T0>(&v23) == 0, 8);
            0x2::balance::value<T1>(&v22)
        } else {
            assert!(0x2::balance::value<T1>(&v22) == 0, 8);
            0x2::balance::value<T0>(&v23)
        };
        let v26 = MigrateLiquidityEvent{
            vault_id             : 0x2::object::id<Vault<T2>>(arg1),
            old_position         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1),
            new_position         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v10),
            old_wrapped_position : 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&v0),
            new_wrapped_position : 0x2::object::id<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&v11),
            remaining_amount     : v25,
            old_tick_lower       : v2,
            old_tick_upper       : v3,
            old_liquidity        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1),
            new_liquidity        : v24,
            current_sqrt_price   : v14,
            tick_lower           : v12,
            tick_upper           : v13,
        };
        0x2::event::emit<MigrateLiquidityEvent>(v26);
        merge_harvest_asset<T0, T2>(arg1, v23);
        merge_harvest_asset<T1, T2>(arg1, v22);
        0x1::vector::push_back<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&mut arg1.positions, v11);
    }

    public fun new_pool_key<T0, T1>() : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let v6 = 0;
        let v7 = false;
        while (v6 < v5) {
            let v8 = *0x1::vector::borrow<u8>(&v3, v6);
            if (!v7 && v6 < v4) {
                let v9 = *0x1::vector::borrow<u8>(&v1, v6);
                if (v9 < v8) {
                    abort 21
                };
                if (v9 > v8) {
                    v7 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v1, v8);
            v6 = v6 + 1;
        };
        if (!v7) {
            if (v4 < v5) {
                abort 21
            };
            if (v4 == v5) {
                abort 20
            };
        };
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun package_version() : u64 {
        4
    }

    public fun pause<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = true;
        let v0 = PauseEvent{vault_id: 0x2::object::id<Vault<T0>>(arg1)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun rebalance<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_rebalance_role(arg0, 0x2::tx_context::sender(arg9));
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 2, 18);
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions) == 1, 2);
        assert!(arg1.flash_loan_count == 0, 27);
        let (v0, v1, v2, v3, v4) = reinvest_harvest_assets<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v5 = RebalanceEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            amount_a           : v0,
            amount_b           : v1,
            remaining_amount_a : v2,
            remaining_amount_b : v3,
            delta_liquidity    : v4,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6),
        };
        0x2::event::emit<RebalanceEvent>(v5);
        if (arg7) {
            let v6 = 0x1::type_name::get<T0>() == arg1.quota_based_type;
            assert!((get_tvl_of_based_coin(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), harvest_assets_amount<T0, T2>(arg1), harvest_assets_amount<T1, T2>(arg1), v6) as u64) <= arg1.finish_rebalance_threshold, 28);
            arg1.status = 1;
        };
    }

    public fun reinvest<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg8));
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(0x1::vector::length<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&arg1.positions) == 1, 2);
        let (v0, v1, v2, v3, v4) = reinvest_harvest_assets<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v5 = ReinvestEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            amount_a           : v0,
            amount_b           : v1,
            remaining_amount_a : v2,
            remaining_amount_b : v3,
            delta_liquidity    : v4,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6),
        };
        0x2::event::emit<ReinvestEvent>(v5);
    }

    fun reinvest_harvest_assets<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg3: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg4: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u128) {
        let v0 = take_harvest_asset<T0, T2>(arg1);
        let v1 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v2 = take_harvest_asset<T1, T2>(arg1);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg8);
        let v4 = 0x1::vector::borrow_mut<0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::WrappedPositionNFT>(&mut arg1.positions, 0);
        let v5 = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(v4);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v5);
        let v8 = 0x2::coin::value<T0>(&v1);
        let v9 = 0x2::coin::value<T1>(&v3);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v5);
        let v11 = new_pool_key<T0, T1>();
        assert!(0x2::table::contains<0x2::object::ID, OracleInfo>(&arg0.price_oracles, v11), 23);
        let (v12, v13, v14) = check_is_fix_coin_a(v6, v7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6), v8, v9);
        let (v15, v16) = if (v12) {
            (v8, v14 + v14 * (0x2::table::borrow<0x2::object::ID, OracleInfo>(&arg0.price_oracles, v11).slippage as u64) / 2000)
        } else {
            (v13 + v13 * (0x2::table::borrow<0x2::object::ID, OracleInfo>(&arg0.price_oracles, v11).slippage as u64) / 2000, v9)
        };
        let (v17, v18) = 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg5, arg2, arg4, arg6, v4, v1, v3, v15, v16, v12, arg7, arg8);
        let v19 = v18;
        let v20 = v17;
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::borrow_clmm_position(v4)) - v10;
        assert!(v21 > 0, 30);
        arg1.liquidity = arg1.liquidity + v21;
        merge_harvest_asset<T0, T2>(arg1, v20);
        merge_harvest_asset<T1, T2>(arg1, v19);
        (v8, v9, 0x2::balance::value<T0>(&v20), 0x2::balance::value<T1>(&v19), v21)
    }

    public fun remove_oracle_pool<T0, T1>(arg0: &mut VaultsManager, arg1: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = new_pool_key<T0, T1>();
        assert!(0x2::table::contains<0x2::object::ID, OracleInfo>(&arg0.price_oracles, v0), 23);
        0x2::table::remove<0x2::object::ID, OracleInfo>(&mut arg0.price_oracles, v0);
        let v1 = RemoveOraclePoolEvent{
            coin_a : 0x1::type_name::get<T0>(),
            coin_b : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<RemoveOraclePoolEvent>(v1);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &VaultsManager, arg1: &mut Vault<T1>, arg2: FlashLoanReceipt, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_operation_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(!arg1.is_pause, 6);
        arg1.flash_loan_count = arg1.flash_loan_count - 1;
        let FlashLoanReceipt {
            vault_id     : v0,
            repay_type   : v1,
            repay_amount : v2,
        } = arg2;
        assert!(0x1::type_name::get<T0>() == v1, 25);
        assert!(0x2::coin::value<T0>(&arg3) >= v2, 25);
        assert!(0x2::object::id<Vault<T1>>(arg1) == v0, 25);
        merge_harvest_asset<T0, T1>(arg1, 0x2::coin::into_balance<T0>(arg3));
        let v3 = RepayFlashLoanEvent{
            vault_id     : v0,
            repay_type   : v1,
            repay_amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<RepayFlashLoanEvent>(v3);
    }

    fun take_harvest_asset<T0, T1>(arg0: &mut Vault<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.harvest_assets, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.harvest_assets, v0)
    }

    fun take_harvest_asset_by_amount<T0, T1>(arg0: &mut Vault<T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.harvest_assets, v0), 7);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.harvest_assets, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 29);
        0x2::balance::split<T0>(v1, arg1)
    }

    fun take_protocol_asset<T0, T1>(arg0: &mut Vault<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0)
    }

    public fun total_token_amount<T0>(arg0: &Vault<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_token_treasury)
    }

    public fun unpause<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = false;
        let v0 = UnpauseEvent{vault_id: 0x2::object::id<Vault<T0>>(arg1)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public fun update_max_quota<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg1.is_pause, 6);
        arg1.max_quota = arg2;
        let v0 = UpdateMaxQuotaEvent{
            vault_id  : 0x2::object::id<Vault<T0>>(arg1),
            old_quota : arg1.max_quota,
            new_quota : arg2,
        };
        0x2::event::emit<UpdateMaxQuotaEvent>(v0);
    }

    public entry fun update_package_version(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: u64) {
        let v0 = arg1.package_version;
        assert!(arg2 > v0, 15);
        arg1.package_version = arg2;
        let v1 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersionEvent>(v1);
    }

    public fun update_protocol_fee_rate<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 10);
        assert!(!arg1.is_pause, 6);
        arg1.protocol_fee_rate = arg2;
        let v0 = UpdateFeeRateEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            old_fee_rate : arg1.protocol_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    public fun update_rebalance_threshold<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg1.is_pause, 6);
        arg1.finish_rebalance_threshold = arg2;
        let v0 = UpdateRebalanceThresoldEvent{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            old_thresold : arg1.finish_rebalance_threshold,
            new_thresold : arg2,
        };
        0x2::event::emit<UpdateRebalanceThresoldEvent>(v0);
    }

    public fun update_rebalance_thresold<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun update_slippage<T0, T1>(arg0: &mut VaultsManager, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = new_pool_key<T0, T1>();
        assert!(0x2::table::contains<0x2::object::ID, OracleInfo>(&arg0.price_oracles, v0), 23);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, OracleInfo>(&mut arg0.price_oracles, v0);
        v1.slippage = arg1;
        let v2 = UpdateSlippageEvent{
            old_slippage : v1.slippage,
            new_slippage : arg1,
        };
        0x2::event::emit<UpdateSlippageEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

