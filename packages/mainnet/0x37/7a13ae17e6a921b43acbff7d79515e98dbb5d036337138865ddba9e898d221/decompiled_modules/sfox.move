module 0x377a13ae17e6a921b43acbff7d79515e98dbb5d036337138865ddba9e898d221::sfox {
    struct SFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFOX>(arg0, 6, b"SFOX", b"Fox Spirit", b"Fox spirits and nine-tailed foxes appear frequently in Chinese folklore, literature, and mythology. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958350613.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

