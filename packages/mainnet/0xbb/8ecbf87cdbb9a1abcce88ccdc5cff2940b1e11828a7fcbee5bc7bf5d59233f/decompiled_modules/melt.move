module 0xbb8ecbf87cdbb9a1abcce88ccdc5cff2940b1e11828a7fcbee5bc7bf5d59233f::melt {
    struct MELT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELT>(arg0, 6, b"MELT", b"Meltem Demirors", b"A meme coin celebrating Meltem Demirors, a prominent blockchain advocate and investor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Meltem_Demirors_Coin_2afaca7f83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELT>>(v1);
    }

    // decompiled from Move bytecode v6
}

