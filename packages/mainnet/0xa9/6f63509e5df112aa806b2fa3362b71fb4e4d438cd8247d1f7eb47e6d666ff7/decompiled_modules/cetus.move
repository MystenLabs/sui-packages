module 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        index: u64,
        position_index: u64,
        name: 0x1::string::String,
        protocol: 0x1::string::String,
        logo: 0x1::ascii::String,
        pool: 0x2::object::ID,
        liquidity: u128,
        protocol_fee_rate: u64,
        withdraw_fee_rate: u64,
        is_pause: bool,
        positions: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        total_share: u64,
        free_assets: 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::BalanceBag,
        protocol_fees: 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::BalanceBag,
        max_limit: u128,
        limit_based_type: 0x1::type_name::TypeName,
        slippage: u64,
        rewarders: vector<0x1::type_name::TypeName>,
        extension_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        total_tvl: u128,
        last_calculate_tvl_tx: vector<u8>,
        last_deposit_tx: vector<u8>,
        last_remove_tx: vector<u8>,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        liquidity_range: LiquidityRange,
    }

    struct LiquidityRange has drop, store {
        lower_offset: u32,
        upper_offset: u32,
        rebalance_threshold: u32,
    }

    struct VaultPosition has store, key {
        id: 0x2::object::UID,
        index: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        vault_id: 0x2::object::ID,
        position_share: u64,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, PositionRewardInfo>,
    }

    struct PositionRewardInfo has copy, drop, store {
        pending_reward: u128,
        reward_debt: u128,
        reward_harvested: u128,
    }

    struct FlashLoanReceipt {
        vault_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct CreateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        clmm_position: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct OpenPositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        index: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        before_liquidity: u128,
        delta_liquidity: u128,
        before_total_share: u64,
        delta_share: u64,
    }

    struct RemoveEvent has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        before_liquidity: u128,
        delta_liquidity: u128,
        before_total_share: u64,
        delta_share: u64,
        amount_a: u64,
        amount_b: u64,
        protocol_fee_a_amount: u64,
        protocol_fee_b_amount: u64,
    }

    struct CompoundEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        remaining_amount_a: u64,
        remaining_amount_b: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
    }

    struct MigrateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_position: 0x2::object::ID,
        new_position: 0x2::object::ID,
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

    struct UpdateProtocolFeeRateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct UpdateWithdrawRateEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct ClaimProtocolFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct UpdateMaxQuotaEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_limit: u128,
        new_limit: u128,
    }

    struct UpdateSlippageEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_slippage: u64,
        new_slippage: u64,
    }

    struct FlashLoanEvent has copy, drop {
        vault_id: 0x2::object::ID,
        loan_type: 0x1::type_name::TypeName,
        repay_type: 0x1::type_name::TypeName,
        amount: u64,
        repay_amount: u64,
    }

    struct RepayFlashLoanEvent has copy, drop {
        vault_id: 0x2::object::ID,
        repay_type: 0x1::type_name::TypeName,
        repay_amount: u64,
    }

    struct AddExtensionConfigEvent has copy, drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct UpdateExtensionConfigEvent has copy, drop, store {
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
    }

    struct RemoveExtensionConfigEvent has copy, drop, store {
        key: 0x1::string::String,
    }

    struct PositionRewardClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        reward_type_name: 0x1::type_name::TypeName,
    }

    struct AddRewarderEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        allocate_point: u64,
    }

    struct UpdateLiquidityOffsetEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_lower_offset: u32,
        old_upper_offset: u32,
        new_lower_offset: u32,
        new_upper_offset: u32,
    }

    struct UpdateRebalanceThresholdEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_rebalance_threshold: u32,
        new_rebalance_threshold: u32,
    }

    public fun remove<T0, T1>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &mut 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::RewarderManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut VaultPosition, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(arg6 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::remove_amount());
        assert!(arg5.position_share >= arg6, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::coin_value());
        assert!(arg5.vault_id == 0x2::object::id<Vault>(arg0), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::mismatch_vault_position_id());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::position_length());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == arg0.pool, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::pool_id_mismatch());
        let v0 = *0x2::tx_context::digest(arg10);
        assert!(v0 != arg0.last_deposit_tx, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::operation_not_allowed());
        assert!(v0 != arg0.last_remove_tx, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::operation_not_allowed());
        arg0.last_remove_tx = v0;
        assert_fee_reward_claimed<T0, T1>(arg3, arg4, arg0, arg9);
        let v1 = arg0.total_share;
        let v2 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2);
        let v4 = *0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::balances(&arg0.free_assets);
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v4)) {
            let (v8, v9) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v4, v7);
            if (*v8 == 0x1::type_name::get<T0>()) {
                v5 = *v9;
            } else if (*v8 == 0x1::type_name::get<T1>()) {
                v6 = *v9;
            };
            v7 = v7 + 1;
        };
        let v10 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::split<T0>(&mut arg0.free_assets, (0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::utils::get_user_amount_by_share(v1, arg6, (v5 as u128)) as u64));
        let v11 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::split<T1>(&mut arg0.free_assets, (0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::utils::get_user_amount_by_share(v1, arg6, (v6 as u128)) as u64));
        let v12 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::utils::get_user_amount_by_share(v1, arg6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2));
        if (v12 > 0) {
            let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg4, v2, v12, arg9);
            0x2::balance::join<T0>(&mut v10, v13);
            0x2::balance::join<T1>(&mut v11, v14);
        };
        arg0.liquidity = arg0.liquidity - v12;
        let v15 = 0x2::balance::value<T0>(&v10);
        let v16 = 0x2::balance::value<T1>(&v11);
        let (v17, v18) = if (arg0.withdraw_fee_rate == 0) {
            (0, 0)
        } else {
            let v19 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v15, arg0.withdraw_fee_rate, 10000);
            let v20 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v16, arg0.withdraw_fee_rate, 10000);
            0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T0>(&mut arg0.protocol_fees, 0x2::balance::split<T0>(&mut v10, v19));
            0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T1>(&mut arg0.protocol_fees, 0x2::balance::split<T1>(&mut v11, v20));
            (v19, v20)
        };
        assert!(v15 - v17 >= arg7, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::amount_threshold());
        assert!(v16 - v18 >= arg8, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::amount_threshold());
        arg5.position_share = arg5.position_share - arg6;
        arg0.total_share = arg0.total_share - arg6;
        update_position_reward_info(arg0, arg2, arg5, (arg5.position_share as u128), arg9);
        let v21 = RemoveEvent{
            vault_id              : 0x2::object::id<Vault>(arg0),
            position_id           : 0x2::object::id<VaultPosition>(arg5),
            before_liquidity      : v3,
            delta_liquidity       : v3 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2),
            before_total_share    : v1,
            delta_share           : arg6,
            amount_a              : v15,
            amount_b              : v16,
            protocol_fee_a_amount : v17,
            protocol_fee_b_amount : v18,
        };
        0x2::event::emit<RemoveEvent>(v21);
        (0x2::coin::from_balance<T0>(v10, arg10), 0x2::coin::from_balance<T1>(v11, arg10))
    }

    public fun collect_reward<T0>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &mut 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::RewarderManager, arg3: &mut VaultPosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(0x2::object::id<Vault>(arg0) == arg3.vault_id, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::mismatch_vault_position_id());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.rewarders, &v0), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::reward_type_mismatch());
        let v1 = 0x2::object::id<Vault>(arg0);
        update_position_reward_info(arg0, arg2, arg3, (arg3.position_share as u128), arg4);
        let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionRewardInfo>(&mut arg3.rewards, &v0);
        let v3 = v2.pending_reward;
        v2.pending_reward = 0;
        v2.reward_harvested = v2.reward_harvested + v3;
        let v4 = PositionRewardClaimedEvent{
            vault_id         : v1,
            position_id      : 0x2::object::id<VaultPosition>(arg3),
            amount           : (v3 as u64),
            reward_type_name : v0,
        };
        0x2::event::emit<PositionRewardClaimedEvent>(v4);
        0x2::coin::from_balance<T0>(0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::withdraw_reward<T0>(arg2, v1, (v3 as u64)), arg5)
    }

    public fun open_position(arg0: &mut Vault, arg1: 0x1::string::String, arg2: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg3: &mut 0x2::tx_context::TxContext) : VaultPosition {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg2);
        arg0.position_index = arg0.position_index + 1;
        let v0 = new_position_name(arg0.name, arg0.index, arg0.position_index);
        let v1 = VaultPosition{
            id             : 0x2::object::new(arg3),
            index          : arg0.position_index,
            name           : v0,
            image_url      : arg1,
            description    : 0x1::string::utf8(b"Parrot Vaults Position"),
            vault_id       : 0x2::object::id<Vault>(arg0),
            position_share : 0,
            rewards        : 0x2::vec_map::empty<0x1::type_name::TypeName, PositionRewardInfo>(),
        };
        let v2 = OpenPositionEvent{
            position_id : 0x2::object::id<VaultPosition>(&v1),
            vault_id    : 0x2::object::id<Vault>(arg0),
            index       : arg0.position_index,
            name        : v0,
            image_url   : arg1,
        };
        0x2::event::emit<OpenPositionEvent>(v2);
        v1
    }

    public fun add_or_update_extension_config(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg4));
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.extension_fields, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.extension_fields, &arg2);
            *v0 = arg3;
            let v1 = UpdateExtensionConfigEvent{
                old_value : *v0,
                new_value : arg3,
            };
            0x2::event::emit<UpdateExtensionConfigEvent>(v1);
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.extension_fields, arg2, arg3);
            let v2 = AddExtensionConfigEvent{
                key   : arg2,
                value : arg3,
            };
            0x2::event::emit<AddExtensionConfigEvent>(v2);
        };
    }

    public fun add_rewarder<T0>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &mut 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::RewarderManager, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.rewarders, &v0), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::reward_already_exists());
        let v1 = 0x2::object::id<Vault>(arg0);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::add_vault<T0>(arg2, v1, arg3, arg4);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.rewarders, v0);
        let v2 = AddRewarderEvent{
            vault_id       : v1,
            rewarder_type  : v0,
            allocate_point : arg3,
        };
        0x2::event::emit<AddRewarderEvent>(v2);
    }

    public fun assert_fee_reward_claimed<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &Vault, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(borrow_position(arg2));
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_fee<T0, T1>(arg0, arg1, v0);
        assert!(v1 == 0 && v2 == 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::fee_claim_err());
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_rewards<T0, T1>(arg0, arg1, v0, arg3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v3)) {
            let v5 = 0;
            assert!(0x1::vector::borrow<u64>(&v3, v4) == &v5, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::mining_claim_err());
            v4 = v4 + 1;
        };
    }

    public fun borrow_mut_position(arg0: &mut Vault) : &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::position_length());
        0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0)
    }

    public fun borrow_position(arg0: &Vault) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::position_length());
        0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, 0)
    }

    public fun calculate_tvl<T0, T1>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::PythOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == arg0.pool, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::pool_id_mismatch());
        assert_fee_reward_claimed<T0, T1>(arg3, arg4, arg0, arg5);
        let (v0, v1) = liquidity_value<T0, T1>(arg0, arg4);
        let v2 = 0;
        let v3 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v4 = *0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::balances(&arg0.free_assets);
        while (v2 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&v4)) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&v4, v2);
            let v7 = *v5;
            let v8 = *v6;
            let v9 = v8;
            if (0x1::type_name::get<T0>() == v7) {
                v9 = v8 + v0;
            } else if (0x1::type_name::get<T1>() == v7) {
                v9 = v8 + v1;
            };
            if (!0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::contain_oracle_info(arg2, v7) || v9 == 0) {
                v2 = v2 + 1;
                continue
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v3, v7, v9);
            v2 = v2 + 1;
        };
        arg0.total_tvl = calculate_tvl_base_on_quote(arg2, v3, arg0.limit_based_type, arg5);
        let v10 = *0x2::tx_context::digest(arg6);
        assert!(v10 != arg0.last_calculate_tvl_tx, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::operation_not_allowed());
        arg0.last_calculate_tvl_tx = v10;
    }

    fun calculate_tvl_base_on_quote(arg0: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::PythOracle, arg1: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : u128 {
        let v0 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::get_price_by_type(arg0, arg2, arg3);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<0x1::type_name::TypeName, u64>(&arg1)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u64>(&arg1, v2);
            let v5 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::get_price_by_type(arg0, *v3, arg3);
            let (v6, _) = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::calculate_prices(&v5, &v0);
            v1 = v1 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v6 as u128), (*v4 as u128), (0x1::u64::pow(10, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::price_multiplier_decimal()) as u128));
            v2 = v2 + 1;
        };
        v1
    }

    public fun check_need_rebalance(arg0: &Vault, arg1: u32, arg2: u128, arg3: u32) : (bool, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let (v0, v1) = next_position_range(arg0.liquidity_range.lower_offset, arg0.liquidity_range.upper_offset, arg1, arg2);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(borrow_position(arg0));
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, v3)) {
            return (true, v0, v1)
        };
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v2)) >= arg3 || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v3)) >= arg3;
        (v4, v0, v1)
    }

    public fun claim_protocol_fee<T0>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_protocol_fee_claim_role(arg1, 0x2::tx_context::sender(arg2));
        let v0 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::withdraw_all<T0>(&mut arg0.protocol_fees);
        let v1 = ClaimProtocolFeeEvent{
            vault_id  : 0x2::object::id<Vault>(arg0),
            amount    : 0x2::balance::value<T0>(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun collect_clmm_fee<T0, T1>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == arg0.pool, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::pool_id_mismatch());
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, 0), true);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        merge_protocol_fee<T0>(arg0, v4);
        let v5 = &mut v2;
        merge_protocol_fee<T1>(arg0, v5);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T0>(&mut arg0.free_assets, v3);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T1>(&mut arg0.free_assets, v2);
        let v6 = FeeClaimedEvent{
            amount_a : 0x2::balance::value<T0>(&v3),
            amount_b : 0x2::balance::value<T1>(&v2),
            vault_id : 0x2::object::id<Vault>(arg0),
        };
        0x2::event::emit<FeeClaimedEvent>(v6);
    }

    public fun collect_clmm_reward<T0, T1, T2>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::position_length());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg4, 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, 0), arg2, true, arg5);
        let v1 = &mut v0;
        merge_protocol_fee<T2>(arg0, v1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T2>(&mut arg0.free_assets, v0);
        let v2 = RewarderClaimedEvent{
            amount        : 0x2::balance::value<T2>(&v0),
            rewarder_type : 0x1::type_name::get<T2>(),
            vault_id      : 0x2::object::id<Vault>(arg0),
        };
        0x2::event::emit<RewarderClaimedEvent>(v2);
    }

    public fun compound<T0, T1>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_compound_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::position_length());
        let (v0, v1, v2, v3, v4) = compound_assets<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        let v5 = CompoundEvent{
            vault_id           : 0x2::object::id<Vault>(arg0),
            amount_a           : v0,
            amount_b           : v1,
            remaining_amount_a : v2,
            remaining_amount_b : v3,
            delta_liquidity    : v4,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
        };
        0x2::event::emit<CompoundEvent>(v5);
    }

    fun compound_assets<T0, T1>(arg0: &mut Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u128) {
        let v0 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::withdraw_all<T0>(&mut arg0.free_assets);
        let v1 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::withdraw_all<T1>(&mut arg0.free_assets);
        let v2 = 0x2::balance::value<T0>(&v0);
        let v3 = 0x2::balance::value<T1>(&v1);
        assert!(v2 > 0 || v3 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::amount_threshold());
        let v4 = &mut v0;
        let v5 = &mut v1;
        let (_, _, v8) = increase_liquidity<T0, T1>(arg0, arg1, arg2, v4, v5, arg3);
        assert!(v8 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::liquidity_zero());
        arg0.liquidity = arg0.liquidity + v8;
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T0>(&mut arg0.free_assets, v0);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T1>(&mut arg0.free_assets, v1);
        (v2, v3, 0x2::balance::value<T0>(&v0), 0x2::balance::value<T1>(&v1), v8)
    }

    public fun create_vault<T0, T1>(arg0: &mut 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg1: &mut 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::RewarderManager, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::ascii::String, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: bool, arg8: u128, arg9: u64, arg10: u32, arg11: u32, arg12: u32, arg13: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg0);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg13));
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        let (v1, v2) = next_position_range(arg10, arg11, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg6), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg6));
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v2);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg5, arg6, v3, v4, arg13);
        let v6 = if (arg7) {
            0x1::type_name::get<T0>()
        } else {
            0x1::type_name::get<T1>()
        };
        let v7 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v7, v5);
        let v8 = LiquidityRange{
            lower_offset        : arg10,
            upper_offset        : arg11,
            rebalance_threshold : arg12,
        };
        let v9 = Vault{
            id                    : 0x2::object::new(arg13),
            index                 : 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::increase_index(arg0),
            position_index        : 0,
            name                  : arg2,
            protocol              : arg3,
            logo                  : arg4,
            pool                  : v0,
            liquidity             : 0,
            protocol_fee_rate     : 0,
            withdraw_fee_rate     : 0,
            is_pause              : false,
            positions             : v7,
            total_share           : 0,
            free_assets           : 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::new_balance_bag(arg13),
            protocol_fees         : 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::new_balance_bag(arg13),
            max_limit             : arg8,
            limit_based_type      : v6,
            slippage              : arg9,
            rewarders             : 0x1::vector::empty<0x1::type_name::TypeName>(),
            extension_fields      : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            total_tvl             : 0,
            last_calculate_tvl_tx : 0x1::vector::empty<u8>(),
            last_deposit_tx       : 0x1::vector::empty<u8>(),
            last_remove_tx        : 0x1::vector::empty<u8>(),
            coin_type_a           : 0x1::type_name::get<T0>(),
            coin_type_b           : 0x1::type_name::get<T1>(),
            liquidity_range       : v8,
        };
        let v10 = 0x2::object::id<Vault>(&v9);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::register_vault(arg1, v10);
        0x2::transfer::share_object<Vault>(v9);
        let v11 = CreateEvent{
            vault_id      : v10,
            clmm_pool     : v0,
            clmm_position : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v5),
            tick_lower    : v3,
            tick_upper    : v4,
        };
        0x2::event::emit<CreateEvent>(v11);
    }

    public fun deposit<T0, T1>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::PythOracle, arg3: &mut 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::RewarderManager, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut VaultPosition, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::position_length());
        assert!(arg6.vault_id == 0x2::object::id<Vault>(arg0), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::mismatch_vault_position_id());
        assert!(arg9 > 0 || arg10 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::amount_threshold());
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5) == arg0.pool, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::pool_id_mismatch());
        let v0 = *0x2::tx_context::digest(arg12);
        assert!(v0 == arg0.last_calculate_tvl_tx, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::tvl_done_err());
        assert!(v0 != arg0.last_deposit_tx, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::operation_not_allowed());
        assert!(v0 != arg0.last_remove_tx, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::operation_not_allowed());
        arg0.last_deposit_tx = v0;
        let v1 = arg0.total_share;
        let v2 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2);
        let v4 = 0x2::coin::value<T0>(&arg7);
        let v5 = 0x2::coin::value<T1>(&arg8);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2) - v3;
        arg0.liquidity = arg0.liquidity + v6;
        let v7 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v7, 0x1::type_name::get<T0>(), v4);
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v7, 0x1::type_name::get<T1>(), v5);
        let v8 = calculate_tvl_base_on_quote(arg2, v7, arg0.limit_based_type, arg11);
        if (arg0.max_limit != 0) {
            assert!(arg0.total_tvl + v8 <= arg0.max_limit, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::quota_exceeded());
        };
        let v9 = (0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::utils::get_lp_amount_by_tvl(v1, v8, arg0.total_tvl) as u64);
        assert!(v9 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::add_amount());
        assert!(v9 < ((0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::constants::uint64_max() - 1) as u64) - v1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::quota_exceeded());
        arg6.position_share = arg6.position_share + v9;
        arg0.total_share = arg0.total_share + v9;
        arg0.total_tvl = arg0.total_tvl + v8;
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T0>(&mut arg0.free_assets, 0x2::coin::into_balance<T0>(arg7));
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T1>(&mut arg0.free_assets, 0x2::coin::into_balance<T1>(arg8));
        let (_, _, _, _, _) = compound_assets<T0, T1>(arg0, arg4, arg5, arg11, arg12);
        update_position_reward_info(arg0, arg3, arg6, (arg6.position_share as u128), arg11);
        let v15 = DepositEvent{
            vault_id           : 0x2::object::id<Vault>(arg0),
            position_id        : 0x2::object::id<VaultPosition>(arg6),
            amount_a           : v4,
            amount_b           : v5,
            before_liquidity   : v3,
            delta_liquidity    : v6,
            before_total_share : v1,
            delta_share        : v9,
        };
        0x2::event::emit<DepositEvent>(v15);
    }

    public fun flash_loan<T0, T1>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::PythOracle, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(arg3 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::flash_loan_amount());
        let v0 = 0x2::object::id<Vault>(arg0);
        arg0.is_pause = true;
        assert!(arg3 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::token_amount_is_zero());
        let v1 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::get_price<T0>(arg2, arg4);
        let v2 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::get_price<T1>(arg2, arg4);
        let (v3, _) = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::calculate_prices(&v1, &v2);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(v3, arg3, 0x1::u64::pow(10, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::price_multiplier_decimal())), 10000 - arg0.slippage, 10000);
        let v6 = 0x1::type_name::get<T1>();
        assert!(v6 == arg0.coin_type_a || v6 == arg0.coin_type_b, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::incorrect_repay());
        let v7 = FlashLoanReceipt{
            vault_id     : v0,
            repay_type   : v6,
            repay_amount : v5,
        };
        let v8 = FlashLoanEvent{
            vault_id     : v0,
            loan_type    : 0x1::type_name::get<T0>(),
            repay_type   : v6,
            amount       : arg3,
            repay_amount : v5,
        };
        0x2::event::emit<FlashLoanEvent>(v8);
        (0x2::coin::from_balance<T0>(0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::split<T0>(&mut arg0.free_assets, arg3), arg5), v7)
    }

    public fun increase_liquidity<T0, T1>(arg0: &mut Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) : (u64, u64, u128) {
        let v0 = 0x2::balance::value<T1>(arg4);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(borrow_position(arg0));
        let (v5, _, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v3, v4, v1, v2, 0x2::balance::value<T0>(arg3), true);
        let v8 = if (v7 <= v0) {
            v5
        } else {
            let (v9, _, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(v3, v4, v1, v2, v0, false);
            v9
        };
        if (v8 == 0) {
            return (0, 0, 0)
        };
        increase_liquidity_to_clmm<T0, T1>(arg0, arg1, arg2, arg3, arg4, v8, arg5)
    }

    fun increase_liquidity_to_clmm<T0, T1>(arg0: &mut Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: u128, arg6: &0x2::clock::Clock) : (u64, u64, u128) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, borrow_mut_position(arg0), arg5, arg6);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v0);
        assert!(v1 <= 0x2::balance::value<T0>(arg3), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::amount_in_above_max_limit());
        assert!(v2 <= 0x2::balance::value<T1>(arg4), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::amount_in_above_max_limit());
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(arg3, v1), 0x2::balance::split<T1>(arg4, v2), v0);
        (v1, v2, arg5)
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.parrot.finance/vaults/position?id={id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://parrot.finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Parrot Vault"));
        let v4 = 0x2::package::claim<CETUS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<VaultPosition>(&v4, v0, v2, arg1);
        0x2::display::update_version<VaultPosition>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VaultPosition>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun liquidity_value<T0, T1>(arg0: &Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = borrow_position(arg0);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), false)
    }

    fun merge_protocol_fee<T0>(arg0: &mut Vault, arg1: &mut 0x2::balance::Balance<T0>) {
        if (arg0.withdraw_fee_rate > 0 && 0x2::balance::value<T0>(arg1) > 0) {
            0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T0>(&mut arg0.protocol_fees, 0x2::balance::split<T0>(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x2::balance::value<T0>(arg1), arg0.protocol_fee_rate, 10000)));
        };
    }

    fun migrate_position<T0, T1>(arg0: &mut Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u128) {
        let v0 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v0);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v0, v1, arg5);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T0>(&mut arg0.free_assets, v4);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T1>(&mut arg0.free_assets, v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v0);
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg4), arg6));
        let v6 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::withdraw_all<T0>(&mut arg0.free_assets);
        let v7 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::withdraw_all<T1>(&mut arg0.free_assets);
        let v8 = &mut v6;
        let v9 = &mut v7;
        let (v10, v11, v12) = increase_liquidity<T0, T1>(arg0, arg1, arg2, v8, v9, arg5);
        let v13 = borrow_mut_position(arg0);
        let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v13);
        let v16 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v13);
        assert!(v16 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::liquidity_zero());
        arg0.liquidity = v16;
        let v17 = 0x2::balance::value<T0>(&v6);
        let v18 = 0x2::balance::value<T1>(&v7);
        let v19 = if (v17 > 0) {
            assert!(v18 == 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::liquidity_mismatch());
            v17
        } else {
            assert!(v17 == 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::liquidity_mismatch());
            v18
        };
        let v20 = MigrateEvent{
            vault_id           : 0x2::object::id<Vault>(arg0),
            old_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            new_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v13),
            remaining_amount   : v19,
            old_tick_lower     : v2,
            old_tick_upper     : v3,
            old_liquidity      : v1,
            new_liquidity      : v16,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2),
            tick_lower         : v14,
            tick_upper         : v15,
        };
        0x2::event::emit<MigrateEvent>(v20);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T0>(&mut arg0.free_assets, v6);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T1>(&mut arg0.free_assets, v7);
        (v10, v11, v17, v18, v12)
    }

    fun new_position_name(arg0: 0x1::string::String, arg1: u64, arg2: u64) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::utils::str(arg1));
        0x1::string::append_utf8(&mut arg0, b"-");
        0x1::string::append(&mut arg0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::utils::str(arg2));
        arg0
    }

    public fun next_position_range(arg0: u32, arg1: u32, arg2: u32, arg3: u128) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg3);
        (round_tick_to_spacing(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0)), arg2), round_tick_to_spacing(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)), arg2))
    }

    public fun pause(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        arg0.is_pause = true;
        let v0 = PauseEvent{vault_id: 0x2::object::id<Vault>(arg0)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun rebalance<T0, T1>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::PythOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_rebalance_role(arg1, 0x2::tx_context::sender(arg6));
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::position_length());
        let (v0, v1, v2) = check_need_rebalance(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::pyth_oracle::get_sqrt_price_from_oracle<T0, T1>(arg2, arg5), arg0.liquidity_range.rebalance_threshold);
        assert!(v0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::pool_not_need_rebalance());
        assert_fee_reward_claimed<T0, T1>(arg3, arg4, arg0, arg5);
        let (v3, v4, v5, v6, v7) = migrate_position<T0, T1>(arg0, arg3, arg4, v1, v2, arg5, arg6);
        let v8 = RebalanceEvent{
            vault_id           : 0x2::object::id<Vault>(arg0),
            amount_a           : v3,
            amount_b           : v4,
            remaining_amount_a : v5,
            remaining_amount_b : v6,
            delta_liquidity    : v7,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4),
        };
        0x2::event::emit<RebalanceEvent>(v8);
    }

    public fun remove_extension_config(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.extension_fields, &arg2), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::ext_field_not_exists());
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.extension_fields, &arg2);
        let v2 = RemoveExtensionConfigEvent{key: arg2};
        0x2::event::emit<RemoveExtensionConfigEvent>(v2);
    }

    public fun repay_flash_loan<T0>(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: FlashLoanReceipt, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg4));
        assert!(arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        arg0.is_pause = false;
        let FlashLoanReceipt {
            vault_id     : v0,
            repay_type   : v1,
            repay_amount : v2,
        } = arg2;
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(0x1::type_name::get<T0>() == v1, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::coin_type_mismatch());
        assert!(v3 >= v2, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::repay_amount());
        assert!(0x2::object::id<Vault>(arg0) == v0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_type_mismatch());
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::balance_bag::join<T0>(&mut arg0.free_assets, 0x2::coin::into_balance<T0>(arg3));
        let v4 = RepayFlashLoanEvent{
            vault_id     : v0,
            repay_type   : v1,
            repay_amount : v3,
        };
        0x2::event::emit<RepayFlashLoanEvent>(v4);
    }

    fun round_tick_to_spacing(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg0)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) % arg1))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(arg0) % arg1))
        }
    }

    public fun unpause(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        arg0.is_pause = false;
        let v0 = UnpauseEvent{vault_id: 0x2::object::id<Vault>(arg0)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public fun update_liquidity_offset(arg0: &mut Vault, arg1: u32, arg2: u32) {
        assert!(arg1 > 0 && arg2 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_liquidity_range());
        arg0.liquidity_range.lower_offset = arg1;
        arg0.liquidity_range.upper_offset = arg2;
        let v0 = UpdateLiquidityOffsetEvent{
            vault_id         : 0x2::object::id<Vault>(arg0),
            old_lower_offset : arg0.liquidity_range.lower_offset,
            old_upper_offset : arg0.liquidity_range.upper_offset,
            new_lower_offset : arg1,
            new_upper_offset : arg2,
        };
        0x2::event::emit<UpdateLiquidityOffsetEvent>(v0);
    }

    public fun update_max_limit(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        arg0.max_limit = arg2;
        let v0 = UpdateMaxQuotaEvent{
            vault_id  : 0x2::object::id<Vault>(arg0),
            old_limit : arg0.max_limit,
            new_limit : arg2,
        };
        0x2::event::emit<UpdateMaxQuotaEvent>(v0);
    }

    fun update_position_reward_info(arg0: &Vault, arg1: &mut 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::RewarderManager, arg2: &VaultPosition, arg3: u128, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<Vault>(arg0);
        let v1 = 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::vault_rewards_settle(arg1, arg0.rewarders, v0, arg4);
        let v2 = arg2.rewards;
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<0x1::type_name::TypeName, u128>(&v1)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(&v1, v3);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, PositionRewardInfo>(&v2, v4)) {
                let v6 = PositionRewardInfo{
                    pending_reward   : 0,
                    reward_debt      : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*v5, (arg2.position_share as u128), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::constants::reward_scale_factor()),
                    reward_harvested : 0,
                };
                0x2::vec_map::insert<0x1::type_name::TypeName, PositionRewardInfo>(&mut v2, *v4, v6);
            } else {
                let v7 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionRewardInfo>(&mut v2, v4);
                v7.pending_reward = v7.pending_reward + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*v5, arg3, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::constants::reward_scale_factor()) - v7.reward_debt;
                v7.reward_debt = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*v5, (arg2.position_share as u128), 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::constants::reward_scale_factor());
            };
            v3 = v3 + 1;
        };
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::rewarder::set_vault_share(arg1, v0, (arg0.total_share as u128));
    }

    public fun update_protocol_fee_rate(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::fee_rate());
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        arg0.protocol_fee_rate = arg2;
        let v0 = UpdateProtocolFeeRateEvent{
            vault_id     : 0x2::object::id<Vault>(arg0),
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateProtocolFeeRateEvent>(v0);
    }

    public fun update_rebalance_threshold(arg0: &mut Vault, arg1: u32) {
        assert!(arg1 > 0, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::invalid_rebalance_threshold());
        arg0.liquidity_range.rebalance_threshold = arg1;
        let v0 = UpdateRebalanceThresholdEvent{
            vault_id                : 0x2::object::id<Vault>(arg0),
            old_rebalance_threshold : arg0.liquidity_range.rebalance_threshold,
            new_rebalance_threshold : arg1,
        };
        0x2::event::emit<UpdateRebalanceThresholdEvent>(v0);
    }

    public fun update_slippage(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 10000, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::fee_rate());
        arg0.slippage = arg2;
        let v0 = UpdateSlippageEvent{
            vault_id     : 0x2::object::id<Vault>(arg0),
            old_slippage : arg0.slippage,
            new_slippage : arg2,
        };
        0x2::event::emit<UpdateSlippageEvent>(v0);
    }

    public fun update_withdraw_fee_rate(arg0: &mut Vault, arg1: &0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::VaultsManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::checked_package_version(arg1);
        0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::fee_rate());
        assert!(!arg0.is_pause, 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::error::vault_paused());
        arg0.withdraw_fee_rate = arg2;
        let v0 = UpdateWithdrawRateEvent{
            vault_id     : 0x2::object::id<Vault>(arg0),
            old_fee_rate : arg0.withdraw_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateWithdrawRateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

