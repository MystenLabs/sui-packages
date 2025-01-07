module 0x2cb4fbc886210c390fd8c8baec6fbc9ea47f2129b11a6214af9b058679b12b66::sardine {
    struct SARDINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARDINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARDINE>(arg0, 6, b"SARDINE", b"SUI SARIDINE", b"Sardines symbolize unity, and were about to turn $SASA into something huge. Welcome to the Sardine Era, are you ready to ride the hype wave?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISARDENE_797285182a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARDINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARDINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

