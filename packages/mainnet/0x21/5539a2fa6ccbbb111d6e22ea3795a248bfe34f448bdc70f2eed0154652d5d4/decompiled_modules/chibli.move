module 0x215539a2fa6ccbbb111d6e22ea3795a248bfe34f448bdc70f2eed0154652d5d4::chibli {
    struct CHIBLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIBLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIBLI>(arg0, 6, b"CHIBLI", b"Chibli", b"Chibli is a big memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052295_6b05d5e751.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIBLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIBLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

