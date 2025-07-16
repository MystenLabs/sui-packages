module 0xf3c06b2b080a1ee789ec97448f6ee0fa44707a870fabf664e489885000e66d13::testy {
    struct TESTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTY>(arg0, 6, b"TESTY", b"meme fun test", b"only a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_11_12_19_10_38_995d8cc53b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

