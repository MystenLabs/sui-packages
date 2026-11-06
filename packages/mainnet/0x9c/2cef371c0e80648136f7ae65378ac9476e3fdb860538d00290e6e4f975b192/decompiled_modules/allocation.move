module 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation {
    struct RecipientShare has copy, drop, store {
        recipient: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::Recipient,
        meme_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        quote_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
    }

    struct AllocationPlan has copy, drop, store {
        curve_meme_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        lp_meme_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        lp_quote_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        protocol_meme_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        protocol_quote_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        recipients: vector<RecipientShare>,
    }

    struct ProtocolAllocation has copy, drop, store {
        meme_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        quote_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
    }

    public(friend) fun add_protocol(arg0: AllocationPlan, arg1: ProtocolAllocation) : AllocationPlan {
        assert!(0x1::vector::length<RecipientShare>(&arg0.recipients) <= 16, 6);
        arg0.protocol_meme_bps = arg1.meme_bps;
        arg0.protocol_quote_bps = arg1.quote_bps;
        let v0 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg0.curve_meme_bps) + 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg0.lp_meme_bps) + 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg1.meme_bps);
        let v1 = arg0.recipients;
        0x1::vector::reverse<RecipientShare>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<RecipientShare>(&v1)) {
            let v3 = 0x1::vector::pop_back<RecipientShare>(&mut v1);
            v0 = v0 + 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(v3.meme_bps);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<RecipientShare>(v1);
        let v4 = if (v0 == 10000) {
            let v5 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg0.lp_quote_bps) + 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg1.quote_bps);
            let v6 = arg0.recipients;
            0x1::vector::reverse<RecipientShare>(&mut v6);
            let v7 = 0;
            while (v7 < 0x1::vector::length<RecipientShare>(&v6)) {
                let v8 = 0x1::vector::pop_back<RecipientShare>(&mut v6);
                v5 = v5 + 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(v8.quote_bps);
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<RecipientShare>(v6);
            v5 == 10000
        } else {
            false
        };
        assert!(v4, 5);
        arg0
    }

    public(friend) fun apportion_meme(arg0: &AllocationPlan, arg1: u64) : (u64, u64, u64, vector<u64>) {
        let v0 = 0x1::vector::empty<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(v1, arg0.curve_meme_bps);
        0x1::vector::push_back<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(v1, arg0.lp_meme_bps);
        0x1::vector::push_back<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(v1, arg0.protocol_meme_bps);
        let v2 = &arg0.recipients;
        let v3 = 0x1::vector::empty<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<RecipientShare>(v2)) {
            0x1::vector::push_back<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(&mut v3, 0x1::vector::borrow<RecipientShare>(v2, v4).meme_bps);
            v4 = v4 + 1;
        };
        0x1::vector::append<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(&mut v0, v3);
        let v5 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::apportion(v0, arg1, 0x1::option::some<u64>(2));
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v5) - 3) {
            0x1::vector::push_back<u64>(&mut v6, *0x1::vector::borrow<u64>(&v5, v7 + 3));
            v7 = v7 + 1;
        };
        (*0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v5, 1), *0x1::vector::borrow<u64>(&v5, 2), v6)
    }

    public(friend) fun apportion_quote(arg0: &AllocationPlan, arg1: u64) : (u64, u64, vector<u64>) {
        let v0 = 0x1::vector::empty<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>();
        let v1 = &mut v0;
        0x1::vector::push_back<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(v1, arg0.lp_quote_bps);
        0x1::vector::push_back<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(v1, arg0.protocol_quote_bps);
        let v2 = &arg0.recipients;
        let v3 = 0x1::vector::empty<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<RecipientShare>(v2)) {
            0x1::vector::push_back<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(&mut v3, 0x1::vector::borrow<RecipientShare>(v2, v4).quote_bps);
            v4 = v4 + 1;
        };
        0x1::vector::append<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps>(&mut v0, v3);
        let v5 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::apportion(v0, arg1, 0x1::option::some<u64>(1));
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v5) - 2) {
            0x1::vector::push_back<u64>(&mut v6, *0x1::vector::borrow<u64>(&v5, v7 + 2));
            v7 = v7 + 1;
        };
        (*0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v5, 1), v6)
    }

    public(friend) fun meme_bps(arg0: &ProtocolAllocation) : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps {
        arg0.meme_bps
    }

    public(friend) fun payees(arg0: &AllocationPlan) : vector<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::Recipient> {
        let v0 = &arg0.recipients;
        let v1 = 0x1::vector::empty<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::Recipient>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<RecipientShare>(v0)) {
            0x1::vector::push_back<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::Recipient>(&mut v1, 0x1::vector::borrow<RecipientShare>(v0, v2).recipient);
            v2 = v2 + 1;
        };
        v1
    }

    public fun plan(arg0: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg2: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg3: vector<RecipientShare>) : AllocationPlan {
        let v0 = if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg0) > 0) {
            if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg1) > 0) {
                0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg2) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        AllocationPlan{
            curve_meme_bps     : arg0,
            lp_meme_bps        : arg1,
            lp_quote_bps       : arg2,
            protocol_meme_bps  : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(0),
            protocol_quote_bps : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(0),
            recipients         : arg3,
        }
    }

    public(friend) fun protocol_allocation(arg0: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps) : ProtocolAllocation {
        assert!(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg0) <= 1000 && 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg1) <= 1000, 4);
        ProtocolAllocation{
            meme_bps  : arg0,
            quote_bps : arg1,
        }
    }

    public(friend) fun quote_bps(arg0: &ProtocolAllocation) : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps {
        arg0.quote_bps
    }

    public fun recipient_share(arg0: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::Recipient, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg2: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps) : RecipientShare {
        RecipientShare{
            recipient : arg0,
            meme_bps  : arg1,
            quote_bps : arg2,
        }
    }

    // decompiled from Move bytecode v7
}

