module 0xbef9f772f9a1f7e6e188007f6fbf35e3a4d94901451cbb546ad70c30b04f70c0::chillmas {
    struct CHILLMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMAS>(arg0, 6, b"Chillmas", b"ChillXMas", b"Safe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733076044149.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

