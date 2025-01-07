module 0x797943b4c9ec03767d4f915888529e412c73d48f3fffbfd72e852476622c9ad9::heart {
    struct HEART has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEART>(arg0, 6, b"HEART", b"Heart of the Sui", b"The rarest treasure of Sui, just like the Heart of the Sea in Minecraft. It's the core of everything valuable and powerful on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Heart_of_sea_c9a36e23a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEART>>(v1);
    }

    // decompiled from Move bytecode v6
}

