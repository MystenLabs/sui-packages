module 0x126ecc4263cbfc91319982e21f8a858628d4702d8e92ad29e7da5be3cf1741d8::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAME>(arg0, 6, b"GAME", b"suigame", x"53554947414d4520697320796f757220726574726f2d636869632067616d626c696e67206d656d65636f696e2c207374796c65642061667465722057696e646f777320393820666f72206d6178696d756d2076696265732e204e6f207574696c6974792c206e6f2070726f626c656d2e204f6e6c7920707572652c20756e63757420646567656e20656e657267792e0a0a4a757374207370696e2069742c2077696e2069742c206f72206c6f73652065766572797468696e6720696e20676c6f72696f757320706978656c207374796c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicqgtwj6iuhjazx4rflgw6v3yawqmtmox3xzhbj6c5t7mc27hfbfq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

