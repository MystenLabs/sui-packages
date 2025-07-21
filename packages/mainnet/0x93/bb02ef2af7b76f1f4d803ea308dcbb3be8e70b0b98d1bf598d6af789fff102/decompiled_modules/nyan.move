module 0x93bb02ef2af7b76f1f4d803ea308dcbb3be8e70b0b98d1bf598d6af789fff102::nyan {
    struct NYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NYAN>(arg0, 6, b"NYAN", b"NYAN", b"@suilaunchcoin $NYAN+ NYAN CAT https://t.co/4RiJZgbalW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/nyan-hit2is.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NYAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

