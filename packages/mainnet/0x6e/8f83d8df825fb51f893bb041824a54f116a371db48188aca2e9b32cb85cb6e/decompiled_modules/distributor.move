module 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::distributor {
    struct RewardPool<phantom T0> has key {
        id: 0x2::object::UID,
        controller: address,
        reward_balance: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<u128, bool>,
        version: u64,
    }

    entry fun claim_rewards<T0>(arg0: &mut RewardPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::get_version(), 2001);
        let v0 = 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::utils::verify_signature(arg1, arg2, arg0.controller, 0x2::object::uid_to_address(&arg0.id), arg3);
        let v1 = 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::utils::payload_receiver(v0);
        let v2 = 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::utils::payload_amount(v0);
        let v3 = 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::utils::payload_nonce(v0);
        assert!(!0x2::table::contains<u128, bool>(&arg0.claimed, v3), 2002);
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= v2, 2003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward_balance, v2, arg4), v1);
        0x2::table::add<u128, bool>(&mut arg0.claimed, v3, true);
        0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::events::emit_rewards_claimed_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg4), v1, v2, v3);
    }

    entry fun create_reward_pool<T0>(arg0: &0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 2000);
        let v0 = 0x2::object::new(arg2);
        let v1 = RewardPool<T0>{
            id             : v0,
            controller     : arg1,
            reward_balance : 0x2::balance::zero<T0>(),
            claimed        : 0x2::table::new<u128, bool>(arg2),
            version        : 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::get_version(),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v1);
        0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::events::emit_reward_pool_created_event(0x2::object::uid_to_inner(&v0), arg1);
    }

    entry fun fund_rewards_pool<T0>(arg0: &mut RewardPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::get_version(), 2001);
        0x2::coin::put<T0>(&mut arg0.reward_balance, arg1);
        0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::events::emit_reward_amount_deposited_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2), 0x2::coin::value<T0>(&arg1), 0x2::balance::value<T0>(&arg0.reward_balance));
    }

    entry fun mark_nonce_as_claimed<T0>(arg0: &mut RewardPool<T0>, arg1: u128, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::get_version(), 2001);
        assert!(arg0.controller == 0x2::tx_context::sender(arg2), 2005);
        assert!(!0x2::table::contains<u128, bool>(&arg0.claimed, arg1), 2002);
        0x2::table::add<u128, bool>(&mut arg0.claimed, arg1, true);
        0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::events::emit_nonce_marked_as_claimed_event(0x2::object::uid_to_inner(&arg0.id), arg1);
    }

    entry fun update_rewards_controller<T0>(arg0: &0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::AdminCap, arg1: &mut RewardPool<T0>, arg2: address) {
        assert!(arg1.version == 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::get_version(), 2001);
        assert!(arg1.controller != arg2, 2004);
        arg1.controller = arg2;
        0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::events::emit_rewards_controller_updated_event(0x2::object::uid_to_inner(&arg1.id), arg1.controller, arg2);
    }

    entry fun update_version_for_reward_pool<T0>(arg0: &0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::AdminCap, arg1: &mut RewardPool<T0>) {
        arg1.version = arg1.version + 1;
    }

    entry fun withdraw_funds<T0>(arg0: &0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::AdminCap, arg1: &mut RewardPool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::config::get_version(), 2001);
        assert!(0x2::balance::value<T0>(&arg1.reward_balance) >= arg2, 2003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.reward_balance, arg2, arg4), arg3);
        0x6e8f83d8df825fb51f893bb041824a54f116a371db48188aca2e9b32cb85cb6e::events::emit_rewards_pool_funds_withdrawn_event(0x2::object::uid_to_inner(&arg1.id), arg2, 0x2::balance::value<T0>(&arg1.reward_balance), arg3);
    }

    // decompiled from Move bytecode v6
}

