module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games {
    public fun add_verified_caller(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::AdminCap, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::game_admin::add_verified_caller(arg0, arg1, arg2, arg3);
    }

    public fun is_caller_verified(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg1: address) : bool {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::game_admin::is_caller_verified(arg0, arg1)
    }

    public fun remove_verified_caller(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::AdminCap, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::game_admin::remove_verified_caller(arg0, arg1, arg2, arg3);
    }

    public fun external_pay_winner(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg4: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg5: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg6: &0x2::clock::Clock, arg7: 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::GameState, arg8: address, arg9: address, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::games::external_pay_winner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun external_stake(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg4: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: address, arg10: address, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::games::external_stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun get_escrow_address(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool) : address {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::games::get_escrow_address(arg0)
    }

    public fun get_stake_cap(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: address) : bool {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::games::get_stake_cap(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun get_total_stake(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool) : u64 {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::games::get_total_stake(arg0)
    }

    public fun pay_winner(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg4: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg5: &0x2::clock::Clock, arg6: 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::GameState, arg7: address, arg8: address, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::games::pay_winner(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun stake(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg3: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: address, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::games::stake(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun check_and_award_medals(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::check_and_award_medals(arg0, arg1, arg2, arg3, arg4);
    }

    public fun check_balance(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::wallet::check_balance(arg0, arg1);
    }

    public fun create_tournament(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg1: bool, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::tournaments::create_tournament(arg0, arg1, arg2, arg3, arg4);
    }

    public fun create_wallet(arg0: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::wallet::create_wallet(arg0);
    }

    public fun finalize_tournament(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg4: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg7: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::tournaments::finalize_tournament(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun get_balance(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet) : u64 {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::wallet::get_balance(arg0)
    }

    public fun get_oracle_config(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig) : address {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_price_config_details(arg0)
    }

    public fun get_owner(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet) : address {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::wallet::get_owner(arg0)
    }

    public fun get_sui_usd_price(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg1: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::price_feed::get_sui_usd_price(arg0, arg1, arg2, arg3)
    }

    public fun get_wallet_id_address(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet) : address {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::wallet::get_wallet_id_address(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::transfer_admin_cap(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_admin_cap(arg0), 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_oracle_config(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::oracle_id_mainnet(), arg0));
        0x2::transfer::public_share_object<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_verified_callers(0x2::vec_set::empty<address>(), arg0));
        0x2::transfer::public_share_object<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_stake_pool(0x2::balance::zero<0x2::sui::SUI>(), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::escrow_address(), arg0));
        0x2::transfer::public_share_object<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_leaderboard(0x2::vec_map::empty<address, u64>(), 0x2::table::new<address, u64>(arg0), 0x2::table::new<address, 0x2::vec_map::VecMap<address, u64>>(arg0), 0x2::table::new<address, u8>(arg0), 0x2::table::new<address, 0x2::vec_map::VecMap<address, u8>>(arg0), arg0));
        0x2::transfer::public_share_object<0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::new_medal_check_state(0x2::tx_context::epoch_timestamp_ms(arg0), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::one_month_ms(), arg0));
    }

    fun is_verified_caller(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg1: address) : bool {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::game_admin::is_caller_verified(arg0, arg1)
    }

    public fun join_tournament(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg3: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg6: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::tournaments::join_tournament(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun process_round(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::StakePool, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg2: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg3: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::OracleConfig, arg4: &0x16bf91a0651d9efe74bf97be2e1c0f459d05ef24d1e293b6a35c22ec91d3b5a5::types::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg7: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::TournamentRound, arg8: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg9: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::tournaments::process_round(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun receive(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::wallet::receive(arg0, arg1, arg2);
    }

    public fun send(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Wallet, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::wallet::send(arg0, arg1, arg2, arg3);
    }

    public fun submit_score(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Tournament, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::tournaments::submit_score(arg0, arg1, arg2, arg3);
    }

    public fun try_check_and_award_medals_with_callers(arg0: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::Leaderboard, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::MedalCheckState, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::leaderboard::try_check_and_award_medals_with_callers(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

