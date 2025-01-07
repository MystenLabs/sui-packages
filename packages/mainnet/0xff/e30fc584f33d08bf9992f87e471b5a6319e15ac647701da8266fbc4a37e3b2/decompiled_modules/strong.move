module 0xffe30fc584f33d08bf9992f87e471b5a6319e15ac647701da8266fbc4a37e3b2::strong {
    struct STRONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRONG>(arg0, 6, b"STRONG", b"Strong Cat", b"Defenetly the strongest cat on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Stronk_Cat_4f192adbca.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

