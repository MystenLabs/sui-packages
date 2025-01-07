module 0x4d90f31b3413c59d3acb7685220d514cd2a7a1d9f9275fe0c47b0a448c4542f0::bubblu {
    struct BUBBLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLU>(arg0, 6, b"BUBBLU", b"Bubblu the blub", x"4a6f696e2024425542424c55206f6e2068697320616476656e7475726573210a53756920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049770_0b8aa10447.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

