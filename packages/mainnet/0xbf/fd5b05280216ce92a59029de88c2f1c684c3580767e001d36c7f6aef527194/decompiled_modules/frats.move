module 0xbffd5b05280216ce92a59029de88c2f1c684c3580767e001d36c7f6aef527194::frats {
    struct FRATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRATS>(arg0, 6, b"FRATS", b"Effinrats SUI", x"4a6f696e206f757220726174207061636b20666f722061206d656d65207265766f6c7574696f6e207468617427730a616e797468696e6720627574206368656573792120596f75747562653a2068747470733a2f2f7777772e796f75747562652e636f6d2f77617463683f763d7a5756614834372d674f63", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/80_73a111ef17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

