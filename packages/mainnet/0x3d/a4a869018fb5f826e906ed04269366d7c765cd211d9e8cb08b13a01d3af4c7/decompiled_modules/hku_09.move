module 0x3da4a869018fb5f826e906ed04269366d7c765cd211d9e8cb08b13a01d3af4c7::hku_09 {
    struct HKU_09 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKU_09, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKU_09>(arg0, 9, b"HKU_09", b"hakku", b"just a meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/987820a8-185e-4f9f-9d78-38c48f14fbd1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKU_09>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKU_09>>(v1);
    }

    // decompiled from Move bytecode v6
}

