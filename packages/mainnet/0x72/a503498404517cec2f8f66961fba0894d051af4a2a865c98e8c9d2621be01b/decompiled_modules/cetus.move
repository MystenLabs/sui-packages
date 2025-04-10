module 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::cetus {
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
        free_assets: 0x2::bag::Bag,
        protocol_fees: 0x2::bag::Bag,
        max_limit: u128,
        status: u8,
        limit_based_type: 0x1::type_name::TypeName,
        flash_loan_count: u8,
        slippage: u64,
        rewarders: vector<0x1::type_name::TypeName>,
        extension_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
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
        old_slippage: u64,
        new_slippage: u64,
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

    public fun remove<T0, T1>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &mut 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::RewarderManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut VaultPosition, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg0.status == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_status());
        assert!(arg6 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::remove_amount());
        assert!(arg5.position_share >= arg6, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::coin_value());
        assert!(arg5.vault_id == 0x2::object::id<Vault>(arg0), 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::mismatch_vault_position_id());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::position_length());
        let (_, _) = collect_clmm_fee<T0, T1>(arg0, arg3, arg4, arg9);
        let v2 = arg0.total_share;
        let v3 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v3);
        let v5 = 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::utils::get_share_liquidity_by_amount(arg6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v3), v2);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg4, v3, v5, arg9);
        let v8 = v7;
        let v9 = v6;
        arg0.liquidity = arg0.liquidity - v5;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        let (v12, v13) = if (arg0.withdraw_fee_rate == 0) {
            (0, 0)
        } else {
            let v14 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v10, arg0.withdraw_fee_rate, 10000);
            let v15 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v11, arg0.withdraw_fee_rate, 10000);
            merge_protocol_asset<T0>(arg0, 0x2::balance::split<T0>(&mut v9, v14));
            merge_protocol_asset<T1>(arg0, 0x2::balance::split<T1>(&mut v8, v15));
            (v14, v15)
        };
        assert!(v10 - v12 >= arg7, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::amount_threshold());
        assert!(v11 - v13 >= arg8, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::amount_threshold());
        arg5.position_share = arg5.position_share - arg6;
        arg0.total_share = arg0.total_share - arg6;
        update_position_reward_info(arg0, arg2, arg5, (arg5.position_share as u128), arg9);
        let v16 = RemoveEvent{
            vault_id              : 0x2::object::id<Vault>(arg0),
            position_id           : 0x2::object::id<VaultPosition>(arg5),
            before_liquidity      : v4,
            delta_liquidity       : v4 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v3),
            before_total_share    : v2,
            delta_share           : arg6,
            amount_a              : v10,
            amount_b              : v11,
            protocol_fee_a_amount : v12,
            protocol_fee_b_amount : v13,
        };
        0x2::event::emit<RemoveEvent>(v16);
        (0x2::coin::from_balance<T0>(v9, arg10), 0x2::coin::from_balance<T1>(v8, arg10))
    }

    fun add_liquidity_fix_coin<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (arg7) {
            arg5
        } else {
            arg6
        };
        assert!(v0 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::amount_threshold());
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, v0, arg7, arg8);
        repay_add_liquidity<T0, T1>(arg0, arg1, v1, arg3, arg4, arg5, arg6, arg9)
    }

    public fun collect_fee<T0, T1>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg0.status == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_status());
        let v0 = 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions);
        let v1 = 1;
        assert!(&v0 == &v1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::position_length());
        let (_, _) = collect_clmm_fee<T0, T1>(arg0, arg2, arg3, arg4);
    }

    public fun collect_reward<T0>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &mut 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::RewarderManager, arg3: &mut VaultPosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg0.status == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_status());
        assert!(0x2::object::id<Vault>(arg0) == arg3.vault_id, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::mismatch_vault_position_id());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.rewarders, &v0), 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::reward_type_mismatch());
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
        0x2::coin::from_balance<T0>(0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::withdraw_reward<T0>(arg2, v1, (v3 as u64)), arg5)
    }

    public fun open_position(arg0: &mut Vault, arg1: 0x1::string::String, arg2: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg3: &mut 0x2::tx_context::TxContext) : VaultPosition {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg2);
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

    fun repay_add_liquidity<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&arg2);
        assert!(v0 <= arg5, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::amount_threshold());
        assert!(v1 <= arg6, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::amount_threshold());
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v1, arg7)), arg2);
        (0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4))
    }

    public fun add_or_update_extension_config(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg4));
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

    public fun add_rewarder<T0>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &mut 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::RewarderManager, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.rewarders, &v0), 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::reward_already_exists());
        let v1 = 0x2::object::id<Vault>(arg0);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::add_vault<T0>(arg2, v1, arg3, arg4);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.rewarders, v0);
        let v2 = AddRewarderEvent{
            vault_id       : v1,
            rewarder_type  : v0,
            allocate_point : arg3,
        };
        0x2::event::emit<AddRewarderEvent>(v2);
    }

    fun calculate_updated_limit<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: u128, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let (v1, v2) = 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::utils::get_amount_by_liquidity(arg3, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), v0, arg2, true);
        assert!(0x1::type_name::get<T0>() == arg1 || 0x1::type_name::get<T1>() == arg1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::coin_type_mismatch());
        get_tvl_of_based_coin(v0, v1, v2, 0x1::type_name::get<T0>() == arg1)
    }

    fun check_is_fix_coin_a(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u64, arg5: u64) : (bool, u64, u64) {
        let (_, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(arg0, arg1, arg2, arg3, arg4, true);
        assert!(v1 == arg4, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::liquidity_calculation());
        if (v2 <= arg5) {
            return (true, v1, v2)
        };
        let (_, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(arg0, arg1, arg2, arg3, arg5, false);
        assert!(v5 == arg5, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::liquidity_calculation());
        (false, v4, v5)
    }

    public fun claim_protocol_fee<T0>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_protocol_fee_claim_role(arg1, 0x2::tx_context::sender(arg2));
        let v0 = take_protocol_asset<T0>(arg0);
        let v1 = ClaimProtocolFeeEvent{
            vault_id  : 0x2::object::id<Vault>(arg0),
            amount    : 0x2::balance::value<T0>(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    fun collect_clmm_fee<T0, T1>(arg0: &mut Vault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, 0), true);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x2::balance::value<T1>(&v2);
        let v6 = &mut v3;
        merge_protocol_fee<T0>(arg0, v6);
        let v7 = &mut v2;
        merge_protocol_fee<T1>(arg0, v7);
        merge_free_asset<T0>(arg0, v3);
        merge_free_asset<T1>(arg0, v2);
        let v8 = FeeClaimedEvent{
            amount_a : v4,
            amount_b : v5,
            vault_id : 0x2::object::id<Vault>(arg0),
        };
        0x2::event::emit<FeeClaimedEvent>(v8);
        (v4, v5)
    }

    public fun collect_clmm_reward<T0, T1, T2>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg6));
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg0.status == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_status());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::position_length());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg4, 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, 0), arg2, true, arg5);
        let v1 = &mut v0;
        merge_protocol_fee<T2>(arg0, v1);
        merge_free_asset<T2>(arg0, v0);
        let v2 = RewarderClaimedEvent{
            amount        : 0x2::balance::value<T2>(&v0),
            rewarder_type : 0x1::type_name::get<T2>(),
            vault_id      : 0x2::object::id<Vault>(arg0),
        };
        0x2::event::emit<RewarderClaimedEvent>(v2);
    }

    public fun compound<T0, T1>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_compound_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg0.status == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_status());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::position_length());
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
        let v0 = take_free_asset<T0>(arg0);
        let v1 = 0x2::coin::from_balance<T0>(v0, arg4);
        let v2 = take_free_asset<T1>(arg0);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg4);
        let v4 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v4);
        let v7 = 0x2::coin::value<T0>(&v1);
        let v8 = 0x2::coin::value<T1>(&v3);
        assert!(v7 > 0 || v8 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::amount_threshold());
        let (v9, v10, v11) = check_is_fix_coin_a(v5, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2), v7, v8);
        let (v12, v13) = if (v9) {
            (v7, v11 + v11 * arg0.slippage / 10000)
        } else {
            (v10 + v10 * arg0.slippage / 10000, v8)
        };
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4);
        let (v15, v16) = add_liquidity_fix_coin<T0, T1>(arg1, arg2, v4, v1, v3, v12, v13, v9, arg3, arg4);
        let v17 = v16;
        let v18 = v15;
        let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4) - v14;
        assert!(v19 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::liquidity_zero());
        arg0.liquidity = arg0.liquidity + v19;
        merge_free_asset<T0>(arg0, v18);
        merge_free_asset<T1>(arg0, v17);
        (v7, v8, 0x2::balance::value<T0>(&v18), 0x2::balance::value<T1>(&v17), v19)
    }

    public fun create_vault<T0, T1>(arg0: &mut 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg1: &mut 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::RewarderManager, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::ascii::String, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u32, arg8: u32, arg9: bool, arg10: u128, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg0);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg12));
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg5, arg6, arg7, arg8, arg12);
        let v2 = if (arg9) {
            0x1::type_name::get<T0>()
        } else {
            0x1::type_name::get<T1>()
        };
        let v3 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v3, v1);
        let v4 = Vault{
            id                : 0x2::object::new(arg12),
            index             : 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::increase_index(arg0),
            position_index    : 0,
            name              : arg2,
            protocol          : arg3,
            logo              : arg4,
            pool              : v0,
            liquidity         : 0,
            protocol_fee_rate : 0,
            withdraw_fee_rate : 0,
            is_pause          : false,
            positions         : v3,
            total_share       : 0,
            free_assets       : 0x2::bag::new(arg12),
            protocol_fees     : 0x2::bag::new(arg12),
            max_limit         : arg10,
            status            : 1,
            limit_based_type  : v2,
            flash_loan_count  : 0,
            slippage          : arg11,
            rewarders         : 0x1::vector::empty<0x1::type_name::TypeName>(),
            extension_fields  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        let v5 = 0x2::object::id<Vault>(&v4);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::register_vault(arg1, v5);
        0x2::transfer::share_object<Vault>(v4);
        let v6 = CreateEvent{
            vault_id      : v5,
            clmm_pool     : v0,
            clmm_position : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            tick_lower    : arg7,
            tick_upper    : arg8,
        };
        0x2::event::emit<CreateEvent>(v6);
    }

    public fun deposit<T0, T1>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &mut 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::RewarderManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut VaultPosition, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg0.status == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_status());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::position_length());
        assert!(arg5.vault_id == 0x2::object::id<Vault>(arg0), 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::mismatch_vault_position_id());
        assert!(arg8 > 0 || arg9 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::amount_threshold());
        let (_, _) = collect_clmm_fee<T0, T1>(arg0, arg3, arg4, arg11);
        let v2 = arg0.total_share;
        let v3 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, 0);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v3);
        let (v5, v6) = add_liquidity_fix_coin<T0, T1>(arg3, arg4, v3, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v3) - v4;
        arg0.liquidity = arg0.liquidity + v9;
        if (arg0.max_limit != 0) {
            let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v3);
            assert!(calculate_updated_limit<T0, T1>(arg4, arg0.limit_based_type, arg0.liquidity, v10, v11) <= arg0.max_limit, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::quota_exceeded());
        };
        let v12 = (0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::utils::get_lp_amount_by_liquidity(v2, v9, v4) as u64);
        assert!(v12 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::add_amount());
        assert!(v12 < ((0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::uint64_max() - 1) as u64) - v2, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::quota_exceeded());
        arg5.position_share = arg5.position_share + v12;
        arg0.total_share = arg0.total_share + v12;
        update_position_reward_info(arg0, arg2, arg5, (arg5.position_share as u128), arg11);
        let v13 = DepositEvent{
            vault_id           : 0x2::object::id<Vault>(arg0),
            position_id        : 0x2::object::id<VaultPosition>(arg5),
            amount_a           : 0x2::coin::value<T0>(&arg6) - 0x2::balance::value<T0>(&v8),
            amount_b           : 0x2::coin::value<T1>(&arg7) - 0x2::balance::value<T1>(&v7),
            before_liquidity   : v4,
            delta_liquidity    : v9,
            before_total_share : v2,
            delta_share        : v12,
        };
        0x2::event::emit<DepositEvent>(v13);
        (0x2::coin::from_balance<T0>(v8, arg12), 0x2::coin::from_balance<T1>(v7, arg12))
    }

    public fun flash_loan<T0, T1>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, FlashLoanReceipt) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg3 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::flash_loan_amount());
        assert!(arg0.flash_loan_count == 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::flash_loan_count());
        let v0 = 0x2::object::id<Vault>(arg0);
        arg0.flash_loan_count = arg0.flash_loan_count + 1;
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2);
        let v2 = (v1 as u256) * 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier() / 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::uint64_max();
        let (v3, v4, v5) = if (arg4) {
            let v6 = take_free_asset_by_amount<T0>(arg0, arg3);
            (0x2::coin::from_balance<T0>(v6, arg5), 0x2::coin::zero<T1>(arg5), (((arg3 as u256) * v2 * v2 / 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier() / 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier()) as u64))
        } else {
            let v7 = take_free_asset_by_amount<T1>(arg0, arg3);
            (0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(v7, arg5), (((arg3 as u256) * 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier() / v2 * v2 / 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier()) as u64))
        };
        let v8 = v5 - v5 * arg0.slippage / 10000;
        let (v9, v10) = if (arg4) {
            (0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
        } else {
            (0x1::type_name::get<T1>(), 0x1::type_name::get<T0>())
        };
        let v11 = FlashLoanReceipt{
            vault_id     : v0,
            repay_type   : v10,
            repay_amount : v8,
        };
        let v12 = FlashLoanEvent{
            vault_id           : v0,
            loan_type          : v9,
            repay_type         : v10,
            amount             : arg3,
            repay_amount       : v8,
            oracle_pool        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2),
            current_sqrt_price : v1,
        };
        0x2::event::emit<FlashLoanEvent>(v12);
        (v3, v4, v11)
    }

    fun free_assets_amount<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.free_assets, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.free_assets, v0))
    }

    fun get_tvl_of_based_coin(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : u128 {
        let v0 = (arg0 as u256) * 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier() / 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::uint64_max();
        if (arg3) {
            (arg1 as u128) + (((arg2 as u256) * 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier() / v0 * v0 / 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier()) as u128)
        } else {
            (arg2 as u128) + (((arg1 as u256) * v0 * v0 / 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier() / 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::multiplier()) as u128)
        }
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

    fun merge_free_asset<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.free_assets, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.free_assets, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.free_assets, v0, arg1);
        };
    }

    fun merge_protocol_asset<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
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

    fun merge_protocol_fee<T0>(arg0: &mut Vault, arg1: &mut 0x2::balance::Balance<T0>) {
        if (arg0.withdraw_fee_rate > 0 && 0x2::balance::value<T0>(arg1) > 0) {
            let v0 = 0x2::balance::split<T0>(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x2::balance::value<T0>(arg1), arg0.protocol_fee_rate, 10000));
            merge_protocol_asset<T0>(arg0, v0);
        };
    }

    public fun migrate<T0, T1>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_rebalance_role(arg1, 0x2::tx_context::sender(arg7));
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg0.status == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_status());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::position_length());
        arg0.status = 2;
        let v0 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v0);
        let (_, _) = collect_clmm_fee<T0, T1>(arg0, arg2, arg3, arg6);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut v0, v1, arg6);
        merge_free_asset<T0>(arg0, v6);
        merge_free_asset<T1>(arg0, v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg3, v0);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg7);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v8);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let v12 = free_assets_amount<T0>(arg0);
        let v13 = free_assets_amount<T1>(arg0);
        let (v14, v15, v16) = check_is_fix_coin_a(v9, v10, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), v11, v12, v13);
        let (v17, v18) = if (v14) {
            let v18 = v16 + v16 * arg0.slippage / 10000;
            (v12, v18)
        } else {
            let v17 = v15 + v15 * arg0.slippage / 10000;
            (v17, v13)
        };
        let v19 = take_free_asset<T0>(arg0);
        let v20 = take_free_asset<T1>(arg0);
        let v21 = &mut v8;
        let v22 = 0x2::coin::from_balance<T0>(v19, arg7);
        let v23 = 0x2::coin::from_balance<T1>(v20, arg7);
        let (v24, v25) = add_liquidity_fix_coin<T0, T1>(arg2, arg3, v21, v22, v23, v17, v18, v14, arg6, arg7);
        let v26 = v25;
        let v27 = v24;
        let v28 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v8);
        assert!(v28 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::liquidity_zero());
        arg0.liquidity = v28;
        let v29 = if (v14) {
            assert!(0x2::balance::value<T0>(&v27) == 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::liquidity_mismatch());
            0x2::balance::value<T1>(&v26)
        } else {
            assert!(0x2::balance::value<T1>(&v26) == 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::liquidity_mismatch());
            0x2::balance::value<T0>(&v27)
        };
        let v30 = MigrateEvent{
            vault_id           : 0x2::object::id<Vault>(arg0),
            old_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            new_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v8),
            remaining_amount   : v29,
            old_tick_lower     : v2,
            old_tick_upper     : v3,
            old_liquidity      : v1,
            new_liquidity      : v28,
            current_sqrt_price : v11,
            tick_lower         : v9,
            tick_upper         : v10,
        };
        0x2::event::emit<MigrateEvent>(v30);
        merge_free_asset<T0>(arg0, v27);
        merge_free_asset<T1>(arg0, v26);
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, v8);
    }

    fun new_position_name(arg0: 0x1::string::String, arg1: u64, arg2: u64) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::utils::str(arg1));
        0x1::string::append_utf8(&mut arg0, b"-");
        0x1::string::append(&mut arg0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::utils::str(arg2));
        arg0
    }

    public fun pause(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        arg0.is_pause = true;
        let v0 = PauseEvent{vault_id: 0x2::object::id<Vault>(arg0)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun rebalance<T0, T1>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_rebalance_role(arg1, 0x2::tx_context::sender(arg5));
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        assert!(arg0.status == 2, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_status());
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::position_length());
        assert!(arg0.flash_loan_count == 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::flash_loan_count());
        let (v0, v1, v2, v3, v4) = compound_assets<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        let v5 = RebalanceEvent{
            vault_id           : 0x2::object::id<Vault>(arg0),
            amount_a           : v0,
            amount_b           : v1,
            remaining_amount_a : v2,
            remaining_amount_b : v3,
            delta_liquidity    : v4,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
        };
        0x2::event::emit<RebalanceEvent>(v5);
        arg0.status = 1;
    }

    public fun remove_extension_config(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.extension_fields, &arg2), 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::ext_field_not_exists());
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.extension_fields, &arg2);
        let v2 = RemoveExtensionConfigEvent{key: arg2};
        0x2::event::emit<RemoveExtensionConfigEvent>(v2);
    }

    public fun repay_flash_loan<T0>(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: FlashLoanReceipt, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_operation_role(arg1, 0x2::tx_context::sender(arg4));
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        arg0.flash_loan_count = arg0.flash_loan_count - 1;
        let FlashLoanReceipt {
            vault_id     : v0,
            repay_type   : v1,
            repay_amount : v2,
        } = arg2;
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(0x1::type_name::get<T0>() == v1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::coin_type_mismatch());
        assert!(v3 >= v2, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::repay_amount());
        assert!(0x2::object::id<Vault>(arg0) == v0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_type_mismatch());
        merge_free_asset<T0>(arg0, 0x2::coin::into_balance<T0>(arg3));
        let v4 = RepayFlashLoanEvent{
            vault_id     : v0,
            repay_type   : v1,
            repay_amount : v3,
        };
        0x2::event::emit<RepayFlashLoanEvent>(v4);
    }

    fun take_free_asset<T0>(arg0: &mut Vault) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.free_assets, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.free_assets, v0)
    }

    fun take_free_asset_by_amount<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::amount_threshold());
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.free_assets, v0), 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::asset_not_found());
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.free_assets, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::balance_insufficient());
        0x2::balance::split<T0>(v1, arg1)
    }

    fun take_protocol_asset<T0>(arg0: &mut Vault) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0)
    }

    public fun unpause(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg2));
        arg0.is_pause = false;
        let v0 = UnpauseEvent{vault_id: 0x2::object::id<Vault>(arg0)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public fun update_max_limit(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        arg0.max_limit = arg2;
        let v0 = UpdateMaxQuotaEvent{
            vault_id  : 0x2::object::id<Vault>(arg0),
            old_limit : arg0.max_limit,
            new_limit : arg2,
        };
        0x2::event::emit<UpdateMaxQuotaEvent>(v0);
    }

    fun update_position_reward_info(arg0: &Vault, arg1: &mut 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::RewarderManager, arg2: &VaultPosition, arg3: u128, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<Vault>(arg0);
        let v1 = 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::vault_rewards_settle(arg1, arg0.rewarders, v0, arg4);
        let v2 = arg2.rewards;
        let v3 = 0;
        while (v3 < 0x2::vec_map::size<0x1::type_name::TypeName, u128>(&v1)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(&v1, v3);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, PositionRewardInfo>(&v2, v4)) {
                let v6 = PositionRewardInfo{
                    pending_reward   : 0,
                    reward_debt      : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*v5, (arg2.position_share as u128), 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::reward_scale_factor()),
                    reward_harvested : 0,
                };
                0x2::vec_map::insert<0x1::type_name::TypeName, PositionRewardInfo>(&mut v2, *v4, v6);
            } else {
                let v7 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, PositionRewardInfo>(&mut v2, v4);
                v7.pending_reward = v7.pending_reward + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*v5, arg3, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::reward_scale_factor()) - v7.reward_debt;
                v7.reward_debt = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(*v5, (arg2.position_share as u128), 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::constants::reward_scale_factor());
            };
            v3 = v3 + 1;
        };
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::rewarder::set_vault_share(arg1, v0, (arg0.total_share as u128));
    }

    public fun update_protocol_fee_rate(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::fee_rate());
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
        arg0.protocol_fee_rate = arg2;
        let v0 = UpdateProtocolFeeRateEvent{
            vault_id     : 0x2::object::id<Vault>(arg0),
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateProtocolFeeRateEvent>(v0);
    }

    public fun update_slippage(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 10000, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::fee_rate());
        arg0.slippage = arg2;
        let v0 = UpdateSlippageEvent{
            old_slippage : arg0.slippage,
            new_slippage : arg2,
        };
        0x2::event::emit<UpdateSlippageEvent>(v0);
    }

    public fun update_withdraw_fee_rate(arg0: &mut Vault, arg1: &0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::VaultsManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::checked_package_version(arg1);
        0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::vaults_manager::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::fee_rate());
        assert!(!arg0.is_pause, 0xaf0babdb56090a40343ce4eb0f007c756969226887ad2536068889ad8ffcee96::error::vault_paused());
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

