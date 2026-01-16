module 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::member_cap {
    struct MemberCap has key {
        id: 0x2::object::UID,
        channel_id: 0x2::object::ID,
    }

    public fun channel_id(arg0: &MemberCap) : 0x2::object::ID {
        arg0.channel_id
    }

    public(friend) fun burn(arg0: MemberCap) {
        let MemberCap {
            id         : v0,
            channel_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : MemberCap {
        MemberCap{
            id         : 0x2::object::new(arg1),
            channel_id : arg0,
        }
    }

    public fun transfer_member_caps(arg0: vector<address>, arg1: vector<MemberCap>, arg2: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::CreatorCap) {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<MemberCap>(&arg1), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v1 = 0x1::vector::pop_back<MemberCap>(&mut arg1);
            assert!(v1.channel_id == 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::channel_id(arg2), 0);
            transfer_to_recipient(v1, arg2, *0x1::vector::borrow<address>(&arg0, v0));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<MemberCap>(arg1);
    }

    public fun transfer_to_recipient(arg0: MemberCap, arg1: &0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::CreatorCap, arg2: address) {
        assert!(arg0.channel_id == 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap::channel_id(arg1), 0);
        0x2::transfer::transfer<MemberCap>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

