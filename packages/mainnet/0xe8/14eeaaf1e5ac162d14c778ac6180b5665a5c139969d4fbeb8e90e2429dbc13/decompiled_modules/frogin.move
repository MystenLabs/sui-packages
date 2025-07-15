module 0xe814eeaaf1e5ac162d14c778ac6180b5665a5c139969d4fbeb8e90e2429dbc13::frogin {
    struct FROGIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGIN>(arg0, 6, b"FROGIN", b"FROG IN", b"Frog / In", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752537500278.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

