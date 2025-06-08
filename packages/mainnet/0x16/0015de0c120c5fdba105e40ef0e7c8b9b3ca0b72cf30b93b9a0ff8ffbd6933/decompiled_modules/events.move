module 0x160015de0c120c5fdba105e40ef0e7c8b9b3ca0b72cf30b93b9a0ff8ffbd6933::events {
    struct BetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        amount: u64,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct RevealedBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        win: bool,
        reward: u64,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct CoinFlipBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        amount: u64,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct CoinFlipRevealedEvent has copy, drop {
        bet_id: 0x2::object::ID,
        win: bool,
        stake: u64,
        payout_multiplier: 0x1::uq32_32::UQ32_32,
        reward: u64,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct RefereeRewardsClaimedEvent has copy, drop {
        referee_rewards: u64,
    }

    struct ReferrerRewardsClaimedEvent has copy, drop {
        referrer_rewards: u64,
    }

    public fun emit_bet_event(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: 0x1::ascii::String) {
        let v0 = BetEvent{
            bet_id  : arg0,
            amount  : arg1,
            gambler : arg2,
            coin_id : arg3,
        };
        0x2::event::emit<BetEvent>(v0);
    }

    public fun emit_referee_rewards_claimed_event(arg0: u64) {
        let v0 = RefereeRewardsClaimedEvent{referee_rewards: arg0};
        0x2::event::emit<RefereeRewardsClaimedEvent>(v0);
    }

    public fun emit_referrer_rewards_claimed_event(arg0: u64) {
        let v0 = ReferrerRewardsClaimedEvent{referrer_rewards: arg0};
        0x2::event::emit<ReferrerRewardsClaimedEvent>(v0);
    }

    public fun emit_revealed_bet_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: address, arg4: 0x1::ascii::String) {
        let v0 = RevealedBetEvent{
            bet_id  : arg0,
            win     : arg1,
            reward  : arg2,
            gambler : arg3,
            coin_id : arg4,
        };
        0x2::event::emit<RevealedBetEvent>(v0);
    }

    public fun emit_revealed_coinflip_bet_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: 0x1::uq32_32::UQ32_32, arg4: u64, arg5: address, arg6: 0x1::ascii::String) {
        let v0 = CoinFlipRevealedEvent{
            bet_id            : arg0,
            win               : arg1,
            stake             : arg2,
            payout_multiplier : arg3,
            reward            : arg4,
            gambler           : arg5,
            coin_id           : arg6,
        };
        0x2::event::emit<CoinFlipRevealedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

