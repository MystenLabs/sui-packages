module 0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::lucky_draw {
    struct LuckyDrawTicket has key {
        id: 0x2::object::UID,
        drand_round: u64,
    }

    fun calc_rarity_seed(arg0: &LuckyDrawTicket, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : u64 {
        assert!(arg0.drand_round + 2 == arg3, 20481);
        0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::drand_lib::verify_drand_signature(arg1, arg2, arg3);
        0x1::vector::append<u8>(&mut arg1, 0x2::object::uid_to_bytes(&arg0.id));
        let v0 = 0x2::hash::blake2b256(&arg1);
        0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::drand_lib::safe_selection(0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::scallop_box::rarity_base(), &v0)
    }

    public(friend) fun draw_ticket(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::drand_lib::is_current_round(arg0, arg1, arg2, arg3);
        let v0 = LuckyDrawTicket{
            id          : 0x2::object::new(arg4),
            drand_round : arg2,
        };
        0x2::transfer::transfer<LuckyDrawTicket>(v0, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun redeem_ticket(arg0: &mut 0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::scallop_box::ScallopBoxStats, arg1: LuckyDrawTicket, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::scallop_box::ScallopBox {
        let LuckyDrawTicket {
            id          : v0,
            drand_round : _,
        } = arg1;
        0x2::object::delete(v0);
        0x3bb1e0e1a18a28e2201b89bd40ad14c0178061cc5a8759bcda0b11b3bc08e84a::scallop_box::mint_with_rarity_seed(arg0, calc_rarity_seed(&arg1, arg2, arg3, arg4), arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

