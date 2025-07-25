module 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::events {
    struct PurchasedLootBoxEvent has copy, drop {
        lootbox_id: 0x2::object::ID,
        purchased_lootbox_id: 0x2::object::ID,
        buyer: address,
        coin_id: 0x1::ascii::String,
    }

    struct RevealedLootBoxEvent has copy, drop {
        purchased_lootbox_id: 0x2::object::ID,
        lootbox_id: 0x2::object::ID,
        buyer: address,
        reward: u64,
        coin_id: 0x1::ascii::String,
    }

    struct LootboxRevealedEvent has copy, drop {
        bet_id: 0x2::object::ID,
        stake: u64,
        payout_multiplier: 0x1::uq32_32::UQ32_32,
        lootbox_id: 0x2::object::ID,
        gambler: address,
        reward: u64,
        coin_id: 0x1::ascii::String,
    }

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

    struct SlotRevealedEvent has copy, drop {
        bet_id: 0x2::object::ID,
        win: bool,
        stake: u64,
        payout_multiplier: 0x1::uq32_32::UQ32_32,
        reward: u64,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct DiceBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        amount: u64,
        bet_threshold: u64,
        roll_under: bool,
        number_of_dices: u8,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct RevealedDiceBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        win: bool,
        stake: u64,
        payout_multiplier: 0x1::uq32_32::UQ32_32,
        bet_threshold: u64,
        roll_under: bool,
        random_number: u64,
        reward: u64,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct LimboBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        amount: u64,
        target_multiplier: 0x1::uq32_32::UQ32_32,
        number_of_bets: u8,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct LimboRevealedEvent has copy, drop {
        bet_id: 0x2::object::ID,
        stake: u64,
        payout_multiplier: 0x1::uq32_32::UQ32_32,
        target_multiplier: 0x1::uq32_32::UQ32_32,
        multiplier: 0x1::uq32_32::UQ32_32,
        win: bool,
        reward: u64,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct PlinkoBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        amount: u64,
        number_of_balls: u8,
        total_stake_value: u64,
        plinko_config_number: u8,
        number_of_rows: u8,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct PlinkoRevealedEvent has copy, drop {
        bet_id: 0x2::object::ID,
        stake: u64,
        payout_multiplier: 0x1::uq32_32::UQ32_32,
        multiplier_index: u8,
        reward: u64,
        plinko_config_number: u8,
        number_of_rows: u8,
        gambler: address,
        coin_id: 0x1::ascii::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
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

    public fun emit_coinflip_bet_event(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: 0x1::ascii::String) {
        let v0 = CoinFlipBetEvent{
            bet_id  : arg0,
            amount  : arg1,
            gambler : arg2,
            coin_id : arg3,
        };
        0x2::event::emit<CoinFlipBetEvent>(v0);
    }

    public fun emit_dice_bet_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: bool, arg4: u8, arg5: address, arg6: 0x1::ascii::String) {
        let v0 = DiceBetEvent{
            bet_id          : arg0,
            amount          : arg1,
            bet_threshold   : arg2,
            roll_under      : arg3,
            number_of_dices : arg4,
            gambler         : arg5,
            coin_id         : arg6,
        };
        0x2::event::emit<DiceBetEvent>(v0);
    }

    public fun emit_limbo_bet_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::uq32_32::UQ32_32, arg3: u8, arg4: address, arg5: 0x1::ascii::String) {
        let v0 = LimboBetEvent{
            bet_id            : arg0,
            amount            : arg1,
            target_multiplier : arg2,
            number_of_bets    : arg3,
            gambler           : arg4,
            coin_id           : arg5,
        };
        0x2::event::emit<LimboBetEvent>(v0);
    }

    public fun emit_lootbox_revealed_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::uq32_32::UQ32_32, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: 0x1::ascii::String) {
        let v0 = LootboxRevealedEvent{
            bet_id            : arg0,
            stake             : arg1,
            payout_multiplier : arg2,
            lootbox_id        : arg3,
            gambler           : arg4,
            reward            : arg5,
            coin_id           : arg6,
        };
        0x2::event::emit<LootboxRevealedEvent>(v0);
    }

    public fun emit_nft_minted_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String) {
        let v0 = NFTMinted{
            object_id : arg0,
            creator   : arg1,
            name      : arg2,
        };
        0x2::event::emit<NFTMinted>(v0);
    }

    public fun emit_plinko_bet_event(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u64, arg4: u8, arg5: u8, arg6: address, arg7: 0x1::ascii::String) {
        let v0 = PlinkoBetEvent{
            bet_id               : arg0,
            amount               : arg1,
            number_of_balls      : arg2,
            total_stake_value    : arg3,
            plinko_config_number : arg4,
            number_of_rows       : arg5,
            gambler              : arg6,
            coin_id              : arg7,
        };
        0x2::event::emit<PlinkoBetEvent>(v0);
    }

    public fun emit_plinko_revealed_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::uq32_32::UQ32_32, arg3: u8, arg4: u64, arg5: u8, arg6: u8, arg7: address, arg8: 0x1::ascii::String) {
        let v0 = PlinkoRevealedEvent{
            bet_id               : arg0,
            stake                : arg1,
            payout_multiplier    : arg2,
            multiplier_index     : arg3,
            reward               : arg4,
            plinko_config_number : arg5,
            number_of_rows       : arg6,
            gambler              : arg7,
            coin_id              : arg8,
        };
        0x2::event::emit<PlinkoRevealedEvent>(v0);
    }

    public fun emit_purchased_lootbox_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::ascii::String) {
        let v0 = PurchasedLootBoxEvent{
            lootbox_id           : arg0,
            purchased_lootbox_id : arg1,
            buyer                : arg2,
            coin_id              : arg3,
        };
        0x2::event::emit<PurchasedLootBoxEvent>(v0);
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

    public fun emit_revealed_dice_bet_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: 0x1::uq32_32::UQ32_32, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: address, arg9: 0x1::ascii::String) {
        let v0 = RevealedDiceBetEvent{
            bet_id            : arg0,
            win               : arg1,
            stake             : arg2,
            payout_multiplier : arg3,
            bet_threshold     : arg4,
            roll_under        : arg5,
            random_number     : arg6,
            reward            : arg7,
            gambler           : arg8,
            coin_id           : arg9,
        };
        0x2::event::emit<RevealedDiceBetEvent>(v0);
    }

    public fun emit_revealed_limbo_bet_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::uq32_32::UQ32_32, arg3: 0x1::uq32_32::UQ32_32, arg4: 0x1::uq32_32::UQ32_32, arg5: bool, arg6: u64, arg7: address, arg8: 0x1::ascii::String) {
        let v0 = LimboRevealedEvent{
            bet_id            : arg0,
            stake             : arg1,
            payout_multiplier : arg2,
            target_multiplier : arg3,
            multiplier        : arg4,
            win               : arg5,
            reward            : arg6,
            gambler           : arg7,
            coin_id           : arg8,
        };
        0x2::event::emit<LimboRevealedEvent>(v0);
    }

    public fun emit_revealed_lootbox_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: 0x1::ascii::String) {
        let v0 = RevealedLootBoxEvent{
            purchased_lootbox_id : arg0,
            lootbox_id           : arg1,
            buyer                : arg2,
            reward               : arg3,
            coin_id              : arg4,
        };
        0x2::event::emit<RevealedLootBoxEvent>(v0);
    }

    public fun emit_revealed_slot_bet_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: 0x1::uq32_32::UQ32_32, arg4: u64, arg5: address, arg6: 0x1::ascii::String) {
        let v0 = SlotRevealedEvent{
            bet_id            : arg0,
            win               : arg1,
            stake             : arg2,
            payout_multiplier : arg3,
            reward            : arg4,
            gambler           : arg5,
            coin_id           : arg6,
        };
        0x2::event::emit<SlotRevealedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

