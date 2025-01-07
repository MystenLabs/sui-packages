module 0x5f81f4f8f61d02c0ab1ca3e43ca9e00f735c141ec3842a7a21b7c78b2416d584::noot {
    struct NOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOT>(arg0, 6, b"NOOT", b"Noot Noot", b"Pingu's \"Noot Noot\" catchphrase has transformed from innocent to terrifying, thanks to a 2022 viral animation. This unexpected twist has left fans shocked and fascinated, showcasing how internet culture can quickly shift and subvert expectations, turning wholesome into unsettling. The \"Noot Noot\" meme now has a lasting impact.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241227_015936_885_4f5e6e349f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

