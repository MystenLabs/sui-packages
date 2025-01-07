module 0x90f5e45cdb9b2e683600840ac44312c1cd2bbe105a9a617924b3b3f1b0324659::omc {
    struct OMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMC>(arg0, 0, b"OMC", b"One Meme Coin", b"One Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JRSYW9n.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OMC>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

