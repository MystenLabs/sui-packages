module 0x2103ac2dd73c800586086e4ba22c6210c3a75e3bf99a82de7b980ba90dc2f81::gone {
    struct GONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<GONE>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<GONE>(arg0, b"GONE", b"Hunter", b"hunt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDEbkiMX7ifkkKs9NRxcJdNGjaas57cdKeqkoML5JspP")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d36be9afa0084d33eebda2256303222d9e862ed472700df88c62f44af870104e1b71121c0b24fbeca97e1e66ac257e76ec18a6213a537706f093fd19d7eaf20ff5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743022633"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

