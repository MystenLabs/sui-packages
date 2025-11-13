module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events {
    struct WalletCreated has copy, drop, store {
        wallet_id: address,
        owner: address,
    }

    struct BalanceChecked has copy, drop, store {
        wallet_id: address,
        owner: address,
        balance: u64,
    }

    struct ReceiveAddress has copy, drop, store {
        wallet_id: address,
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct FundsTransferred has copy, drop, store {
        sender_wallet_id: address,
        sender: address,
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    struct GameStaked has copy, drop, store {
        requester: address,
        accepter: address,
        stake_amount: u64,
        total_stake: u64,
        system_fee: u64,
        timestamp: u64,
    }

    struct GameCompleted has copy, drop, store {
        requester: address,
        accepter: address,
        requester_score: u64,
        accepter_score: u64,
        winner: address,
        prize_amount: u64,
        system_fee: u64,
        total_stake: u64,
        timestamp: u64,
    }

    struct ExternalGameStaked has copy, drop, store {
        requester: address,
        accepter: address,
        stake_amount: u64,
        total_stake: u64,
        system_fee: u64,
        api_caller: address,
        game_id: vector<u8>,
        timestamp: u64,
    }

    struct ExternalGameCompleted has copy, drop, store {
        requester: address,
        accepter: address,
        requester_score: u64,
        accepter_score: u64,
        winner: address,
        prize_amount: u64,
        api_fee: u64,
        escrow_fee: u64,
        total_stake: u64,
        api_caller: address,
        game_id: vector<u8>,
        timestamp: u64,
    }

    struct PriceFetched has copy, drop, store {
        feed_id: vector<u8>,
        price: u64,
        timestamp_ns: u64,
        raw_magnitude: u128,
        current_time_ns: u64,
    }

    struct MedalAwarded has copy, drop, store {
        medal_type: u8,
        owner: address,
        is_external: bool,
        timestamp: u64,
    }

    struct TournamentCreated has copy, drop, store {
        tournament_id: address,
        creator: address,
        is_bracket: bool,
        payout_type: u8,
        is_external: bool,
        api_caller: address,
        timestamp: u64,
    }

    struct TournamentRoundProcessed has copy, drop, store {
        tournament_id: address,
        round_number: u64,
        timestamp: u64,
    }

    struct TournamentFinalized has copy, drop, store {
        tournament_id: address,
        creator: address,
        total_prize: u64,
        total_fee: u64,
        players_count: u64,
        timestamp: u64,
    }

    struct CallerAdded has copy, drop, store {
        caller: address,
        timestamp: u64,
    }

    struct CallerRemoved has copy, drop, store {
        caller: address,
        timestamp: u64,
    }

    public fun emit_balance_checked(arg0: address, arg1: address, arg2: u64) {
        let v0 = BalanceChecked{
            wallet_id : arg0,
            owner     : arg1,
            balance   : arg2,
        };
        0x2::event::emit<BalanceChecked>(v0);
    }

    public fun emit_caller_added(arg0: address, arg1: u64) {
        let v0 = CallerAdded{
            caller    : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<CallerAdded>(v0);
    }

    public fun emit_caller_removed(arg0: address, arg1: u64) {
        let v0 = CallerRemoved{
            caller    : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<CallerRemoved>(v0);
    }

    public fun emit_external_game_completed(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: vector<u8>, arg11: u64) {
        let v0 = ExternalGameCompleted{
            requester       : arg0,
            accepter        : arg1,
            requester_score : arg2,
            accepter_score  : arg3,
            winner          : arg4,
            prize_amount    : arg5,
            api_fee         : arg6,
            escrow_fee      : arg7,
            total_stake     : arg8,
            api_caller      : arg9,
            game_id         : arg10,
            timestamp       : arg11,
        };
        0x2::event::emit<ExternalGameCompleted>(v0);
    }

    public fun emit_external_game_staked(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: vector<u8>, arg7: u64) {
        let v0 = ExternalGameStaked{
            requester    : arg0,
            accepter     : arg1,
            stake_amount : arg2,
            total_stake  : arg3,
            system_fee   : arg4,
            api_caller   : arg5,
            game_id      : arg6,
            timestamp    : arg7,
        };
        0x2::event::emit<ExternalGameStaked>(v0);
    }

    public fun emit_funds_transferred(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = FundsTransferred{
            sender_wallet_id : arg0,
            sender           : arg1,
            recipient        : arg2,
            amount           : arg3,
            timestamp        : arg4,
        };
        0x2::event::emit<FundsTransferred>(v0);
    }

    public fun emit_game_completed(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = GameCompleted{
            requester       : arg0,
            accepter        : arg1,
            requester_score : arg2,
            accepter_score  : arg3,
            winner          : arg4,
            prize_amount    : arg5,
            system_fee      : arg6,
            total_stake     : arg7,
            timestamp       : arg8,
        };
        0x2::event::emit<GameCompleted>(v0);
    }

    public fun emit_game_staked(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = GameStaked{
            requester    : arg0,
            accepter     : arg1,
            stake_amount : arg2,
            total_stake  : arg3,
            system_fee   : arg4,
            timestamp    : arg5,
        };
        0x2::event::emit<GameStaked>(v0);
    }

    public fun emit_medal_awarded(arg0: u8, arg1: address, arg2: bool, arg3: u64) {
        let v0 = MedalAwarded{
            medal_type  : arg0,
            owner       : arg1,
            is_external : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<MedalAwarded>(v0);
    }

    public fun emit_price_fetched(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u128, arg4: u64) {
        let v0 = PriceFetched{
            feed_id         : arg0,
            price           : arg1,
            timestamp_ns    : arg2,
            raw_magnitude   : arg3,
            current_time_ns : arg4,
        };
        0x2::event::emit<PriceFetched>(v0);
    }

    public fun emit_receive_address(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ReceiveAddress{
            wallet_id : arg0,
            owner     : arg1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<ReceiveAddress>(v0);
    }

    public fun emit_tournament_created(arg0: address, arg1: address, arg2: bool, arg3: u8, arg4: bool, arg5: address, arg6: u64) {
        let v0 = TournamentCreated{
            tournament_id : arg0,
            creator       : arg1,
            is_bracket    : arg2,
            payout_type   : arg3,
            is_external   : arg4,
            api_caller    : arg5,
            timestamp     : arg6,
        };
        0x2::event::emit<TournamentCreated>(v0);
    }

    public fun emit_tournament_finalized(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = TournamentFinalized{
            tournament_id : arg0,
            creator       : arg1,
            total_prize   : arg2,
            total_fee     : arg3,
            players_count : arg4,
            timestamp     : arg5,
        };
        0x2::event::emit<TournamentFinalized>(v0);
    }

    public fun emit_tournament_round_processed(arg0: address, arg1: u64, arg2: u64) {
        let v0 = TournamentRoundProcessed{
            tournament_id : arg0,
            round_number  : arg1,
            timestamp     : arg2,
        };
        0x2::event::emit<TournamentRoundProcessed>(v0);
    }

    public fun emit_wallet_created(arg0: address, arg1: address) {
        let v0 = WalletCreated{
            wallet_id : arg0,
            owner     : arg1,
        };
        0x2::event::emit<WalletCreated>(v0);
    }

    // decompiled from Move bytecode v6
}

