module 0xb2c5c5ed1d232176f94308c3b1ac31a8f52494b8383e0ca93a73c37c4295fdb6::baha {
    struct BAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAHA>(arg0, 6, b"Baha", b"baha ", b"selam ben baha amk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732796472468.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

