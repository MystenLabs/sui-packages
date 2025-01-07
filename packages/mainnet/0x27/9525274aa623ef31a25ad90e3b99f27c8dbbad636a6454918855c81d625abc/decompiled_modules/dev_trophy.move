module 0x279525274aa623ef31a25ad90e3b99f27c8dbbad636a6454918855c81d625abc::dev_trophy {
    struct SuiDevTrophy has store, key {
        id: 0x2::object::UID,
        seq_from_station: 0x1::option::Option<u64>,
        trophy_sender: 0x1::option::Option<address>,
    }

    struct TrophyStation has store, key {
        id: 0x2::object::UID,
        next_tropy_seq: u64,
    }

    struct AwardEvent has copy, drop {
        trophy_seq: u64,
        trophy_sender: address,
    }

    public fun drop_trophy(arg0: SuiDevTrophy) {
        let SuiDevTrophy {
            id               : v0,
            seq_from_station : _,
            trophy_sender    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TrophyStation{
            id             : 0x2::object::new(arg0),
            next_tropy_seq : 0,
        };
        0x2::transfer::share_object<TrophyStation>(v0);
    }

    public fun self_award_trophy(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiDevTrophy{
            id               : 0x2::object::new(arg0),
            seq_from_station : 0x1::option::none<u64>(),
            trophy_sender    : 0x1::option::none<address>(),
        };
        0x2::transfer::transfer<SuiDevTrophy>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun stamp_trophy(arg0: &mut TrophyStation, arg1: &mut SuiDevTrophy, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.next_tropy_seq;
        let v1 = &mut arg1.seq_from_station;
        let v2 = &mut arg1.trophy_sender;
        assert!(0x1::option::is_none<u64>(v1), 400);
        *v1 = 0x1::option::some<u64>(*v0);
        *v2 = 0x1::option::some<address>(0x2::tx_context::sender(arg2));
        let v3 = AwardEvent{
            trophy_seq    : *v0,
            trophy_sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AwardEvent>(v3);
        *v0 = *v0 + 1;
    }

    // decompiled from Move bytecode v6
}

