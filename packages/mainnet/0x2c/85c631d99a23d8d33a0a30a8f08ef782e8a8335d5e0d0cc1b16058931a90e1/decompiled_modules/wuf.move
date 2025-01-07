module 0x2c85c631d99a23d8d33a0a30a8f08ef782e8a8335d5e0d0cc1b16058931a90e1::wuf {
    struct WUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUF>(arg0, 6, b"WUF", b"Uni WIF Hat", b"Evan Cheng's best friend Uni, wearing a hat and ready to conquer SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_30_01_59_13_b42bdf90c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

