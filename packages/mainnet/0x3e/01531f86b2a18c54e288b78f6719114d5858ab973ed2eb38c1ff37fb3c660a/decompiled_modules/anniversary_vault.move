module 0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::anniversary_vault {
    struct Today365 has store, key {
        id: 0x2::object::UID,
        date_yyyymmdd: u64,
        content_cid: vector<u8>,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        royalty_bps: u16,
        minted_at_ms: u64,
        was_rewarded: bool,
        claimed: bool,
    }

    struct AnniversaryRewardClaimed has copy, drop, store {
        ticket_id: 0x2::object::ID,
        claimer: address,
        reward_amount: u64,
    }

    struct AnniversaryVault has key {
        id: 0x2::object::UID,
    }

    public entry fun claim_reward(arg0: &mut Today365, arg1: &mut 0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::memory_ledger::MemoryLedger, arg2: &mut 0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::tvyn::MintVault, arg3: &0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::config_registry::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.claimed == false, 204);
        assert!(arg0.was_rewarded, 203);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.minted_at_ms + 31536000000, 202);
        let v1 = 0x2::object::id<Today365>(arg0);
        0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::memory_ledger::mark_anniversary_claimed(arg1, v1, v0);
        let v2 = 0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::config_registry::reward_today_deferred(arg3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::tvyn::TVYN>>(0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::tvyn::mint_for_protocol(arg2, v2, arg5), v0);
        };
        let v3 = AnniversaryRewardClaimed{
            ticket_id     : v1,
            claimer       : v0,
            reward_amount : v2,
        };
        0x2::event::emit<AnniversaryRewardClaimed>(v3);
        arg0.claimed = true;
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AnniversaryVault{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AnniversaryVault>(v0);
    }

    public fun creator(arg0: &Today365) : address {
        arg0.creator
    }

    public(friend) fun mint_ticket(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u16, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Today365 {
        Today365{
            id            : 0x2::object::new(arg8),
            date_yyyymmdd : arg0,
            content_cid   : arg1,
            image_url     : 0x1::string::utf8(arg2),
            name          : 0x1::string::utf8(b"TimeVyn 365"),
            description   : 0x1::string::utf8(arg3),
            creator       : arg4,
            royalty_bps   : arg5,
            minted_at_ms  : 0x2::clock::timestamp_ms(arg7),
            was_rewarded  : arg6,
            claimed       : false,
        }
    }

    public fun royalty_bps(arg0: &Today365) : u16 {
        arg0.royalty_bps
    }

    public fun ticket_id(arg0: &Today365) : 0x2::object::ID {
        0x2::object::id<Today365>(arg0)
    }

    // decompiled from Move bytecode v6
}

