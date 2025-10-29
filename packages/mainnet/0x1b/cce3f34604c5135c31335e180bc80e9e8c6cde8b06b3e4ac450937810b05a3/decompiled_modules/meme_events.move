module 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::meme_events {
    struct MemeNFTCreated has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        parent_id: 0x1::option::Option<0x2::object::ID>,
        timestamp: u64,
    }

    struct CreatorCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct MemeNFTLiked has copy, drop {
        nft_id: 0x2::object::ID,
        liker: address,
        total_likes: u64,
        timestamp: u64,
    }

    struct MemeNFTUnliked has copy, drop {
        nft_id: 0x2::object::ID,
        unliker: address,
        total_likes: u64,
        timestamp: u64,
    }

    struct TipReceived has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        coin_type: 0x1::string::String,
        is_creator: bool,
        timestamp: u64,
    }

    struct TipDistributed has copy, drop {
        nft_id: 0x2::object::ID,
        total_amount: u64,
        creator_amount: u64,
        ancestor_count: u64,
        ancestor_share_each: u64,
        coin_type: 0x1::string::String,
        timestamp: u64,
    }

    struct TipWithdrawn has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        coin_type: 0x1::string::String,
        timestamp: u64,
    }

    public(friend) fun emit_creator_cap_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreatorCapCreated{
            cap_id : arg0,
            nft_id : arg1,
        };
        0x2::event::emit<CreatorCapCreated>(v0);
    }

    public(friend) fun emit_meme_nft_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64) {
        let v0 = MemeNFTCreated{
            nft_id    : arg0,
            creator   : arg1,
            title     : arg2,
            parent_id : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<MemeNFTCreated>(v0);
    }

    public(friend) fun emit_meme_nft_liked(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = MemeNFTLiked{
            nft_id      : arg0,
            liker       : arg1,
            total_likes : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<MemeNFTLiked>(v0);
    }

    public(friend) fun emit_meme_nft_unliked(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = MemeNFTUnliked{
            nft_id      : arg0,
            unliker     : arg1,
            total_likes : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<MemeNFTUnliked>(v0);
    }

    public(friend) fun emit_tip_distributed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: u64) {
        let v0 = TipDistributed{
            nft_id              : arg0,
            total_amount        : arg1,
            creator_amount      : arg2,
            ancestor_count      : arg3,
            ancestor_share_each : arg4,
            coin_type           : arg5,
            timestamp           : arg6,
        };
        0x2::event::emit<TipDistributed>(v0);
    }

    public(friend) fun emit_tip_received(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: bool, arg5: u64) {
        let v0 = TipReceived{
            nft_id     : arg0,
            recipient  : arg1,
            amount     : arg2,
            coin_type  : arg3,
            is_creator : arg4,
            timestamp  : arg5,
        };
        0x2::event::emit<TipReceived>(v0);
    }

    public(friend) fun emit_tip_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: u64) {
        let v0 = TipWithdrawn{
            nft_id    : arg0,
            recipient : arg1,
            amount    : arg2,
            coin_type : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<TipWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

