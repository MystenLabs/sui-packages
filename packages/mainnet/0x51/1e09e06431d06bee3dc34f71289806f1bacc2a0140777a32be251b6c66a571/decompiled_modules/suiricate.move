module 0x511e09e06431d06bee3dc34f71289806f1bacc2a0140777a32be251b6c66a571::suiricate {
    struct SUIRICATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRICATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRICATE>(arg0, 6, b"SUIRICATE", b"Suiricate", b"Suiricate cutest animal on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bildschirmfoto_2024_09_27_um_18_22_53_0975628ab4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRICATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRICATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

