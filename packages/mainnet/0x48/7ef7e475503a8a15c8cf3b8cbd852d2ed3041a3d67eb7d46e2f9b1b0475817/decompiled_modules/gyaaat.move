module 0x487ef7e475503a8a15c8cf3b8cbd852d2ed3041a3d67eb7d46e2f9b1b0475817::gyaaat {
    struct GYAAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYAAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYAAAT>(arg0, 6, b"GYAAAT", b"Gyaaat", b"Look at that GYAAAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa_1_928a5b45c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYAAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GYAAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

