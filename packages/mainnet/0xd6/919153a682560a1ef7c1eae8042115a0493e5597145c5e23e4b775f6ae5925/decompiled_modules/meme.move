module 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::meme {
    struct MemeNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        contest_id: 0x2::object::ID,
        creator: address,
        blob_id: 0x1::string::String,
        created_at: u64,
        mint_order: u64,
    }

    public(friend) fun burn_meme(arg0: MemeNFT) {
        let MemeNFT {
            id         : v0,
            title      : _,
            contest_id : _,
            creator    : _,
            blob_id    : _,
            created_at : _,
            mint_order : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun id(arg0: &MemeNFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun mint_meme(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : MemeNFT {
        MemeNFT{
            id         : 0x2::object::new(arg6),
            title      : arg1,
            contest_id : arg0,
            creator    : arg2,
            blob_id    : arg3,
            created_at : 0x2::clock::timestamp_ms(arg5),
            mint_order : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

