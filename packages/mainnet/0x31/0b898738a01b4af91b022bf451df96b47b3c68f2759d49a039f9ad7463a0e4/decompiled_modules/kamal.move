module 0x310b898738a01b4af91b022bf451df96b47b3c68f2759d49a039f9ad7463a0e4::kamal {
    struct KAMAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMAL>(arg0, 6, b"Kamal", b"KAMAL COIN ", b"R668di5w6y9jcufufkhp dufu ufigo dugi ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1763756586455.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

