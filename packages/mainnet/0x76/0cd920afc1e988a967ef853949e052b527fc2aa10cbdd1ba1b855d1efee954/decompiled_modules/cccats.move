module 0x760cd920afc1e988a967ef853949e052b527fc2aa10cbdd1ba1b855d1efee954::cccats {
    struct CCCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCCATS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<CCCATS>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<CCCATS>(arg0, b"CCCATS", b"Cats", b"Besty cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaZmAUi14TPBo3MUAeWp9EkLSCYAeqYpZiCpPYRAQGn41")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d0f8d7e0a5b7b807ba2ffc24419eafd68c00e7edc4041be6d8456843560e24382dcd36e5a1931d9af3ab4fc918aa7f12d641e25ad7d7e19b26c27996bebbf203f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631742200821"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

