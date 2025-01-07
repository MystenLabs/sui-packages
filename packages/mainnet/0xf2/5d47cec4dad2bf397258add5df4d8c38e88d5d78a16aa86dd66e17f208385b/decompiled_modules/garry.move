module 0xf25d47cec4dad2bf397258add5df4d8c38e88d5d78a16aa86dd66e17f208385b::garry {
    struct GARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARRY>(arg0, 6, b"GARRY", b"Just A Chill Garry", b"Just a chill and relaxed Garry smoking weed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732265492337.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

