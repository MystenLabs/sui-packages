module 0x3c64381ccbfef0c9818942e03a3a8065a177faa7cd580bb019e167052dc6e03e::yapy {
    struct YAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAPY>(arg0, 6, b"YAPY", b"YAPYYAPY", b"YAPI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yapy_7084b9a089.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

