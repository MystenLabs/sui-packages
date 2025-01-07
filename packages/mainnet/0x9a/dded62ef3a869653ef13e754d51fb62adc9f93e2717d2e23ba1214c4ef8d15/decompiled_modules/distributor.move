module 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::distributor {
    struct RewardPool<phantom T0> has key {
        id: 0x2::object::UID,
        controller: address,
        reward_balance: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<u128, bool>,
        version: u64,
    }

    entry fun claim_rewards<T0>(arg0: &mut RewardPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        let v0 = 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::verify_signature(arg1, arg2, arg0.controller, 0x2::object::uid_to_address(&arg0.id), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::claim_rewards_payload_type());
        let v1 = 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::payload_receiver(v0);
        let v2 = 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::payload_amount(v0);
        let v3 = 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::utils::payload_nonce(v0);
        assert!(!0x2::table::contains<u128, bool>(&arg0.claimed, v3), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::already_claimed());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward_balance, v2, arg3), v1);
        0x2::table::add<u128, bool>(&mut arg0.claimed, v3, true);
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_rewards_claimed_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg3), v1, v2, v3);
    }

    entry fun create_reward_pool<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::zero_address());
        let v0 = 0x2::object::new(arg2);
        let v1 = RewardPool<T0>{
            id             : v0,
            controller     : arg1,
            reward_balance : 0x2::balance::zero<T0>(),
            claimed        : 0x2::table::new<u128, bool>(arg2),
            version        : 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v1);
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_created_rewards_pool_event(0x2::object::uid_to_inner(&v0), arg1);
    }

    entry fun fund_rewards_pool<T0>(arg0: &mut RewardPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        0x2::coin::put<T0>(&mut arg0.reward_balance, arg1);
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_reward_amount_deposited_event(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg2), 0x2::coin::value<T0>(&arg1), 0x2::balance::value<T0>(&arg0.reward_balance));
    }

    entry fun update_rewards_controller<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut RewardPool<T0>, arg2: address) {
        assert!(arg1.version == 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::constants::get_version(), 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors::version_mismatch());
        arg1.controller = arg2;
        0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::events::emit_rewards_pool_controller_update_event(0x2::object::uid_to_inner(&arg1.id), arg2);
    }

    entry fun update_version_for_reward_pool<T0>(arg0: &0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::roles::AdminCap, arg1: &mut RewardPool<T0>) {
        arg1.version = arg1.version + 1;
    }

    // decompiled from Move bytecode v6
}

