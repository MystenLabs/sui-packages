module 0x84b35c535867bb98a15552bd1ba09ddbec2a18483d98161db0dacfc71b4f6fbc::webird {
    struct WEBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEBIRD>(arg0, 9, b"WEBIRD", b"BIRD", b"Bird is a meme inspired by the intelligence of parrots, With Bird, we are not only smart but we will rule the world of intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77bc5bff-d4e7-4c66-aaa1-4dd51c618d00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

