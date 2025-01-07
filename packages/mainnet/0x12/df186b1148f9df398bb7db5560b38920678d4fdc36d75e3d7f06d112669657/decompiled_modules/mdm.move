module 0x12df186b1148f9df398bb7db5560b38920678d4fdc36d75e3d7f06d112669657::mdm {
    struct MDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<MDM>(arg0, 9692508500549806617, b"MadMan", b"MDM", b"This MadMan is crazy for crypto!", b"https://images.hop.ag/ipfs/QmY634qho77EaGxroUUdHJMFzLN4mFodYyhRTjFXmRE5vG", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

