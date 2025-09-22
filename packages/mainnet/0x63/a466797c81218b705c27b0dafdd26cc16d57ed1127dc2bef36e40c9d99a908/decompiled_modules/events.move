module 0x63a466797c81218b705c27b0dafdd26cc16d57ed1127dc2bef36e40c9d99a908::events {
    struct AdventurePackMinted has copy, drop {
        pack_id: 0x2::object::ID,
        owner: address,
        pack_type: u8,
        rarity: u8,
    }

    struct AdventurePackOpened has copy, drop {
        pack_id: 0x2::object::ID,
        owner: address,
        rewards_count: u64,
    }

    struct QuestCompleted has copy, drop {
        quest_id: 0x2::object::ID,
        player: address,
        experience_gained: u64,
    }

    public fun emit_adventure_pack_minted(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u8) {
        let v0 = AdventurePackMinted{
            pack_id   : arg0,
            owner     : arg1,
            pack_type : arg2,
            rarity    : arg3,
        };
        0x2::event::emit<AdventurePackMinted>(v0);
    }

    public fun emit_adventure_pack_opened(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = AdventurePackOpened{
            pack_id       : arg0,
            owner         : arg1,
            rewards_count : arg2,
        };
        0x2::event::emit<AdventurePackOpened>(v0);
    }

    public fun emit_quest_completed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = QuestCompleted{
            quest_id          : arg0,
            player            : arg1,
            experience_gained : arg2,
        };
        0x2::event::emit<QuestCompleted>(v0);
    }

    // decompiled from Move bytecode v6
}

