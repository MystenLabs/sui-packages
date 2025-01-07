module 0xdb95c8901dee004878b2d75be066f7fe8b86f75d2b00266cec54fb4f78643a2::boi {
    struct BOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOI>(arg0, 6, b"BOI", b"BOI ON SUI", b"good boi for $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956478141.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

