module 0xfdf4253739e94c7075addfa04e5d37dcf2cfbb98e8f08a94a79b482dc83e2e5b::events {
    struct PurchasedLootBoxEvent has copy, drop {
        lootbox_id: 0x2::object::ID,
        purchased_lootbox_id: 0x2::object::ID,
        buyer: address,
    }

    struct RevealedLootBoxEvent has copy, drop {
        purchased_lootbox_id: 0x2::object::ID,
        lootbox_id: 0x2::object::ID,
        buyer: address,
        reward: u64,
    }

    struct BetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        amount: u64,
        gambler: address,
    }

    struct RevealedBetEvent has copy, drop {
        bet_id: 0x2::object::ID,
        win: bool,
        reward: u64,
        gambler: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public(friend) fun emit_bet_event(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = BetEvent{
            bet_id  : arg0,
            amount  : arg1,
            gambler : arg2,
        };
        0x2::event::emit<BetEvent>(v0);
    }

    public(friend) fun emit_nft_minted_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String) {
        let v0 = NFTMinted{
            object_id : arg0,
            creator   : arg1,
            name      : arg2,
        };
        0x2::event::emit<NFTMinted>(v0);
    }

    public(friend) fun emit_purchased_lootbox_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = PurchasedLootBoxEvent{
            lootbox_id           : arg0,
            purchased_lootbox_id : arg1,
            buyer                : arg2,
        };
        0x2::event::emit<PurchasedLootBoxEvent>(v0);
    }

    public(friend) fun emit_revealed_bet_event(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: address) {
        let v0 = RevealedBetEvent{
            bet_id  : arg0,
            win     : arg1,
            reward  : arg2,
            gambler : arg3,
        };
        0x2::event::emit<RevealedBetEvent>(v0);
    }

    public(friend) fun emit_revealed_lootbox_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = RevealedLootBoxEvent{
            purchased_lootbox_id : arg0,
            lootbox_id           : arg1,
            buyer                : arg2,
            reward               : arg3,
        };
        0x2::event::emit<RevealedLootBoxEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

