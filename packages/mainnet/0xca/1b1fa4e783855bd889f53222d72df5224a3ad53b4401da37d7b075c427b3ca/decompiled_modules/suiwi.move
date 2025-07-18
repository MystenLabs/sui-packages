module 0xca1b1fa4e783855bd889f53222d72df5224a3ad53b4401da37d7b075c427b3ca::suiwi {
    struct SUIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIWI>(arg0, 6, b"SUIWI", b"Suiwi", b"Only Green candles for this Kiwi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/compressed_kiwi_cartoon_f70e5d1742.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

