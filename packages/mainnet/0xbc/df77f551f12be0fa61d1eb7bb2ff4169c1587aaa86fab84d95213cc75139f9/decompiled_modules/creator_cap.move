module 0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::creator_cap {
    struct CreatorCap has key {
        id: 0x2::object::UID,
        channel_id: 0x2::object::ID,
    }

    public(friend) fun channel_id(arg0: &CreatorCap) : 0x2::object::ID {
        arg0.channel_id
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : CreatorCap {
        CreatorCap{
            id         : 0x2::object::new(arg1),
            channel_id : arg0,
        }
    }

    public fun transfer_to_sender(arg0: CreatorCap, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<CreatorCap>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

