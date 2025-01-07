module 0x638ff2a97105dc0b51a04c0a137c003f900cd6b9884f9795858cb0f7aaf8aa83::blup {
    struct BLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUP>(arg0, 6, b"BLUP", b"Blue Pirate Pepe", b"He is Blue, He is pirate and he is Pepe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730614951387.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

