module 0xce8e53fd677b5bff250e1e11e354e67fa67a4be6acddf6f3bd2385ad583b6ca3::lilbuz {
    struct LILBUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILBUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILBUZ>(arg0, 6, b"LILBUZ", b"LILI BUZZ", b"Buzz-tacular lineup for the hive! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027699_4e37277e54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILBUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILBUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

