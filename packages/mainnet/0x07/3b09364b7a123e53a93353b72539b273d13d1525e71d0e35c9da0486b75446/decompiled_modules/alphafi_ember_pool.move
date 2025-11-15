module 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool {
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
        unsupplied_balance: 0x2::balance::Balance<T0>,
        claimable_balance: 0x2::balance::Balance<T0>,
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
        alphafi_partner_cap: 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::PartnerCap,
        active_investor_id: 0x2::object::ID,
        additional_fields: 0x2::bag::Bag,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct SettleRequestEvent has copy, drop {
        pool_id: 0x2::object::ID,
        processed_alphafi_receipts_data: 0x2::vec_map::VecMap<0x2::object::ID, PositionUpdate>,
        xtoken_supply: u64,
        total_invested: u64,
    }

    struct AirdropAddEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        xtoken_supply: u64,
        tokens_invested: u64,
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
    }

    public(friend) fun add_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = AirdropAddEvent{
            pool_id         : 0x2::object::id<Pool<T0>>(arg0),
            coin_type       : v0,
            amount          : 0x2::balance::value<T1>(&arg1),
            xtoken_supply   : arg0.xTokenSupply,
            tokens_invested : arg0.tokensInvested,
        };
        0x2::event::emit<AirdropAddEvent>(v1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards, v0) == true) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.acc_rewards_per_xtoken, &v0);
            *v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(*v2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T1>(&arg1)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.xTokenSupply)));
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(&mut arg0.acc_rewards_per_xtoken, v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T1>(&arg1)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.xTokenSupply)));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v0, arg1);
        };
        arg0.last_distribution_time = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun add_to_claimable<T0>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.claimable_balance, arg1);
    }

    public(friend) fun admin_repay_for_withdrawal<T0>(arg0: &mut Pool<T0>, arg1: u64) : u64 {
        assert!(0x2::vec_map::length<u64, WithdrawRequestData>(&arg0.withdraw_requests) > 0, 1005);
        let (_, v1) = 0x2::vec_map::get_entry_by_idx_mut<u64, WithdrawRequestData>(&mut arg0.withdraw_requests, 0);
        let v2 = 0x1::u64::min(v1.leftover_amount, arg1);
        v1.leftover_amount = v1.leftover_amount - v2;
        if (v1.leftover_amount == 0) {
            assert!(0x2::balance::value<T0>(&arg0.claimable_balance) >= v1.total_amount_to_withdraw, 1004);
            let (_, _) = 0x2::vec_map::remove_entry_by_idx<u64, WithdrawRequestData>(&mut arg0.withdraw_requests, 0);
        };
        v2
    }

    public(friend) fun change_fee_address<T0>(arg0: &mut Pool<T0>, arg1: address) {
        arg0.fee_address = arg1;
    }

    public(friend) fun change_locking_period<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        arg0.locking_period = arg1;
    }

    public(friend) fun collect_fee<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.fee_collected), arg1), arg0.fee_address);
    }

    public(friend) fun create_pool<T0>(arg0: address, arg1: u64, arg2: 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::PartnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id                                              : 0x2::object::new(arg4),
            xTokenSupply                                    : 0,
            tokensInvested                                  : 0,
            unsupplied_balance                              : 0x2::balance::zero<T0>(),
            claimable_balance                               : 0x2::balance::zero<T0>(),
            positions                                       : 0x2::object_table::new<0x2::object::ID, Position>(arg4),
            recently_updated_alphafi_receipts               : 0x2::vec_map::empty<0x2::object::ID, PositionUpdate>(),
            withdraw_requests                               : 0x2::vec_map::empty<u64, WithdrawRequestData>(),
            fee_collected                                   : 0x2::balance::zero<T0>(),
            last_distribution_time                          : 0,
            last_autocompound_time                          : 0,
            locking_period                                  : arg1,
            time_from_locking_period_for_unstaking_to_start : arg1,
            current_exchange_rate                           : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1),
            rewards                                         : 0x2::bag::new(arg4),
            acc_rewards_per_xtoken                          : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number>(),
            deposit_fee                                     : 0,
            deposit_fee_max_cap                             : 100,
            withdrawal_fee                                  : 0,
            withdraw_fee_max_cap                            : 100,
            fee_address                                     : arg0,
            is_deposit_paused                               : true,
            is_withdraw_paused                              : false,
            alphafi_partner_cap                             : arg2,
            active_investor_id                              : arg3,
            additional_fields                               : 0x2::bag::new(arg4),
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

    public(friend) fun get_investor_id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        arg0.active_investor_id
    }

    public fun get_user_rewards<T0, T1>(arg0: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg1: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut Pool<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg0);
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

    public(friend) fun initialize<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<T0>, arg4: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::remove_alpha<T0, Witness>(arg0, arg1, arg3, arg4, v0, arg5, arg6);
        let v3 = v1;
        arg2.xTokenSupply = v2;
        arg2.tokensInvested = 0x2::balance::value<T0>(&v3);
        arg2.current_exchange_rate = exchange_rate<T0>(arg2);
        arg2.is_deposit_paused = false;
        v3
    }

    fun internal_deposit<T0>(arg0: &mut Pool<T0>, arg1: &0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<T0>(&arg2) as u128) * (arg0.deposit_fee as u128) / 10000;
        0x2::balance::join<T0>(&mut arg0.fee_collected, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, (v0 as u64), arg4)));
        let v1 = 0x2::coin::value<T0>(&arg2);
        update_all_deposits<T0>(arg0, arg1, v1, arg3);
        0x2::balance::join<T0>(&mut arg0.unsupplied_balance, 0x2::coin::into_balance<T0>(arg2));
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
            sender                                   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun migrate_alpha_receipt_to_new_alpha_strategy<T0>(arg0: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg3: 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Receipt, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg0);
        let v0 = Witness{dummy_field: false};
        let v1 = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::destroy_alpha_receipt<T0, Witness>(arg3, arg4, v0, arg5);
        create_position<T0>(arg2, arg1, arg5);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg1.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg2));
        v2.xtokens = v2.xtokens + v1;
    }

    public(friend) fun process_withdraw_requests<T0>(arg0: &mut Pool<T0>, arg1: u64) : u64 {
        if (0x2::vec_map::length<u64, WithdrawRequestData>(&arg0.withdraw_requests) == 0) {
            return 0
        };
        let (_, v1) = 0x2::vec_map::get_entry_by_idx<u64, WithdrawRequestData>(&arg0.withdraw_requests, 0);
        let v2 = *v1;
        let v3 = 0x1::u64::min(arg1, v2.leftover_amount);
        let v4 = 0x1::u64::min(0x2::balance::value<T0>(&arg0.unsupplied_balance), v3);
        shift_unsupplied_to_claimable<T0>(arg0, v4);
        let v5 = v3 - v4;
        if (v5 == 0) {
            assert!(0x2::balance::value<T0>(&arg0.claimable_balance) >= v2.total_amount_to_withdraw, 1004);
            let (_, _) = 0x2::vec_map::remove_entry_by_idx<u64, WithdrawRequestData>(&mut arg0.withdraw_requests, 0);
        };
        v5
    }

    public(friend) fun set_deposit_fee<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(arg1 <= arg0.deposit_fee_max_cap, 1002);
        arg0.deposit_fee = arg1;
    }

    public(friend) fun set_investor_id<T0>(arg0: &mut Pool<T0>, arg1: 0x2::object::ID) {
        arg0.active_investor_id = arg1;
    }

    public(friend) fun set_pause<T0>(arg0: &mut Pool<T0>, arg1: bool, arg2: bool) {
        if (arg1) {
            assert!(arg0.is_withdraw_paused != arg2, 1001);
            arg0.is_withdraw_paused = arg2;
            if (arg2) {
                arg0.is_deposit_paused = arg2;
            };
        } else {
            assert!(arg0.is_deposit_paused != arg2, 1001);
            assert!(arg0.is_withdraw_paused == false, 1002);
            arg0.is_deposit_paused = arg2;
        };
    }

    public(friend) fun set_withdrawal_fee<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(arg1 <= arg0.withdraw_fee_max_cap, 1002);
        arg0.withdrawal_fee = arg1;
    }

    public(friend) fun settle_requests<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = arg0.current_exchange_rate;
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0;
        let v3 = arg0.recently_updated_alphafi_receipts;
        while (0x2::vec_map::length<0x2::object::ID, PositionUpdate>(&arg0.recently_updated_alphafi_receipts) > 0) {
            let (v4, v5) = 0x2::vec_map::pop<0x2::object::ID, PositionUpdate>(&mut arg0.recently_updated_alphafi_receipts);
            let v6 = v5;
            update_all_pending_rewards<T0>(v4, arg0);
            let v7 = 0x2::object_table::borrow_mut<0x2::object::ID, Position>(&mut arg0.positions, v4);
            v7.xtokens = v7.xtokens + v6.xtokens_to_add;
            v7.xtokens = v7.xtokens - v6.xtokens_to_remove;
            let v8 = 0;
            while (v8 < 0x2::vec_map::length<0x2::object::ID, UserWithdrawRequest>(&v7.withdraw_requests)) {
                let (_, v10) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, UserWithdrawRequest>(&mut v7.withdraw_requests, v8);
                if (v10.status == 0) {
                    v10.status = 1;
                    v10.time_of_acceptance = v1;
                    v10.time_of_unlock = v1 + arg0.locking_period;
                };
                v8 = v8 + 1;
            };
            arg0.xTokenSupply = arg0.xTokenSupply + v6.xtokens_to_add;
            v2 = v2 + v6.xtokens_to_remove;
        };
        update_pool_withdraw_requests<T0>(arg0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2), v0)), v1);
        arg0.xTokenSupply = arg0.xTokenSupply - v2;
        arg0.tokensInvested = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.xTokenSupply), arg0.current_exchange_rate));
        let v11 = SettleRequestEvent{
            pool_id                         : 0x2::object::id<Pool<T0>>(arg0),
            processed_alphafi_receipts_data : v3,
            xtoken_supply                   : arg0.xTokenSupply,
            total_invested                  : arg0.tokensInvested,
        };
        0x2::event::emit<SettleRequestEvent>(v11);
        0x2::balance::withdraw_all<T0>(&mut arg0.unsupplied_balance)
    }

    public(friend) fun shift_unsupplied_to_claimable<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.unsupplied_balance), 3005);
        0x2::balance::join<T0>(&mut arg0.claimable_balance, 0x2::balance::split<T0>(&mut arg0.unsupplied_balance, arg1));
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
        assert!(v3.status == 1, 3006);
        assert!(0x2::clock::timestamp_ms(arg3) >= v3.time_of_unlock, 1006);
        v3.status = 2;
        v3.time_of_claim = 0x2::clock::timestamp_ms(arg3);
        0x2::object_table::add<0x2::object::ID, UserWithdrawRequest>(&mut v0.all_withdrawals, 0x2::object::id<UserWithdrawRequest>(&v3), v3);
        v3.token_amount
    }

    public(friend) fun update_last_autocompound_time<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) {
        arg0.last_autocompound_time = 0x2::clock::timestamp_ms(arg1);
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

    public fun user_claim_withdraw<T0>(arg0: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg1: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut Pool<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg0);
        assert!(arg2.is_withdraw_paused == false, 1011);
        assert!(0x2::object_table::contains<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)), 1013);
        let v0 = update_all_withdrawals_and_get_amount<T0>(arg2, arg1, arg3, arg4);
        let v1 = ClaimWithdrawEvent{
            alphafi_receipt_id                       : 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg2.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1))),
            fee_collected                            : 0,
            amount                                   : v0,
            withdraw_ticket_id                       : arg3,
            current_total_xtoken_balance_in_position : 0x2::object_table::borrow<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).xtokens,
            x_token_supply                           : arg2.xTokenSupply,
            tokens_invested                          : arg2.tokensInvested,
        };
        0x2::event::emit<ClaimWithdrawEvent>(v1);
        assert!(v0 <= 0x2::balance::value<T0>(&arg2.claimable_balance), 1004);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.claimable_balance, v0), arg5)
    }

    public fun user_deposit<T0>(arg0: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg1: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg0);
        assert!(arg2.is_deposit_paused == false, 1011);
        if (!0x2::object_table::contains<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1))) {
            create_position<T0>(arg1, arg2, arg5);
        };
        assert!(0x2::coin::value<T0>(&arg3) > 0, 1012);
        internal_deposit<T0>(arg2, arg1, arg3, arg4, arg5);
    }

    public fun user_initiate_withdraw<T0>(arg0: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg1: &mut 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt, arg2: &mut Pool<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg0);
        assert!(arg2.is_withdraw_paused == false, 1011);
        assert!(0x2::object_table::contains<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)), 1013);
        let v0 = 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1);
        let v1 = *0x2::vec_map::get<0x2::object::ID, PositionUpdate>(&arg2.recently_updated_alphafi_receipts, &v0);
        assert!(0x2::object_table::borrow<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).xtokens >= arg3 + v1.xtokens_to_remove, 1014);
        assert!(arg3 > 0, 1015);
        let v2 = arg2.current_exchange_rate;
        generate_withdraw_request<T0>(arg2, arg1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3), v2)), arg4, arg5);
        update_recently_updated_alphafi_receipts<T0>(arg2, arg1, arg3, false);
        let v3 = InitiateWithdrawEvent{
            alphafi_receipt_id                       : 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg2.id),
            position_id                              : 0x2::object::id<Position>(0x2::object_table::borrow<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1))),
            fee_collected                            : 0,
            xtokens_requested                        : arg3,
            token_amount_requested                   : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3), v2)),
            current_total_xtoken_balance_in_position : 0x2::object_table::borrow<0x2::object::ID, Position>(&arg2.positions, 0x2::object::id<0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::AlphaFiReceipt>(arg1)).xtokens,
            x_token_supply                           : arg2.xTokenSupply,
            tokens_invested                          : arg2.tokensInvested,
        };
        0x2::event::emit<InitiateWithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

