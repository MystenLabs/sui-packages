module 0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::lucky_draw {
    struct LuckyDrawTicket has key {
        id: 0x2::object::UID,
        drand_round: u64,
    }

    fun calc_rarity_seed(arg0: &LuckyDrawTicket, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) : u64 {
        assert!(arg0.drand_round + 2 == arg4, 20481);
        0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::drand_lib::verify_drand_signature(arg2, arg3, arg4);
        0x1::vector::append<u8>(&mut arg2, u64_to_bytes(arg1));
        0x1::vector::append<u8>(&mut arg2, 0x2::object::uid_to_bytes(&arg0.id));
        let v0 = 0x2::hash::blake2b256(&arg2);
        0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::drand_lib::safe_selection(0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::scallop_box::rarity_base(), &v0)
    }

    public(friend) fun draw_ticket(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::drand_lib::is_current_round(arg0, arg1, arg2, arg3);
        let v0 = LuckyDrawTicket{
            id          : 0x2::object::new(arg4),
            drand_round : arg2,
        };
        0x2::transfer::transfer<LuckyDrawTicket>(v0, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun redeem_ticket(arg0: &mut 0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::scallop_box::ScallopBoxStats, arg1: LuckyDrawTicket, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::scallop_box::ScallopBox {
        let LuckyDrawTicket {
            id          : v0,
            drand_round : _,
        } = arg1;
        0x2::object::delete(v0);
        0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::scallop_box::mint_with_rarity_seed(arg0, calc_rarity_seed(&arg1, 0xc5439741907a2cd0d5509754000ddc03d191fb479be06914b46fe2de92a4ebd8::scallop_box::total_minted(arg0), arg2, arg3, arg4), arg5, arg6)
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 8) {
            *0x1::vector::borrow_mut<u8>(&mut v0, (v2 as u64)) = ((arg0 >> ((8 * (7 - v2)) as u8) & 255) as u8);
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

