module 0xd314e08356f6edf2a9c0cffd2a01cdf47aa0ae7242e9d42c98394e5fa159b5eb::mine {
    struct MINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINE>(arg0, 6, b"MINE", b"MINE FOR PREZ", x"4b494e4720504c5520504c5520504c550a0a2068747470733a2f2f742e6d652f4d696e65466f725072657a200a68747470733a2f2f782e636f6d2f4d696e65466f725072657a0a2068747470733a2f2f6d696e65666f727072657a2e636f6d2f0a4b494e4720504c5520504c5520504c550a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_19_33_03_2a0cf7a501.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

