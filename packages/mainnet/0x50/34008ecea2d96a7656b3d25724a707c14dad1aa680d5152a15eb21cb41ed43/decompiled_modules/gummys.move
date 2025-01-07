module 0x5034008ecea2d96a7656b3d25724a707c14dad1aa680d5152a15eb21cb41ed43::gummys {
    struct GUMMYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMMYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMMYS>(arg0, 6, b"GUMMYS", b"Gummy Sui", b"Gummy Sui the Sweetest Gummy on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_22_09_55_16_c62612e930.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMMYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMMYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

