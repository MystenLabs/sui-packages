module 0x76ea6bbd10a016989754647b5b4982d9fd5189372d6067596b9857dab20491a::gon {
    struct GON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<GON>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<GON>(arg0, b"Gon", b"Anime", b"hunter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDEbkiMX7ifkkKs9NRxcJdNGjaas57cdKeqkoML5JspP")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c30eea2fa64dff661a72300b1a61dd978879c1e536cf0631cd39d834b2a88b3af0e03a960a4f2a5d5c7e3bfd7fb7836152902af4e078814a435717190bae2a0cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743018169"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

