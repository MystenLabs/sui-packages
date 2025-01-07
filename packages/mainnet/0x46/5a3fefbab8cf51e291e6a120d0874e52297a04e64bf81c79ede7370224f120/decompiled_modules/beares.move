module 0x465a3fefbab8cf51e291e6a120d0874e52297a04e64bf81c79ede7370224f120::beares {
    struct BEARES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARES>(arg0, 6, b"BEARES", b"bearres", b"BEAR BEAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731150393576.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEARES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

