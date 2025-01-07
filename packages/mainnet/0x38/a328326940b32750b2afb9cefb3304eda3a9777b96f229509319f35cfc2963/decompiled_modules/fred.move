module 0x38a328326940b32750b2afb9cefb3304eda3a9777b96f229509319f35cfc2963::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"Fred", b"FredThePlatypus", b"Fred The Platypus (Official)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989197217.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

