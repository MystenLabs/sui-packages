module 0xcfd8ab41ab2d54838543c074adbc5b7092bcbf252b42adf165abb9d522ebdef3::sierra {
    struct SIERRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIERRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIERRA>(arg0, 6, b"SIERRA", b"Sierra", x"4772656574696e677321204d6565747320534945525241206f6e20737569210a4665656c206672656520666173742067726f777468207570210a466173742073656e646f72210a4a6f696e206f757220736f6369616c206166746572204465782075706461746521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241012_040003_e438527cde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIERRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIERRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

