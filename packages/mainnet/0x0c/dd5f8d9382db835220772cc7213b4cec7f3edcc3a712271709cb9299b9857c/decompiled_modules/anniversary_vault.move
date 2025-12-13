module 0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::anniversary_vault {
    struct AnniversaryTicket has store, key {
        id: 0x2::object::UID,
        date_yyyymmdd: u64,
        content_cid: vector<u8>,
        creator: address,
        royalty_bps: u16,
        minted_at_ms: u64,
        was_rewarded: bool,
    }

    struct AnniversaryRewardClaimed has copy, drop, store {
        ticket_id: 0x2::object::ID,
        claimer: address,
        reward_amount: u64,
    }

    struct AnniversaryVault has key {
        id: 0x2::object::UID,
    }

    public entry fun claim_reward(arg0: AnniversaryTicket, arg1: &mut 0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::memory_ledger::MemoryLedger, arg2: &mut 0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::tvyn::MintVault, arg3: &0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::config_registry::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.was_rewarded, 203);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.minted_at_ms + 31536000000, 202);
        let v1 = 0x2::object::id<AnniversaryTicket>(&arg0);
        0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::memory_ledger::mark_anniversary_claimed(arg1, v1, v0);
        let v2 = 0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::config_registry::reward_today_deferred(arg3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::tvyn::TVYN>>(0xcdd5f8d9382db835220772cc7213b4cec7f3edcc3a712271709cb9299b9857c::tvyn::mint_for_protocol(arg2, v2, arg5), v0);
        };
        let v3 = AnniversaryRewardClaimed{
            ticket_id     : v1,
            claimer       : v0,
            reward_amount : v2,
        };
        0x2::event::emit<AnniversaryRewardClaimed>(v3);
        let AnniversaryTicket {
            id            : v4,
            date_yyyymmdd : _,
            content_cid   : _,
            creator       : _,
            royalty_bps   : _,
            minted_at_ms  : _,
            was_rewarded  : _,
        } = arg0;
        0x2::object::delete(v4);
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AnniversaryVault{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AnniversaryVault>(v0);
    }

    public fun creator(arg0: &AnniversaryTicket) : address {
        arg0.creator
    }

    public(friend) fun mint_ticket(arg0: u64, arg1: vector<u8>, arg2: address, arg3: u16, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : AnniversaryTicket {
        AnniversaryTicket{
            id            : 0x2::object::new(arg6),
            date_yyyymmdd : arg0,
            content_cid   : arg1,
            creator       : arg2,
            royalty_bps   : arg3,
            minted_at_ms  : 0x2::clock::timestamp_ms(arg5),
            was_rewarded  : arg4,
        }
    }

    public fun royalty_bps(arg0: &AnniversaryTicket) : u16 {
        arg0.royalty_bps
    }

    public fun ticket_id(arg0: &AnniversaryTicket) : 0x2::object::ID {
        0x2::object::id<AnniversaryTicket>(arg0)
    }

    // decompiled from Move bytecode v6
}

