module 0x8e7c4432ea65b85117182fb3f9b016404870a0444f611fd782b5c27c08ac631e::zombi {
    struct ZOMBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBI, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ZOMBI>(arg0, 11397357877547250061, b"zombi fuck", b"ZOMBI", b"we are going fuck bear zombies", b"https://images.hop.ag/ipfs/Qmf6itjqzRz9PtasusPQ68FkR1h12mTr8DirovypU7Fyqg", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

