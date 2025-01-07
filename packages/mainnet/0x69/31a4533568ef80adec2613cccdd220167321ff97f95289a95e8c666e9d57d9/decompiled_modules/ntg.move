module 0x6931a4533568ef80adec2613cccdd220167321ff97f95289a95e8c666e9d57d9::ntg {
    struct NTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTG>(arg0, 6, b"NTG", b"Nothing", x"5765206a75737420537461727420466f72204e6f7468696e670a416c77617973204e6f7468696e67200a4e6f7468696e67204973204e6f7468696e67200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_4805c8506b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

