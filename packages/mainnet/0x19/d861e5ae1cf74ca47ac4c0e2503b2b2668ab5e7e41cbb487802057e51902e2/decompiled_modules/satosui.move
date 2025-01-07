module 0x19d861e5ae1cf74ca47ac4c0e2503b2b2668ab5e7e41cbb487802057e51902e2::satosui {
    struct SATOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSUI>(arg0, 6, b"Satosui", b"Peter Todd", b"Peter TOLD BTC HBO  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sadasdas_b62c4c64cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

