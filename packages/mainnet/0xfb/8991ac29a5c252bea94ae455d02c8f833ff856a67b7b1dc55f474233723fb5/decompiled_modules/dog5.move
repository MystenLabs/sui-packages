module 0xfb8991ac29a5c252bea94ae455d02c8f833ff856a67b7b1dc55f474233723fb5::dog5 {
    struct DOG5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG5, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DOG5>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DOG5>(arg0, b"DOG5", b"DOG Token", b"dog token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmek7G9tE1JB3LX3N7pQrRJpq5AgHNLfjBg3uzRTvGgWSZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f1ae589c3a9ecb96c85275d7d72e9b9a9304c238cf10b7ed7f347087356a7c7dbef8437ae34203b2b70f41a2a5903089312b1178a09388dc98d39ebfbaa5bf0845c0686f8ded97752b4cb01e61c128c3ef8887609d91c57b904300ccc450ecb41744002263"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

