module 0xbf73bce9fa7a7381f09fd5055df9554a00ee20eabf88a3312a39588ae65ca342::chog {
    struct CHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOG>(arg0, 6, b"CHOG", b"CHICKEN DOG", b"is that a chicken? or is that a dog? no, it's $CHOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004189_3219d80710.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

