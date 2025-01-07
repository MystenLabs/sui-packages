module 0x20850a618d2f55c5009f18009d830474a637cd6223131eee08f3c63b53376811::oiia {
    struct OIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIA>(arg0, 6, b"OIIA", b"Oiia ", b"OIIA OIIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735980574887.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OIIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

