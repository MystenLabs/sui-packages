module 0x46ea7f5420534cd0c3efa312e6a3dd9af3b4811595ba5bc7bfd230fc56901c33::penguinmcgraw {
    struct PENGUINMCGRAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUINMCGRAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUINMCGRAW>(arg0, 6, b"PenguinMcGraw", b"Penguin McGraw", b"coldest penguin breathing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345345_d5421c5d35.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUINMCGRAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUINMCGRAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

