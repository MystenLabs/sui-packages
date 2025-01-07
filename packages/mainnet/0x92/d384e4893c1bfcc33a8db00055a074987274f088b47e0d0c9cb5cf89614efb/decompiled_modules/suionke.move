module 0x92d384e4893c1bfcc33a8db00055a074987274f088b47e0d0c9cb5cf89614efb::suionke {
    struct SUIONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONKE>(arg0, 6, b"SUIONKE", b"SuiPONKE", b"Suiponke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_01_59_37_a0dd888a96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

