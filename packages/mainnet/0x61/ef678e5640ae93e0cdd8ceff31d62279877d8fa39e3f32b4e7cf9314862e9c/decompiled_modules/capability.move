module 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::capability {
    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
    }

    public fun get_creator_cap_info(arg0: &CreatorCap) : (0x2::object::ID, 0x2::object::ID) {
        (0x2::object::id<CreatorCap>(arg0), arg0.nft_id)
    }

    public(friend) fun new_creator_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : CreatorCap {
        CreatorCap{
            id     : 0x2::object::new(arg1),
            nft_id : arg0,
        }
    }

    public fun transfer_creator_cap(arg0: CreatorCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<CreatorCap>(arg0, arg1);
    }

    public fun verify_creator_cap(arg0: &CreatorCap, arg1: 0x2::object::ID) : bool {
        arg0.nft_id == arg1
    }

    // decompiled from Move bytecode v6
}

