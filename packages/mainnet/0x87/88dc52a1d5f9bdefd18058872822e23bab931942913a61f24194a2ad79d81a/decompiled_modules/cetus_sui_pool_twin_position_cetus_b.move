module 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_pool_twin_position_cetus_b {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        image_url: vector<u8>,
        underlying_pool_id: 0x2::object::ID,
        investor_id: 0x2::object::ID,
        x_token_supply: u128,
        y_token_supply: u128,
        major_position_liquidity: u128,
        minor_position_liquidity: u128,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        acc_rewards_per_ytoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        paused: bool,
    }

    struct CETUS_SUI_POOL_TWIN_POSITION_CETUS_B has drop {
        dummy_field: bool,
    }

    struct RewardEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    struct OnholdReceiptEvent has copy, drop {
        receipt_id: 0x2::object::ID,
        sender: address,
    }

    struct DepositEvent has copy, drop {
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        investor_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        major_liquidity_before: u128,
        minor_liquidity_before: u128,
        major_liquidity_deposited: u128,
        minor_liquidity_deposited: u128,
        major_liquidity_after: u128,
        minor_liquidity_after: u128,
        sender: address,
        receipt_id: 0x2::object::ID,
        current_tick: u32,
        current_sqrt_price: u128,
        xtoken_amount: u128,
        ytoken_amount: u128,
        major_exchange_rate: u256,
        minor_exchange_rate: u256,
    }

    struct ReceiptDestroyEvent has copy, drop {
        receipt_id: 0x2::object::ID,
    }

    struct WithdrawEvent has copy, drop {
        receipt_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        major_liquidity_to_withdraw: u128,
        minor_liquidity_to_withdraw: u128,
        x_token_supply: u128,
        y_token_supply: u128,
        x_amount: u128,
        y_amount: u128,
        amount_a: u64,
        amount_b: u64,
        sender: address,
        major_exchange_rate: u256,
        minor_exchange_rate: u256,
        cetus_pool_id: 0x2::object::ID,
        current_tick: u32,
        current_sqrt_price: u128,
        major_liquidity_before: u128,
        minor_liquidity_before: u128,
        major_liquidity_after: u128,
        minor_liquidity_after: u128,
    }

    struct UserEmergencyWithdrawEvent has copy, drop {
        receipt_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        x_token_supply: u128,
        y_token_supply: u128,
        x_amount: u128,
        y_amount: u128,
        amount_a: u64,
        amount_b: u64,
        sender: address,
    }

    struct PoolCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        underlying_pool_id: 0x2::object::ID,
        investor_id: 0x2::object::ID,
    }

    struct UpdatePoolLiqiudityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        major_liquidity_before: u128,
        minor_liquidity_before: u128,
        major_liquidity_after: u128,
        minor_liquidity_after: u128,
        autocompound_amount_a: u64,
        autocompound_amount_b: u64,
    }

    struct AddRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun user_emergency_withdraw<T0, T1>(arg0: 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt, arg1: &mut Pool<T0, T1>, arg2: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.investor_id == 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>>(arg3), 9223374622425087999);
        if (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::owner(&arg0) != 0x2::tx_context::sender(arg5)) {
            let v0 = OnholdReceiptEvent{
                receipt_id : 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0),
                sender     : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<OnholdReceiptEvent>(v0);
            0x2::transfer::public_transfer<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(arg0, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_onhold_receipts_wallet_address(arg2));
            return
        };
        assert!(arg1.paused, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::pool_paused());
        assert_receipt<T0, T1>(&arg0, arg1);
        get_rewards<T0, T1, 0x2::sui::SUI>(arg1, arg2, arg4, arg5);
        let v1 = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::x_token_balance(&arg0);
        let v2 = arg1.x_token_supply;
        arg1.x_token_supply = arg1.x_token_supply - v1;
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::sub_x_token_balance(&mut arg0, v1);
        let v3 = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::y_token_balance(&arg0);
        let v4 = arg1.y_token_supply;
        arg1.y_token_supply = arg1.y_token_supply - v3;
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::sub_y_token_balance(&mut arg0, v3);
        let (v5, v6) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::user_emergency_withdraw<T0, T1>(arg3, v1, v2, v3, v4);
        let (v7, v8) = collect_withdraw_fee<T0, T1>(arg1, arg2, v5, v6, arg5);
        let v9 = v8;
        let v10 = v7;
        let v11 = UserEmergencyWithdrawEvent{
            receipt_id     : 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0),
            coin_type_a    : 0x1::type_name::get<T0>(),
            coin_type_b    : 0x1::type_name::get<T1>(),
            x_token_supply : v2,
            y_token_supply : v4,
            x_amount       : v1,
            y_amount       : v3,
            amount_a       : 0x2::balance::value<T0>(&v10),
            amount_b       : 0x2::balance::value<T1>(&v9),
            sender         : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UserEmergencyWithdrawEvent>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg5), 0x2::tx_context::sender(arg5));
        destroy_receipt_and_transfer_rewards<T0, T1>(arg0, arg1, arg2, arg4, arg5);
    }

    fun add_rewards<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, &v0);
            *v1 = *v1 + (0x2::balance::value<T2>(&arg1) as u256) * (1000000000 as u256) / (arg0.x_token_supply as u256);
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, (0x2::balance::value<T2>(&arg1) as u256) * (1000000000 as u256) / (arg0.x_token_supply as u256));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, arg1);
        };
    }

    fun assert_receipt<T0, T1>(arg0: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt, arg1: &Pool<T0, T1>) {
        assert!(0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::pool_id(arg0) == 0x2::object::id<Pool<T0, T1>>(arg1), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::invalid_receipt_error());
    }

    fun collect_deposit_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, (((0x2::balance::value<T0>(&arg2) as u128) * (arg0.deposit_fee as u128) / 10000) as u64)), arg4), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3, (((0x2::balance::value<T1>(&arg3) as u128) * (arg0.deposit_fee as u128) / 10000) as u64)), arg4), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        (arg2, arg3)
    }

    fun collect_withdraw_fee<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, (((0x2::balance::value<T0>(&arg2) as u128) * (arg0.withdrawal_fee as u128) / 10000) as u64)), arg4), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3, (((0x2::balance::value<T1>(&arg3) as u128) * (arg0.withdrawal_fee as u128) / 10000) as u64)), arg4), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_fee_wallet_address(arg1));
        (arg2, arg3)
    }

    public fun create<T0, T1>(arg0: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::DevCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id                       : 0x2::object::new(arg5),
            name                     : arg3,
            image_url                : arg4,
            underlying_pool_id       : arg1,
            investor_id              : arg2,
            x_token_supply           : 0,
            y_token_supply           : 0,
            major_position_liquidity : 0,
            minor_position_liquidity : 0,
            rewards                  : 0x2::bag::new(arg5),
            acc_rewards_per_xtoken   : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            acc_rewards_per_ytoken   : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            deposit_fee              : 0,
            deposit_fee_max_cap      : 100,
            withdrawal_fee           : 0,
            withdraw_fee_max_cap     : 100,
            paused                   : false,
        };
        0x2::transfer::public_share_object<Pool<T0, T1>>(v0);
        let v1 = PoolCreatedEvent{
            id                 : 0x2::object::id<Pool<T0, T1>>(&v0),
            coin_a             : 0x1::type_name::get<T0>(),
            coin_b             : 0x1::type_name::get<T1>(),
            underlying_pool_id : arg1,
            investor_id        : arg2,
        };
        0x2::event::emit<PoolCreatedEvent>(v1);
    }

    public fun deposit<T0, T1>(arg0: 0x1::option::Option<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg5: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt> {
        assert!(arg1.underlying_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg9), 9223373063351959551);
        assert!(arg1.investor_id == 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>>(arg5), 9223373067646926847);
        if (0x1::option::is_some<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0)) {
            if (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::owner(0x1::option::borrow<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0)) != 0x2::tx_context::sender(arg11)) {
                let v0 = 0x1::option::extract<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&mut arg0);
                let v1 = OnholdReceiptEvent{
                    receipt_id : 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&v0),
                    sender     : 0x2::tx_context::sender(arg11),
                };
                0x2::event::emit<OnholdReceiptEvent>(v1);
                0x2::transfer::public_transfer<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(v0, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_onhold_receipts_wallet_address(arg4));
                0x1::option::destroy_none<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(arg0);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg11));
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg11));
                return 0x1::option::none<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>()
            };
        };
        assert!(!arg1.paused, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::pool_paused());
        assert!(0x2::coin::value<T0>(&arg2) > 0 && 0x2::coin::value<T1>(&arg3) > 0, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::zero_deposit_error());
        update_pool_underlying_liquidity<T0, T1>(arg1, arg5, arg4, arg6, arg7, arg8, arg9, arg10, arg11);
        get_rewards<T0, T1, 0x2::sui::SUI>(arg1, arg4, arg10, arg11);
        if (0x1::option::is_some<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0)) {
            assert_receipt<T0, T1>(0x1::option::borrow_mut<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&mut arg0), arg1);
        };
        let (v2, v3) = collect_deposit_fee<T0, T1>(arg1, arg4, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg11);
        let v4 = v3;
        let v5 = v2;
        let v6 = arg1.major_position_liquidity;
        let v7 = arg1.minor_position_liquidity;
        let (v8, v9) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::split_major_minor_by_amount<T0, T1>(arg5, arg9, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), true);
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::split_major_minor_by_amount<T0, T1>(arg5, arg9, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), false);
        let v14 = v13;
        let v15 = v12;
        let v16 = (0x2::balance::value<T0>(&v5) - 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_a(&v11) - 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_a(&v10)) * (0x2::balance::value<T1>(&v4) - 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_b(&v11) - 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_b(&v10)) <= (0x2::balance::value<T0>(&v5) - 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_a(&v15) - 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_a(&v14)) * (0x2::balance::value<T1>(&v4) - 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_b(&v15) - 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_b(&v14));
        let v17 = if (v16) {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_a(&v11)
        } else {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_a(&v15)
        };
        let v18 = if (v16) {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_b(&v11)
        } else {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_b(&v15)
        };
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::deposit_major<T0, T1>(arg5, arg6, arg9, 0x2::balance::split<T0>(&mut v5, v17), 0x2::balance::split<T1>(&mut v4, v18), arg10);
        let v19 = if (v16) {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_a(&v10)
        } else {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_a(&v14)
        };
        let v20 = if (v16) {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_b(&v10)
        } else {
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::liquidity_amounts_amount_b(&v14)
        };
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::deposit_minor<T0, T1>(arg5, arg6, arg9, 0x2::balance::split<T0>(&mut v5, v19), 0x2::balance::split<T1>(&mut v4, v20), arg10);
        let (v21, v22) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::get_total_liquidity<T0, T1>(arg5);
        arg1.major_position_liquidity = v21;
        arg1.minor_position_liquidity = v22;
        let (v23, v24) = exchange_rate<T0, T1>(arg1);
        let v25 = ((arg1.major_position_liquidity - v6) as u256) * (1000000000 as u256) / v23;
        let v26 = ((arg1.minor_position_liquidity - v7) as u256) * (1000000000 as u256) / v24;
        assert!(v25 > 0 && v26 >= 0, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::insufficient_deposit_amount());
        arg1.x_token_supply = arg1.x_token_supply + (v25 as u128);
        arg1.y_token_supply = arg1.y_token_supply + (v26 as u128);
        let v27 = if (0x1::option::is_some<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0)) {
            let v28 = 0x1::option::extract<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&mut arg0);
            let v29 = &mut v28;
            update_user_rewards<T0, T1, 0x2::sui::SUI>(v29, arg1);
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::add_x_token_balance(&mut v28, (v25 as u128));
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::add_y_token_balance(&mut v28, (v26 as u128));
            v28
        } else {
            let v30 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v31 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
            let v32 = 0;
            while (v32 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg1.acc_rewards_per_xtoken)) {
                let (v33, v34) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, v32);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v30, *v33, *v34);
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v31, *v33, 0);
                v32 = v32 + 1;
            };
            let v35 = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::create_with(0x1::string::utf8(arg1.name), 0x1::string::utf8(arg1.image_url), 0x2::object::id<Pool<T0, T1>>(arg1), v31, v30, 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(), arg11);
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::add_x_token_balance(&mut v35, (v25 as u128));
            0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::add_y_token_balance(&mut v35, (v26 as u128));
            v35
        };
        let v36 = v27;
        0x1::option::destroy_none<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(arg0);
        let v37 = DepositEvent{
            coin_type_a               : 0x1::type_name::get<T0>(),
            coin_type_b               : 0x1::type_name::get<T1>(),
            pool_id                   : 0x2::object::id<Pool<T0, T1>>(arg1),
            investor_id               : 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>>(arg5),
            cetus_pool_id             : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg9),
            major_liquidity_before    : v6,
            minor_liquidity_before    : v7,
            major_liquidity_deposited : arg1.major_position_liquidity - v6,
            minor_liquidity_deposited : arg1.minor_position_liquidity - v7,
            major_liquidity_after     : arg1.major_position_liquidity,
            minor_liquidity_after     : arg1.minor_position_liquidity,
            sender                    : 0x2::tx_context::sender(arg11),
            receipt_id                : 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&v36),
            current_tick              : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg9)),
            current_sqrt_price        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg9),
            xtoken_amount             : (v25 as u128),
            ytoken_amount             : (v26 as u128),
            major_exchange_rate       : v23,
            minor_exchange_rate       : v24,
        };
        0x2::event::emit<DepositEvent>(v37);
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::receive_free_balances<T0, T1>(arg5, v5, v4);
        0x1::option::some<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(v36)
    }

    public entry fun destroy_receipt_and_transfer_rewards<T0, T1>(arg0: 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt, arg1: &mut Pool<T0, T1>, arg2: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_receipt<T0, T1>(&arg0, arg1);
        assert!(0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::x_token_balance(&arg0) == 0 && 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::y_token_balance(&arg0) == 0, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::receipt_not_empty());
        let v0 = &mut arg0;
        get_user_rewards_all<T0, T1, 0x2::sui::SUI>(v0, arg1, arg2, arg3, arg4);
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::destroy(arg0);
        let v1 = ReceiptDestroyEvent{receipt_id: 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0)};
        0x2::event::emit<ReceiptDestroyEvent>(v1);
    }

    fun exchange_rate<T0, T1>(arg0: &Pool<T0, T1>) : (u256, u256) {
        if (arg0.major_position_liquidity == 0 || arg0.x_token_supply == 0) {
            ((1000000000 as u256), (1000000000 as u256))
        } else {
            ((arg0.major_position_liquidity as u256) * (1000000000 as u256) / (arg0.x_token_supply as u256), (arg0.minor_position_liquidity as u256) * (1000000000 as u256) / (arg0.y_token_supply as u256))
        }
    }

    fun get_rewards<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u256>(&arg0.acc_rewards_per_xtoken, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut arg0.acc_rewards_per_xtoken, v0, 0);
        };
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0)) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, 0x2::balance::zero<T2>());
            };
        };
        if (arg0.x_token_supply == 0) {
            return
        };
        let v1 = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_rewards<T2>(arg1, 0x2::object::id<Pool<T0, T1>>(arg0), arg2, arg3);
        add_rewards<T0, T1, T2>(arg0, v1);
        let v2 = AddRewardEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward_type : 0x1::type_name::get<T2>(),
            amount      : 0x2::balance::value<T2>(&v1),
        };
        0x2::event::emit<AddRewardEvent>(v2);
    }

    fun get_user_rewards<T0, T1, T2>(arg0: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt, arg1: &mut Pool<T0, T1>, arg2: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        get_rewards<T0, T1, T2>(arg1, arg2, arg3, arg4);
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0)) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, &v0);
            let v3 = if (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::last_acc_reward_per_xtoken_contains(arg0, v0)) {
                let v4 = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::last_acc_reward_per_xtoken_get_mut(arg0, v0);
                *v4 = *v2;
                *v4
            } else {
                0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::last_acc_reward_per_xtoken_insert(arg0, v0, *v2);
                0
            };
            let v5 = (((*v2 - v3) * (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::x_token_balance(arg0) as u256) / (1000000000 as u256)) as u64) + 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::pending_rewards_extract(arg0, v0);
            let v6 = RewardEvent{
                coin_type : v0,
                amount    : v5,
                sender    : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<RewardEvent>(v6);
            0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.rewards, v0), (v5 as u64))
        } else {
            0x2::balance::zero<T2>()
        }
    }

    public entry fun get_user_rewards_all<T0, T1, T2>(arg0: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt, arg1: &mut Pool<T0, T1>, arg2: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_receipt<T0, T1>(arg0, arg1);
        let v0 = get_user_rewards<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg4), 0x2::tx_context::sender(arg4));
    }

    fun init(arg0: CETUS_SUI_POOL_TWIN_POSITION_CETUS_B, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Magma Yield Liquidity Position"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"MagmaFinance"));
        let v2 = 0x2::package::claim<CETUS_SUI_POOL_TWIN_POSITION_CETUS_B>(arg0, arg1);
        let v3 = 0x2::display::new_with_fields<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&v2, v0, v1, arg1);
        0x2::display::update_version<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun set_deposit_fee<T0, T1>(arg0: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64) {
        assert!(arg2 <= arg1.deposit_fee_max_cap, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::fee_too_high_error());
        arg1.deposit_fee = arg2;
    }

    entry fun set_pause<T0, T1>(arg0: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::EmergencyCap, arg1: &mut Pool<T0, T1>, arg2: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>, arg3: bool) {
        assert!(!0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::is_emergency<T0, T1>(arg2) || !arg1.paused, 1001);
        arg1.paused = arg3;
    }

    entry fun set_withdrawal_fee<T0, T1>(arg0: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::AdminCap, arg1: &mut Pool<T0, T1>, arg2: u64) {
        assert!(arg2 <= arg1.withdraw_fee_max_cap, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::fee_too_high_error());
        arg1.withdrawal_fee = arg2;
    }

    public fun update_pool_underlying_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>, arg2: &0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.underlying_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6), 9223378092758663167);
        assert!(arg0.investor_id == 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>>(arg1), 9223378097053630463);
        let (v0, v1) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::autocompound<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let (v2, v3) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::get_total_liquidity<T0, T1>(arg1);
        arg0.major_position_liquidity = v2;
        arg0.minor_position_liquidity = v3;
        let v4 = UpdatePoolLiqiudityEvent{
            pool_id                : 0x2::object::id<Pool<T0, T1>>(arg0),
            cetus_pool_id          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6),
            coin_a                 : 0x1::type_name::get<T0>(),
            coin_b                 : 0x1::type_name::get<T1>(),
            major_liquidity_before : arg0.major_position_liquidity,
            minor_liquidity_before : arg0.minor_position_liquidity,
            major_liquidity_after  : v2,
            minor_liquidity_after  : v3,
            autocompound_amount_a  : v0,
            autocompound_amount_b  : v1,
        };
        0x2::event::emit<UpdatePoolLiqiudityEvent>(v4);
    }

    fun update_user_rewards<T0, T1, T2>(arg0: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt, arg1: &mut Pool<T0, T1>) {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, v0)) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, &v0);
            let v2 = if (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::last_acc_reward_per_xtoken_contains(arg0, v0)) {
                let v3 = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::last_acc_reward_per_xtoken_get_mut(arg0, v0);
                *v3 = *v1;
                *v3
            } else {
                0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::last_acc_reward_per_xtoken_insert(arg0, v0, *v1);
                0
            };
            if (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::pending_rewards_contains(arg0, v0)) {
                0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::accumulate_pending_rewards(arg0, v0, (((*v1 - v2) * (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::x_token_balance(arg0) as u256) / (1000000000 as u256)) as u64));
            } else {
                0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::pending_rewards_insert(arg0, v0, (((*v1 - v2) * (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::x_token_balance(arg0) as u256) / (1000000000 as u256)) as u64));
            };
        };
    }

    public fun user_deposit<T0, T1>(arg0: 0x1::option::Option<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg5: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        if (0x1::option::is_some<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&v0)) {
            0x2::transfer::public_transfer<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(0x1::option::extract<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&mut v0), 0x2::tx_context::sender(arg11));
        };
        0x1::option::destroy_none<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(v0);
    }

    public entry fun user_withdraw<T0, T1>(arg0: 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt, arg1: &mut Pool<T0, T1>, arg2: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>, arg4: u128, arg5: u128, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        if (0x1::option::is_some<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&v0)) {
            0x2::transfer::public_transfer<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(0x1::option::extract<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&mut v0), 0x2::tx_context::sender(arg11));
        };
        0x1::option::destroy_none<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(v0);
    }

    public fun withdraw<T0, T1>(arg0: 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt, arg1: &mut Pool<T0, T1>, arg2: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::Distributor, arg3: &mut 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>, arg4: u128, arg5: u128, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, T1>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt> {
        assert!(arg1.underlying_pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg9), 9223375352569528319);
        assert!(arg1.investor_id == 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::Investor<T0, T1>>(arg3), 9223375356864495615);
        if (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::owner(&arg0) != 0x2::tx_context::sender(arg11)) {
            let v0 = OnholdReceiptEvent{
                receipt_id : 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0),
                sender     : 0x2::tx_context::sender(arg11),
            };
            0x2::event::emit<OnholdReceiptEvent>(v0);
            0x2::transfer::public_transfer<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(arg0, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::distributor::get_onhold_receipts_wallet_address(arg2));
            return 0x1::option::none<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>()
        };
        assert!(!arg1.paused, 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::pool_paused());
        assert_receipt<T0, T1>(&arg0, arg1);
        assert!(arg4 <= 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::x_token_balance(&arg0), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::insufficient_balance_error());
        assert!(arg5 <= 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::y_token_balance(&arg0), 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::error::insufficient_balance_error());
        update_pool_underlying_liquidity<T0, T1>(arg1, arg3, arg2, arg6, arg7, arg8, arg9, arg10, arg11);
        let (v1, v2) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::get_total_liquidity<T0, T1>(arg3);
        get_rewards<T0, T1, 0x2::sui::SUI>(arg1, arg2, arg10, arg11);
        let v3 = &mut arg0;
        update_user_rewards<T0, T1, 0x2::sui::SUI>(v3, arg1);
        arg1.x_token_supply = arg1.x_token_supply - arg4;
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::sub_x_token_balance(&mut arg0, arg4);
        arg1.y_token_supply = arg1.y_token_supply - arg5;
        0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::sub_y_token_balance(&mut arg0, arg5);
        let (v4, v5) = exchange_rate<T0, T1>(arg1);
        let v6 = (arg4 as u256) * v4 / (1000000000 as u256);
        let v7 = (arg5 as u256) * v5 / (1000000000 as u256);
        let (v8, v9) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::withdraw_major<T0, T1>(arg3, (v6 as u128), arg6, arg9, arg10);
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::withdraw_minor<T0, T1>(arg3, (v7 as u128), arg6, arg9, arg10);
        let (v14, v15) = 0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_sui_investor_twin_position_cetus_b::get_total_liquidity<T0, T1>(arg3);
        arg1.major_position_liquidity = v14;
        arg1.minor_position_liquidity = v15;
        0x2::balance::join<T0>(&mut v11, v12);
        0x2::balance::join<T1>(&mut v10, v13);
        let (v16, v17) = collect_withdraw_fee<T0, T1>(arg1, arg2, v11, v10, arg11);
        let v18 = v17;
        let v19 = v16;
        let v20 = WithdrawEvent{
            receipt_id                  : 0x2::object::id<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(&arg0),
            pool_id                     : 0x2::object::id<Pool<T0, T1>>(arg1),
            coin_type_a                 : 0x1::type_name::get<T0>(),
            coin_type_b                 : 0x1::type_name::get<T1>(),
            major_liquidity_to_withdraw : (v6 as u128),
            minor_liquidity_to_withdraw : (v7 as u128),
            x_token_supply              : arg1.x_token_supply,
            y_token_supply              : arg1.y_token_supply,
            x_amount                    : arg4,
            y_amount                    : arg5,
            amount_a                    : 0x2::balance::value<T0>(&v19),
            amount_b                    : 0x2::balance::value<T1>(&v18),
            sender                      : 0x2::tx_context::sender(arg11),
            major_exchange_rate         : v4,
            minor_exchange_rate         : v5,
            cetus_pool_id               : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg9),
            current_tick                : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg9)),
            current_sqrt_price          : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg9),
            major_liquidity_before      : v1,
            minor_liquidity_before      : v2,
            major_liquidity_after       : v14,
            minor_liquidity_after       : v15,
        };
        0x2::event::emit<WithdrawEvent>(v20);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v19, arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v18, arg11), 0x2::tx_context::sender(arg11));
        if (0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::x_token_balance(&arg0) == 0) {
            destroy_receipt_and_transfer_rewards<T0, T1>(arg0, arg1, arg2, arg10, arg11);
            0x1::option::none<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>()
        } else {
            0x1::option::some<0x8788dc52a1d5f9bdefd18058872822e23bab931942913a61f24194a2ad79d81a::cetus_pool_receipt_twin_position::Receipt>(arg0)
        }
    }

    // decompiled from Move bytecode v6
}

