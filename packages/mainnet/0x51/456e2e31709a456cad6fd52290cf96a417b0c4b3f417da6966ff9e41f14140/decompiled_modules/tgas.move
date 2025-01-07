module 0x51456e2e31709a456cad6fd52290cf96a417b0c4b3f417da6966ff9e41f14140::tgas {
    struct TGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGAS>(arg0, 6, b"TGAS", b"Tear Gas Daddy", b"The hardest man on earth, a beacon of the peoples' might", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0545_bfd0364775.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

