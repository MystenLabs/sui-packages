module 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::creator_cap {
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

