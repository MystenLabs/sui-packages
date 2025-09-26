module 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::jollfi_games {
    public fun add_verified_caller(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::AdminCap, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::game_admin::add_verified_caller(arg0, arg1, arg2, arg3);
    }

    public fun is_caller_verified(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg1: address) : bool {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::game_admin::is_caller_verified(arg0, arg1)
    }

    public fun remove_verified_caller(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::AdminCap, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::game_admin::remove_verified_caller(arg0, arg1, arg2, arg3);
    }

    public fun external_pay_winner(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg2: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState, arg3: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg4: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg5: &0x2::clock::Clock, arg6: 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::GameState, arg7: address, arg8: address, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::games::external_pay_winner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun external_stake(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg2: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg3: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: address, arg9: address, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::games::external_stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun get_escrow_address(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool) : address {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::games::get_escrow_address(arg0)
    }

    public fun get_stake_cap(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: address) : bool {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::games::get_stake_cap(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun get_total_stake(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool) : u64 {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::games::get_total_stake(arg0)
    }

    public fun pay_winner(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg2: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState, arg3: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg4: &0x2::clock::Clock, arg5: 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::GameState, arg6: address, arg7: address, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::games::pay_winner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun stake(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg2: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: address, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::games::stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun check_and_award_medals(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::leaderboard::check_and_award_medals(arg0, arg1, arg2, arg3, arg4);
    }

    public fun check_balance(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::wallet::check_balance(arg0, arg1);
    }

    public fun create_tournament(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg1: bool, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::tournaments::create_tournament(arg0, arg1, arg2, arg3, arg4);
    }

    public fun create_wallet(arg0: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::wallet::create_wallet(arg0);
    }

    public fun finalize_tournament(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg2: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState, arg3: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg4: &0x2::clock::Clock, arg5: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Tournament, arg6: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::tournaments::finalize_tournament(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun get_balance(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet) : u64 {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::wallet::get_balance(arg0)
    }

    public fun get_owner(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet) : address {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::wallet::get_owner(arg0)
    }

    public fun get_stork_config(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StorkConfig) : (address, vector<u8>, u64) {
        (0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::stork_config_state_address(arg0), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::stork_config_sui_usd_feed_id(arg0), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::max_price_age_seconds() * 1000)
    }

    public fun get_sui_usd_price(arg0: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::price_feed::get_sui_usd_price(arg0, arg1, arg2)
    }

    public fun get_wallet_id_address(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet) : address {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::wallet::get_wallet_id_address(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::transfer_admin_cap(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_admin_cap(arg0), 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StorkConfig>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_stork_config(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::stork_state_address(), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::sui_usd_feed_id(), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::max_price_age_seconds(), arg0));
        0x2::transfer::public_share_object<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_verified_callers(0x2::vec_set::empty<address>(), arg0));
        0x2::transfer::public_share_object<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_stake_pool(0x2::balance::zero<0x2::sui::SUI>(), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::escrow_address(), arg0));
        0x2::transfer::public_share_object<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_leaderboard(0x2::vec_map::empty<address, u64>(), 0x2::table::new<address, u64>(arg0), 0x2::table::new<address, 0x2::vec_map::VecMap<address, u64>>(arg0), 0x2::table::new<address, u8>(arg0), 0x2::table::new<address, 0x2::vec_map::VecMap<address, u8>>(arg0), arg0));
        0x2::transfer::public_share_object<0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::new_medal_check_state(0x2::tx_context::epoch_timestamp_ms(arg0), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::one_month_ms(), arg0));
    }

    fun is_verified_caller(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg1: address) : bool {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::game_admin::is_caller_verified(arg0, arg1)
    }

    public fun join_tournament(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg2: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg3: &0x2::clock::Clock, arg4: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Tournament, arg5: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::tournaments::join_tournament(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun process_round(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::StakePool, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg2: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState, arg3: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg4: &0x2::clock::Clock, arg5: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Tournament, arg6: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::TournamentRound, arg7: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet, arg8: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::tournaments::process_round(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun receive(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::wallet::receive(arg0, arg1, arg2);
    }

    public fun send(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Wallet, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::wallet::send(arg0, arg1, arg2, arg3);
    }

    public fun submit_score(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Tournament, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::tournaments::submit_score(arg0, arg1, arg2, arg3);
    }

    public fun try_check_and_award_medals_with_callers(arg0: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::Leaderboard, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::MedalCheckState, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::leaderboard::try_check_and_award_medals_with_callers(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

