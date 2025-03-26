module 0xe3882bc3cddb2cbc055768072096effe0cfc089010090f2b6b7ae07b63bf2a63::gone {
    struct GONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<GONE>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<GONE>(arg0, b"Gone", b"HH", b"Hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDEbkiMX7ifkkKs9NRxcJdNGjaas57cdKeqkoML5JspP")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000478cd2d7a56137c9e6d3fdd5c45eec1f7c3fd312230e5b0b456f0f8863e4b5512464671bcbc68e698f585142d0210199974d3ff4a5949f9bd8a29487f8e540cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743022772"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

