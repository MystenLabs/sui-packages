module 0x554c06c728ee3990e4fa4bb8fdfdca2447e512e3591fa1692c95b95a27da603d::htsdgs {
    struct HTSDGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTSDGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTSDGS>(arg0, 6, b"HTSDGS", b"HottusDoggus", b"HOTTEST DOG AROUND ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744460654710.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTSDGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTSDGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

