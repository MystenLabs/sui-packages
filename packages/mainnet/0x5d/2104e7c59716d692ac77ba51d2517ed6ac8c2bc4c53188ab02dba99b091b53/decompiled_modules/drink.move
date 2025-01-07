module 0x5d2104e7c59716d692ac77ba51d2517ed6ac8c2bc4c53188ab02dba99b091b53::drink {
    struct DRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRINK>(arg0, 6, b"DRINK", b"DRINKIES", b"DRINK ME!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734199191108.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

