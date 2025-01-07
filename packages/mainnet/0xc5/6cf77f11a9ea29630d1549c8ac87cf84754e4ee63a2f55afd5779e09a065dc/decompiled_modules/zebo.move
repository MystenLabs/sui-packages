module 0xc56cf77f11a9ea29630d1549c8ac87cf84754e4ee63a2f55afd5779e09a065dc::zebo {
    struct ZEBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEBO>(arg0, 6, b"ZEBO", b"zebo on sui", b"$ZEBO is the meme you need!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000127050_ee8e4a9928.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

