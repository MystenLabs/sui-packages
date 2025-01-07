module 0xf1f460f3cfcbd4e540b55b42753d88ee22fe30817757f5e2d0457f29401cdfb0::infi {
    struct INFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFI>(arg0, 6, b"INFI", b"Infinia AI", b"Explore Infinite Possibilities with Infinia AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736246143566.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

