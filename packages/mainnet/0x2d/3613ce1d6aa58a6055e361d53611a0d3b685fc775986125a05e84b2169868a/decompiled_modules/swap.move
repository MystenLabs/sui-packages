module 0x2d3613ce1d6aa58a6055e361d53611a0d3b685fc775986125a05e84b2169868a::swap {
    struct SwapCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SwapCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

