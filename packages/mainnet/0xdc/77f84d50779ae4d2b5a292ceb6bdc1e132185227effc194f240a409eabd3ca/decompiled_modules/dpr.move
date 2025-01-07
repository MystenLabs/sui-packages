module 0xdc77f84d50779ae4d2b5a292ceb6bdc1e132185227effc194f240a409eabd3ca::dpr {
    struct DPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPR, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DPR>(arg0, 3005660796619895737, b"Dread Pirate Roberts", b"dpr", b"People in masks cannot be trusted.", b"https://images.hop.ag/ipfs/QmVqMWqVtYJG1toS7KCcv5p3TNiVzmyA5SAB5uTMNveY1h", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

