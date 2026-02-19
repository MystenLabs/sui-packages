module 0x96b8c2e5203e9df36d488ea7d4bf7f0064f45a056041fbda72ba0b2cf0a82421::GUSD {
    struct GUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUSD>(arg0, 9, b"GUSD", b"GUSD", b"GUSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

