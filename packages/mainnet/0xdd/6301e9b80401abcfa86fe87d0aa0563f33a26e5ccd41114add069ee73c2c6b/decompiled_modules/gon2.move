module 0xdd6301e9b80401abcfa86fe87d0aa0563f33a26e5ccd41114add069ee73c2c6b::gon2 {
    struct GON2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GON2, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<GON2>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<GON2>(arg0, b"GON2", b"Anime", b"hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDEbkiMX7ifkkKs9NRxcJdNGjaas57cdKeqkoML5JspP")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cb240c29ef7e514e48a05f3f6a64c843dd92dd7684368821ddd71638b3dc5fe72dc0eb22f1e253efbd03a3dd0b6159de67f991377d3391262307334eaab4c707f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743019404"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

