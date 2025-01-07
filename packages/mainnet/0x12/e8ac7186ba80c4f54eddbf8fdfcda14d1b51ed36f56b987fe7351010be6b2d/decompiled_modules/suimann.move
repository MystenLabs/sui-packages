module 0x12e8ac7186ba80c4f54eddbf8fdfcda14d1b51ed36f56b987fe7351010be6b2d::suimann {
    struct SUIMANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMANN>(arg0, 6, b"SUIMANN", b"SUIMAN", x"5355494d414e204f4e20484953205741590a544f20534156452043525950544f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_202756325_c88d6cb195.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

