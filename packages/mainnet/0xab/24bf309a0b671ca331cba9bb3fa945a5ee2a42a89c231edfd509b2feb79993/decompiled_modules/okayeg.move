module 0xab24bf309a0b671ca331cba9bb3fa945a5ee2a42a89c231edfd509b2feb79993::okayeg {
    struct OKAYEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKAYEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OKAYEG>(arg0, 6, b"Okayeg", b"Okayeg  Matt Furie", b"The \"okayeg\" meme is a variant of the \"Pepe the Frog\" meme, which originated from the webcomic series \"Boys Club\" by Matt Furie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/okayeg1716903773319_0f2a66c3d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKAYEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OKAYEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

