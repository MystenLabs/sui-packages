module 0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent {
    struct CollectEvent has copy, drop {
        dummy_field: bool,
    }

    public fun collect_to<T0>(arg0: &mut 0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent_config::DepositAgentConfig, arg1: &0x2::clock::Clock, arg2: &0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg3: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg4: u256, arg5: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg6: address, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent_config::only_allow_version(arg0);
        0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent_config::only_trusted_bot(arg0, arg9);
        0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent_config::when_not_paused(arg0);
        0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent_config::when_not_expired(arg1, arg7);
        0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent_config::check_signer(arg0, 0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::utils::ecrecover(arg8, get_collect_to_sign_msg()));
        0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent_config::when_to_address_match(arg3, arg6);
        0xc81be371f8eeb83c207a61b2c2485a3afbee9d7695c38e0794ea77454bbd5044::deposit_agent_config::token_holder_receive<T0>(arg0, arg2, arg3, arg4, arg5, arg9);
    }

    public(friend) fun get_collect_to_sign_msg() : vector<u8> {
        0x1::vector::empty<u8>()
    }

    // decompiled from Move bytecode v6
}

