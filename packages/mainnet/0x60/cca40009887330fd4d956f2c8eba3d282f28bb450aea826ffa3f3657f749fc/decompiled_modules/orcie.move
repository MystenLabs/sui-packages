module 0x60cca40009887330fd4d956f2c8eba3d282f28bb450aea826ffa3f3657f749fc::orcie {
    struct ORCIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCIE>(arg0, 6, b"Orcie", b"OrcieonSui", b"Welcome to Orcie on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731192671310.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

