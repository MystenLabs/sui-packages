module 0x1030092c11ec3d3b1deb422cab53d572896d090552aa253135c8c7ea7c784652::snail {
    struct SNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAIL>(arg0, 6, b"SNAIL", b"SuiSnail", b"Sui Snail is The muscular snail who loves to work out and the strongest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998141795.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

