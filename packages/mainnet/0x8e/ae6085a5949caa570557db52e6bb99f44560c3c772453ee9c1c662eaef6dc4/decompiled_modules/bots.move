module 0x8eae6085a5949caa570557db52e6bb99f44560c3c772453ee9c1c662eaef6dc4::bots {
    struct BOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTS>(arg0, 6, b"BOTS", b"Psycho Bots", b"The Psycho Bots Official Meme Token on the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/botzsz_dd3fa86a4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

