module 0x5869af0bb92fb24eaac771cb67ac326e48ad7dd414c6ad0ab263a7a688a3bc2::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"LORD KATT", x"4c4f52442d4b4154542d504f5745525a2d594f55522d4b525950544f56455253530a6c69676874656e696e672d6361742d6c696768746e696e672d73746f726d20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731106353386.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

