module 0xaef0022a9aee36c9e9c83169f8896ad0df837744e02d58a1cd60dba1ecb62c53::suibird {
    struct SUIBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIRD>(arg0, 6, b"SuiBird", b"SuiBirds", b"SuiBirds build on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241004_194553_587_ab5d3d45a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

