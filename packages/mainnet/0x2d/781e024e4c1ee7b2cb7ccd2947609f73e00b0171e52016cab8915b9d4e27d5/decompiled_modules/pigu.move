module 0x2d781e024e4c1ee7b2cb7ccd2947609f73e00b0171e52016cab8915b9d4e27d5::pigu {
    struct PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGU>(arg0, 6, b"PIGU", b"PIGU on SUI", x"4865277320436c756d73792c20436865656b792026204372756973696e67207468726f7567682053756920f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730983185318.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

