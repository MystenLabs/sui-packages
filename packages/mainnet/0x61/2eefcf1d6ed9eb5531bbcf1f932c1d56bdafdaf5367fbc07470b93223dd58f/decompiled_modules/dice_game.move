module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::dice_game {
    struct Round has store, key {
        id: 0x2::object::UID,
        round_id: u64,
        start_time: u64,
        end_time: u64,
        result: 0x1::option::Option<u8>,
        total_bets: u64,
        pool_id: 0x2::object::ID,
    }

    struct DiceGameState has key {
        id: 0x2::object::UID,
        current_round: u64,
        rounds: 0x2::table::Table<u64, Round>,
        bets: 0x2::table::Table<u64, vector<address>>,
        pool_id: 0x2::object::ID,
    }

    struct BetPlaced has copy, drop {
        player: address,
        round: u64,
        bet_type: u8,
        amount: u64,
    }

    struct RoundSettled has copy, drop {
        round: u64,
        result: u8,
        total_payout: u64,
    }

    fun borrow_pool(arg0: 0x2::object::ID) : &mut 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::pool::Pool<DiceGameState> {
        abort 0
    }

    public fun create_game_state(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : DiceGameState {
        DiceGameState{
            id            : 0x2::object::new(arg1),
            current_round : 0,
            rounds        : 0x2::table::new<u64, Round>(arg1),
            bets          : 0x2::table::new<u64, vector<address>>(arg1),
            pool_id       : arg0,
        }
    }

    public fun place_bet(arg0: &mut DiceGameState, arg1: u8, arg2: u64, arg3: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.current_round;
        assert!(0x2::coin::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg3) == arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>>(arg3, 0x2::tx_context::sender(arg5));
        if (!0x2::table::contains<u64, vector<address>>(&arg0.bets, v0)) {
            0x2::table::add<u64, vector<address>>(&mut arg0.bets, v0, vector[]);
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<u64, vector<address>>(&mut arg0.bets, v0), 0x2::tx_context::sender(arg5));
        let v1 = BetPlaced{
            player   : 0x2::tx_context::sender(arg5),
            round    : v0,
            bet_type : arg1,
            amount   : arg2,
        };
        0x2::event::emit<BetPlaced>(v1);
    }

    public fun settle_round(arg0: &mut DiceGameState, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.current_round;
        0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::pool::fee_rate_bps<DiceGameState>(borrow_pool(arg0.pool_id));
        if (0x2::table::contains<u64, vector<address>>(&arg0.bets, v0)) {
            0x2::table::borrow_mut<u64, vector<address>>(&mut arg0.bets, v0);
        };
        arg0.current_round = v0 + 1;
        let v1 = RoundSettled{
            round        : v0,
            result       : 11,
            total_payout : 0,
        };
        0x2::event::emit<RoundSettled>(v1);
    }

    // decompiled from Move bytecode v6
}

