module 0xe71e27ecde0d37a4477b7984ede70ae5a57d69597488fb9356905af21073021b::liberty {
    struct LIBERTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBERTY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<LIBERTY>(arg0, 11386823551011333382, b"Liberty", b"$Liberty", b"Liberty, a symbol of freedom and a tribute to my loyal German Shepherd. This coin represents the spirit of independence and the unwavering companionship that dogs bring to our lives.", b"https://images.hop.ag/ipfs/QmY29uKTXgavoYpoAuj6E4fXMXBhzUHc2Kidrhw2jth8r4", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

