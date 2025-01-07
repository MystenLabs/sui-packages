module 0xae2ab9e4d9118ce2d054b940298a56b854fa410f26cf072fa7cf9199efe849f6::alwin {
    struct ALWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALWIN>(arg0, 6, b"ALWIN", b"TURBO ALWIN", b"Welcome to Turbo ALWIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956114625.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALWIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALWIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

