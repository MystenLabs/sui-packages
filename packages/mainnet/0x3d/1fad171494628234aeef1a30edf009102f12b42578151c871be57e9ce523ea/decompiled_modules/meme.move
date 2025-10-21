module 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme {
    struct NFTMintedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        title: 0x1::string::String,
        contest_id: 0x2::object::ID,
        creator: address,
        ipfs_hash: 0x1::string::String,
        image_url: 0x1::string::String,
        animation_url: 0x1::string::String,
        created_at: u64,
        mint_order: u64,
        description: 0x1::string::String,
    }

    struct NFTDeletedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        title: 0x1::string::String,
        contest_id: 0x2::object::ID,
        creator: address,
        ipfs_hash: 0x1::string::String,
        created_at: u64,
        deleted_at: u64,
        mint_order: u64,
    }

    struct MemeNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        contest_id: 0x2::object::ID,
        creator: address,
        ipfs_id: 0x1::string::String,
        image_url: 0x1::string::String,
        animation_url: 0x1::string::String,
        created_at: u64,
        mint_order: u64,
    }

    public(friend) fun burn_meme(arg0: MemeNFT, arg1: &0x2::clock::Clock) {
        let v0 = NFTDeletedEvent{
            nft_id     : 0x2::object::uid_to_inner(&arg0.id),
            title      : arg0.title,
            contest_id : arg0.contest_id,
            creator    : arg0.creator,
            ipfs_hash  : arg0.ipfs_id,
            created_at : arg0.created_at,
            deleted_at : 0x2::clock::timestamp_ms(arg1),
            mint_order : arg0.mint_order,
        };
        0x2::event::emit<NFTDeletedEvent>(v0);
        let MemeNFT {
            id            : v1,
            title         : _,
            description   : _,
            contest_id    : _,
            creator       : _,
            ipfs_id       : _,
            image_url     : _,
            animation_url : _,
            created_at    : _,
            mint_order    : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun id(arg0: &MemeNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun mint_meme(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : MemeNFT {
        let v0 = MemeNFT{
            id            : 0x2::object::new(arg9),
            title         : arg1,
            description   : arg8,
            contest_id    : arg0,
            creator       : arg2,
            ipfs_id       : arg3,
            image_url     : arg6,
            animation_url : arg7,
            created_at    : 0x2::clock::timestamp_ms(arg5),
            mint_order    : arg4,
        };
        let v1 = NFTMintedEvent{
            nft_id        : 0x2::object::uid_to_inner(&v0.id),
            title         : v0.title,
            contest_id    : arg0,
            creator       : arg2,
            ipfs_hash     : v0.ipfs_id,
            image_url     : arg6,
            animation_url : arg7,
            created_at    : 0x2::clock::timestamp_ms(arg5),
            mint_order    : arg4,
            description   : arg8,
        };
        0x2::event::emit<NFTMintedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

