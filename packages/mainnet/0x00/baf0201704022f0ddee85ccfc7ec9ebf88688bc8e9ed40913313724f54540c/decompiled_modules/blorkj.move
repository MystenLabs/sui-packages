module 0xbaf0201704022f0ddee85ccfc7ec9ebf88688bc8e9ed40913313724f54540c::blorkj {
    struct BLORKJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLORKJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLORKJ>(arg0, 6, b"BlorkJ", b"BlorkJuice", b"Just sipping on that Blork juice ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747769624322.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLORKJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLORKJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

