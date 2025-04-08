module 0xba369fa9be97b5d600ebbe3a4dcd5e4cb3775f5a2cc004c02aadf3764f2ab942::mkpjf {
    struct MKPJF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKPJF, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<MKPJF>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<MKPJF>(arg0, b"MKPJF", b"MKPJF Token", b"this is MKPJF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbTiFbgzSnzuKHzLEdeGMNKqRM5XxJZ6ahzPZZfJEjxML")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003c5e0410f958888cd5aea4effe863bd36e914c7bd93992247ac1c0c60ca0c988b0b38bd503e0817c21f0be3df34d84654566ed9e7527f886c3a9a3e5aad7ce07f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744107572"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

