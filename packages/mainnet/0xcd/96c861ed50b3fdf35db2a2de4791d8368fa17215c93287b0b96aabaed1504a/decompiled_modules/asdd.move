module 0xcd96c861ed50b3fdf35db2a2de4791d8368fa17215c93287b0b96aabaed1504a::asdd {
    struct ASDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDD>(arg0, 6, b"Asdd", b"Asd", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735744114262.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

