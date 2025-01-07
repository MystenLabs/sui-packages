module 0xfe974032895641ef1210ba790f31d81437f777fe0164f891da8b8e0fd8568b22::subao {
    struct SUBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBAO>(arg0, 6, b"SUBAO", b"Subao", b"Meet Asias most loved Fu Bao at Sui Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_21_34_35_5b23ad07fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

