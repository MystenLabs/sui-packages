module 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::capability {
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

