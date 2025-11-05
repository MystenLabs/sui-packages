module 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_pool {
    struct Position has store, key {
        id: 0x2::object::UID,
        alphafi_receipt_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        xtokens: u64,
        withdraw_requests: 0x2::vec_map::VecMap<0x2::object::ID, UserWithdrawRequest>,
        all_withdrawals: 0x2::object_table::ObjectTable<0x2::object::ID, UserWithdrawRequest>,
        all_deposits: 0x2::table::Table<u64, u64>,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>,
        pending_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct UserWithdrawRequest has store, key {
        id: 0x2::object::UID,
        time_of_request: u64,
        time_of_acceptance: u64,
        time_of_claim: u64,
        time_of_unlock: u64,
        status: u8,
        token_amount: u64,
    }

    struct PositionUpdate has copy, drop, store {
        xtokens_to_add: u64,
        xtokens_to_remove: u64,
    }

    struct WithdrawRequestData has copy, drop, store {
        total_amount_to_withdraw: u64,
        leftover_amount: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        xTokenSupply: u64,
        tokensInvested: u64,
        positions: 0x2::object_table::ObjectTable<0x2::object::ID, Position>,
        recently_updated_alphafi_receipts: 0x2::vec_map::VecMap<0x2::object::ID, PositionUpdate>,
        withdraw_requests: 0x2::vec_map::VecMap<u64, WithdrawRequestData>,
        fee_collected: 0x2::balance::Balance<T0>,
        last_distribution_time: u64,
        last_autocompound_time: u64,
        locking_period: u64,
        time_from_locking_period_for_unstaking_to_start: u64,
        current_exchange_rate: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        fee_address: address,
        is_deposit_paused: bool,
        is_withdraw_paused: bool,
        investor: 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::Investor<T0>,
        alphafi_partner_cap: 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::PartnerCap,
        additional_fields: 0x2::bag::Bag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ALPHAFI_EMBER_POOL has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct SettleRequestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        processed_alphafi_receipts_data: 0x2::vec_map::VecMap<0x2::object::ID, PositionUpdate>,
        xtoken_supply: u64,
        total_invested_primary: u64,
        total_debt: u64,
        cur_actual_debt: u64,
        cur_total_etokens: u64,
    }

    struct AirdropAddEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct UserRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    struct DepositEvent has copy, drop {
        alphafi_receipt_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        fee_collected: u64,
        amount: u64,
        current_total_xtoken_balance_in_position: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        total_invested_primary: u64,
        sender: address,
    }

    struct InitiateWithdrawEvent has copy, drop {
        alphafi_receipt_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        fee_collected: u64,
        xtokens_requested: u64,
        token_amount_requested: u64,
        current_total_xtoken_balance_in_position: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        total_invested_primary: u64,
    }

    struct ClaimWithdrawEvent has copy, drop {
        alphafi_receipt_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        fee_collected: u64,
        amount: u64,
        withdraw_ticket_id: 0x2::object::ID,
        current_total_xtoken_balance_in_position: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        total_invested_primary: u64,
    }

    public fun add_or_remove_coin_type_for_swap<T0>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: 0x1::type_name::TypeName, arg4: u8) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::add_or_remove_coin_type_for_swap<T0>(&mut arg2.investor, arg3, arg4);
    }

    public fun admin_change_leverage<T0, T1, T2>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg6: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::admin_change_leverage<T0, T1, T2>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: bool, arg6: bool, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg0);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::collect_reward_and_swap_bluefin<T0, T1, T2>(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun repay<T0, T1, T2>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: u128, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        if (arg8) {
            0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::repay<T0, T1, T2>(&mut arg2.investor, arg3, arg4, arg5, arg6, 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_withdraw_request_type(), arg7, arg9, arg10);
        } else {
            0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::repay<T0, T1, T2>(&mut arg2.investor, arg3, arg4, arg5, arg6, 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_autocompound_request_type(), arg7, arg9, arg10);
        };
    }

    public fun request_etoken_withdrawal_from_free_rewards<T0, T1, T2>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg4: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::request_etoken_withdrawal_from_free_rewards<T0, T1, T2>(&mut arg2.investor, arg3, arg4, arg5, arg6);
    }

    entry fun set_minimum_swap_amount<T0>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::set_minimum_swap_amount<T0>(&mut arg2.investor, arg3);
    }

    public fun swap_etoken_to_token<T0, T1, T2>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::swap_etoken_to_token<T0, T1, T2>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    fun add_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
            let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.acc_rewards_per_xtoken, &v0);
            *v1 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(*v1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T1>(&arg1)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.xTokenSupply)));
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.acc_rewards_per_xtoken, v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T1>(&arg1)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.xTokenSupply)));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, arg1);
        };
    }

    public fun admin_repay_for_withdrawal<T0, T1, T2>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        assert!(0x2::vec_map::length<u64, WithdrawRequestData>(&arg2.withdraw_requests) > 0, 1005);
        let (_, v1) = 0x2::vec_map::get_entry_by_idx_mut<u64, WithdrawRequestData>(&mut arg2.withdraw_requests, 0);
        let v2 = 0x1::u64::min(v1.leftover_amount, 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::repay_coin_for_withdrawal_and_get_withdrawable_amount<T0, T1, T2>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg8, arg9));
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::withdraw_from_alphalend_and_add_to_claimable<T0>(&mut arg2.investor, arg3, v2, arg7, arg8, arg9);
        v1.leftover_amount = v1.leftover_amount - v2;
        if (v1.leftover_amount == 0) {
            assert!(0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_claimable<T0>(&arg2.investor) >= v1.total_amount_to_withdraw, 1004);
            let (_, _) = 0x2::vec_map::remove_entry_by_idx<u64, WithdrawRequestData>(&mut arg2.withdraw_requests, 0);
        };
    }

    entry fun change_fee_address<T0>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: address) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        arg2.fee_address = arg3;
    }

    entry fun change_locking_period<T0>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        arg2.locking_period = arg3;
    }

    entry fun collect_fee<T0>(arg0: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.fee_collected), arg2), arg1.fee_address);
    }

    public fun convert_alpha_receipt_to_ember_position<T0>(arg0: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg3: 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg0);
        let v0 = Witness{dummy_field: false};
        let v1 = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::destroy_alpha_receipt<T0, Witness>(arg3, arg4, v0, arg5);
        create_position<T0>(arg2, arg1, arg5);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg1.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg2));
        v2.xtokens = v2.xtokens + v1;
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>, arg8: address, arg9: address, arg10: u64, arg11: 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::PartnerCap, arg12: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        let v0 = Pool<T0>{
            id                                              : 0x2::object::new(arg12),
            xTokenSupply                                    : 0,
            tokensInvested                                  : 0,
            positions                                       : 0x2::object_table::new<0x2::object::ID, Position>(arg12),
            recently_updated_alphafi_receipts               : 0x2::vec_map::empty<0x2::object::ID, PositionUpdate>(),
            withdraw_requests                               : 0x2::vec_map::empty<u64, WithdrawRequestData>(),
            fee_collected                                   : 0x2::balance::zero<T0>(),
            last_distribution_time                          : 0,
            last_autocompound_time                          : 0,
            locking_period                                  : arg10,
            time_from_locking_period_for_unstaking_to_start : arg10,
            current_exchange_rate                           : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1),
            rewards                                         : 0x2::bag::new(arg12),
            acc_rewards_per_xtoken                          : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(),
            deposit_fee                                     : 0,
            deposit_fee_max_cap                             : 100,
            withdrawal_fee                                  : 0,
            withdraw_fee_max_cap                            : 100,
            fee_address                                     : arg8,
            is_deposit_paused                               : true,
            is_withdraw_paused                              : false,
            investor                                        : 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::create_investor<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg12),
            alphafi_partner_cap                             : arg11,
            additional_fields                               : 0x2::bag::new(arg12),
        };
        0x2::transfer::public_share_object<Pool<T0>>(v0);
    }

    fun create_position<T0>(arg0: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::object_table::contains<0x2::object::ID, Position>(&arg1.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg0)), 1001);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::id<Pool<T0>>(arg1);
        0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::add_position(arg0, 0x2::object::uid_to_inner(&v0), v1, &arg1.alphafi_partner_cap);
        let v2 = Position{
            id                         : v0,
            alphafi_receipt_id         : 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg0),
            pool_id                    : v1,
            coin_type                  : 0x1::type_name::with_defining_ids<T0>(),
            xtokens                    : 0,
            withdraw_requests          : 0x2::vec_map::empty<0x2::object::ID, UserWithdrawRequest>(),
            all_withdrawals            : 0x2::object_table::new<0x2::object::ID, UserWithdrawRequest>(arg2),
            all_deposits               : 0x2::table::new<u64, u64>(arg2),
            last_acc_reward_per_xtoken : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(),
            pending_rewards            : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0x2::object_table::add<0x2::object::ID, Position>(&mut arg1.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg0), v2);
    }

    public fun distribute_airdrop<T0, T1>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: &0x2::clock::Clock) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        let v0 = 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::initialize_airdrop<T0, T1>(&mut arg2.investor);
        let v1 = AirdropAddEvent{
            pool_id   : 0x2::object::id<Pool<T0>>(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T1>(),
            amount    : 0x2::balance::value<T1>(&v0),
        };
        0x2::event::emit<AirdropAddEvent>(v1);
        add_rewards<T0, T1>(arg2, v0);
        arg2.last_distribution_time = 0x2::clock::timestamp_ms(arg3);
    }

    fun exchange_rate<T0>(arg0: &Pool<T0>) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.xTokenSupply))
        }
    }

    fun generate_withdraw_request<T0>(arg0: &mut Pool<T0>, arg1: &0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = UserWithdrawRequest{
            id                 : v0,
            time_of_request    : 0x2::clock::timestamp_ms(arg3),
            time_of_acceptance : 0,
            time_of_claim      : 0,
            time_of_unlock     : 0,
            status             : 0,
            token_amount       : arg2,
        };
        0x2::vec_map::insert<0x2::object::ID, UserWithdrawRequest>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).withdraw_requests, 0x2::object::uid_to_inner(&v0), v1);
    }

    public fun get_user_rewards<T0, T1>(arg0: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg1: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut Pool<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg0);
        assert!(0x2::object_table::contains<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)), 1013);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        update_pending_rewards<T0>(0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1), arg2, v0);
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).pending_rewards, &v0);
        let v2 = *v1;
        *v1 = 0;
        let v3 = UserRewardEvent{
            pool_id   : 0x2::object::id<Pool<T0>>(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T1>(),
            amount    : v2,
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UserRewardEvent>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg2.rewards, v0), (v2 as u64)), arg3)
    }

    fun init(arg0: ALPHAFI_EMBER_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg3: &mut Pool<T0>, arg4: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<T0>, arg5: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg6: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::remove_alpha<T0, Witness>(arg0, arg2, arg4, arg5, v0, arg7, arg8);
        let v3 = v1;
        arg3.xTokenSupply = v2;
        arg3.tokensInvested = 0x2::balance::value<T0>(&v3);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::deposit<T0>(&mut arg3.investor, 0x2::coin::from_balance<T0>(v3, arg8));
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::add_unsupplied_balance_to_lending<T0>(&mut arg3.investor, arg6, arg7, arg8);
        arg3.current_exchange_rate = exchange_rate<T0>(arg3);
        arg3.is_deposit_paused = false;
    }

    fun internal_deposit<T0>(arg0: &mut Pool<T0>, arg1: &0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<T0>(&arg3) as u128) * (arg0.deposit_fee as u128) / 10000;
        0x2::balance::join<T0>(&mut arg0.fee_collected, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, (v0 as u64), arg5)));
        let v1 = 0x2::coin::value<T0>(&arg3);
        update_all_deposits<T0>(arg0, arg1, v1, arg4);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::deposit<T0>(&mut arg0.investor, arg3);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), arg0.current_exchange_rate));
        assert!(v2 > 0, 1012);
        update_recently_updated_alphafi_receipts<T0>(arg0, arg1, v2, true);
        let v3 = DepositEvent{
            alphafi_receipt_id                       : 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg0.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1))),
            fee_collected                            : (v0 as u64),
            amount                                   : v1,
            current_total_xtoken_balance_in_position : 0x2::object_table::borrow<0x2::object::ID, Position>(&arg0.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).xtokens,
            x_token_supply                           : arg0.xTokenSupply,
            tokens_invested                          : arg0.tokensInvested,
            total_invested_primary                   : 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_invested<T0>(&arg0.investor, arg2, arg4),
            sender                                   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun process_withdraw_requests<T0, T1, T2>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg5: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        if (0x2::vec_map::length<u64, WithdrawRequestData>(&arg2.withdraw_requests) == 0) {
            return
        };
        let (_, v1) = 0x2::vec_map::get_entry_by_idx_mut<u64, WithdrawRequestData>(&mut arg2.withdraw_requests, 0);
        let v2 = 0x1::u64::min(0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::total_alpha_safe_to_remove<T0, T1, T2>(&arg2.investor, arg3, arg4, arg6), v1.leftover_amount);
        let v3 = 0x1::u64::min(0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_unsupplied<T0>(&arg2.investor), v2);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::shift_unsupplied_to_claimable<T0>(&mut arg2.investor, v3);
        let v4 = v2 - v3;
        if (v4 == 0) {
            assert!(0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_claimable<T0>(&arg2.investor) >= v1.total_amount_to_withdraw, 1004);
            let (_, _) = 0x2::vec_map::remove_entry_by_idx<u64, WithdrawRequestData>(&mut arg2.withdraw_requests, 0);
        } else {
            0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::request_withdrawal_from_supply_coin<T0, T1, T2>(&mut arg2.investor, arg3, arg4, arg5, v4, arg6, arg7);
        };
    }

    entry fun set_deposit_fee<T0>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 1002);
        arg2.deposit_fee = arg3;
    }

    entry fun set_pause<T0>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: bool, arg4: bool) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        if (arg3) {
            assert!(arg2.is_withdraw_paused != arg4, 1001);
            arg2.is_withdraw_paused = arg4;
            if (arg4) {
                arg2.is_deposit_paused = arg4;
            };
        } else {
            assert!(arg2.is_deposit_paused != arg4, 1001);
            assert!(arg2.is_withdraw_paused == false, 1002);
            arg2.is_deposit_paused = arg4;
        };
    }

    entry fun set_withdrawal_fee<T0>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 1002);
        arg2.withdrawal_fee = arg3;
    }

    public fun settle_requests<T0, T1, T2>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        let v0 = arg2.current_exchange_rate;
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0;
        let v3 = arg2.recently_updated_alphafi_receipts;
        while (0x2::vec_map::length<0x2::object::ID, PositionUpdate>(&arg2.recently_updated_alphafi_receipts) > 0) {
            let (v4, v5) = 0x2::vec_map::pop<0x2::object::ID, PositionUpdate>(&mut arg2.recently_updated_alphafi_receipts);
            let v6 = v5;
            update_all_pending_rewards<T0>(v4, arg2);
            let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg2.positions, v4);
            v7.xtokens = v7.xtokens + v6.xtokens_to_add;
            v7.xtokens = v7.xtokens - v6.xtokens_to_remove;
            let v8 = 0;
            while (v8 < 0x2::vec_map::length<0x2::object::ID, UserWithdrawRequest>(&v7.withdraw_requests)) {
                let (_, v10) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, UserWithdrawRequest>(&mut v7.withdraw_requests, v8);
                if (v10.status == 0) {
                    v10.status = 1;
                    v10.time_of_acceptance = v1;
                    v10.time_of_unlock = v1 + arg2.locking_period;
                };
                v8 = v8 + 1;
            };
            arg2.xTokenSupply = arg2.xTokenSupply + v6.xtokens_to_add;
            v2 = v2 + v6.xtokens_to_remove;
        };
        update_pool_withdraw_requests<T0>(arg2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2), v0)), v1);
        arg2.xTokenSupply = arg2.xTokenSupply - v2;
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::add_unsupplied_balance_to_lending<T0>(&mut arg2.investor, arg3, arg5, arg6);
        arg2.tokensInvested = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg2.xTokenSupply), arg2.current_exchange_rate));
        let v11 = SettleRequestEvent{
            pool_id                         : 0x2::object::id<Pool<T0>>(arg2),
            processed_alphafi_receipts_data : v3,
            xtoken_supply                   : arg2.xTokenSupply,
            total_invested_primary          : 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_invested<T0>(&arg2.investor, arg3, arg5),
            total_debt                      : 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_debt<T0, T1, T2>(&arg2.investor, arg3, arg4, arg5),
            cur_actual_debt                 : 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_borrow_amount<T0>(&arg2.investor, arg3, arg5),
            cur_total_etokens               : 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_resupplied<T0>(&arg2.investor, arg3, arg5),
        };
        0x2::event::emit<SettleRequestEvent>(v11);
    }

    fun update_all_deposits<T0>(arg0: &mut Pool<T0>, arg1: &0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: u64, arg3: &0x2::clock::Clock) {
        0x2::table::add<u64, u64>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).all_deposits, 0x2::clock::timestamp_ms(arg3), arg2);
    }

    fun update_all_pending_rewards<T0>(arg0: 0x2::object::ID, arg1: &mut Pool<T0>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&arg1.acc_rewards_per_xtoken)) {
            let (v1, _) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&arg1.acc_rewards_per_xtoken, v0);
            update_pending_rewards<T0>(arg0, arg1, *v1);
            v0 = v0 + 1;
        };
    }

    fun update_all_withdrawals_and_get_amount<T0>(arg0: &mut Pool<T0>, arg1: &0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1));
        assert!(0x2::vec_map::contains<0x2::object::ID, UserWithdrawRequest>(&v0.withdraw_requests, &arg2), 1003);
        let (_, v2) = 0x2::vec_map::remove<0x2::object::ID, UserWithdrawRequest>(&mut v0.withdraw_requests, &arg2);
        let v3 = v2;
        assert!(0x2::clock::timestamp_ms(arg3) >= v3.time_of_unlock, 1006);
        v3.status = 2;
        v3.time_of_claim = 0x2::clock::timestamp_ms(arg3);
        0x2::object_table::add<0x2::object::ID, UserWithdrawRequest>(&mut v0.all_withdrawals, 0x2::object::id<UserWithdrawRequest>(&v3), v3);
        v3.token_amount
    }

    fun update_pending_rewards<T0>(arg0: 0x2::object::ID, arg1: &mut Pool<T0>, arg2: 0x1::type_name::TypeName) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg1.positions, arg0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.rewards, arg2) == true) {
            let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&arg1.acc_rewards_per_xtoken, &arg2);
            let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&v0.last_acc_reward_per_xtoken, &arg2) == true) {
                let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut v0.last_acc_reward_per_xtoken, &arg2);
                *v3 = *v1;
                *v3
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut v0.last_acc_reward_per_xtoken, arg2, *v1);
                0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
            };
            if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.pending_rewards, &arg2) == true) {
                let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v0.pending_rewards, &arg2);
                *v4 = *v4 + 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(*v1, v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0.xtokens)));
            } else {
                0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0.pending_rewards, arg2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(*v1, v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v0.xtokens))));
            };
        };
    }

    public fun update_pool<T0, T1, T2>(arg0: &AdminCap, arg1: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg5: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg1);
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::autocompound<T0, T1, T2>(&mut arg2.investor, arg3, arg4, arg5, arg6, arg7, arg8);
        arg2.last_autocompound_time = 0x2::clock::timestamp_ms(arg7);
    }

    fun update_pool_withdraw_requests<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64) {
        if (arg1 == 0) {
            return
        };
        if (!0x2::vec_map::contains<u64, WithdrawRequestData>(&arg0.withdraw_requests, &arg2)) {
            let v0 = WithdrawRequestData{
                total_amount_to_withdraw : 0,
                leftover_amount          : 0,
            };
            0x2::vec_map::insert<u64, WithdrawRequestData>(&mut arg0.withdraw_requests, arg2, v0);
        };
        let v1 = 0x2::vec_map::get_mut<u64, WithdrawRequestData>(&mut arg0.withdraw_requests, &arg2);
        v1.total_amount_to_withdraw = v1.total_amount_to_withdraw + arg1;
        v1.leftover_amount = v1.total_amount_to_withdraw;
    }

    fun update_recently_updated_alphafi_receipts<T0>(arg0: &mut Pool<T0>, arg1: &0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: u64, arg3: bool) {
        let v0 = 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1);
        if (!0x2::vec_map::contains<0x2::object::ID, PositionUpdate>(&arg0.recently_updated_alphafi_receipts, &v0)) {
            let v1 = PositionUpdate{
                xtokens_to_add    : 0,
                xtokens_to_remove : 0,
            };
            0x2::vec_map::insert<0x2::object::ID, PositionUpdate>(&mut arg0.recently_updated_alphafi_receipts, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1), v1);
        };
        let v2 = 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1);
        let v3 = 0x2::vec_map::get_mut<0x2::object::ID, PositionUpdate>(&mut arg0.recently_updated_alphafi_receipts, &v2);
        if (arg3) {
            v3.xtokens_to_add = v3.xtokens_to_add + arg2;
        } else {
            v3.xtokens_to_remove = v3.xtokens_to_remove + arg2;
        };
    }

    public fun user_claim_withdraw<T0>(arg0: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg1: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut Pool<T0>, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg0);
        assert!(arg3.is_withdraw_paused == false, 1011);
        assert!(0x2::object_table::contains<0x2::object::ID, Position>(&arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)), 1013);
        assert!(0x2::vec_map::contains<0x2::object::ID, UserWithdrawRequest>(&0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).withdraw_requests, &arg4), 13906837296784605183);
        let v0 = update_all_withdrawals_and_get_amount<T0>(arg3, arg1, arg4, arg5);
        let v1 = ClaimWithdrawEvent{
            alphafi_receipt_id                       : 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg3.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1))),
            fee_collected                            : 0,
            amount                                   : v0,
            withdraw_ticket_id                       : arg4,
            current_total_xtoken_balance_in_position : 0x2::object_table::borrow<0x2::object::ID, Position>(&arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).xtokens,
            x_token_supply                           : arg3.xTokenSupply,
            tokens_invested                          : arg3.tokensInvested,
            total_invested_primary                   : 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_invested<T0>(&arg3.investor, arg2, arg5),
        };
        0x2::event::emit<ClaimWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::withdraw<T0>(&mut arg3.investor, v0), arg6)
    }

    public fun user_deposit<T0>(arg0: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg1: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut Pool<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg0);
        assert!(arg3.is_deposit_paused == false, 1011);
        if (!0x2::object_table::contains<0x2::object::ID, Position>(&arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1))) {
            create_position<T0>(arg1, arg3, arg6);
        };
        assert!(0x2::coin::value<T0>(&arg4) > 0, 1012);
        internal_deposit<T0>(arg3, arg1, arg2, arg4, arg5, arg6);
    }

    public fun user_initiate_withdraw<T0>(arg0: &0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::Version, arg1: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut Pool<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::version::assert_current_version(arg0);
        assert!(arg3.is_withdraw_paused == false, 1011);
        assert!(0x2::object_table::contains<0x2::object::ID, Position>(&arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)), 1013);
        assert!(0x2::object_table::borrow<0x2::object::ID, Position>(&arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).xtokens >= arg4, 1014);
        assert!(arg4 > 0, 1015);
        let v0 = arg3.current_exchange_rate;
        generate_withdraw_request<T0>(arg3, arg1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg4), v0)), arg5, arg6);
        update_recently_updated_alphafi_receipts<T0>(arg3, arg1, arg4, false);
        let v1 = InitiateWithdrawEvent{
            alphafi_receipt_id                       : 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg3.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1))),
            fee_collected                            : 0,
            xtokens_requested                        : arg4,
            token_amount_requested                   : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg4), v0)),
            current_total_xtoken_balance_in_position : 0x2::object_table::borrow<0x2::object::ID, Position>(&arg3.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).xtokens,
            x_token_supply                           : arg3.xTokenSupply,
            tokens_invested                          : arg3.tokensInvested,
            total_invested_primary                   : 0x4e213257b00c82ca3657909d331947cf925867efe47fb67b3760f86bf79df35d::alphafi_ember_investor::get_total_invested<T0>(&arg3.investor, arg2, arg5),
        };
        0x2::event::emit<InitiateWithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

