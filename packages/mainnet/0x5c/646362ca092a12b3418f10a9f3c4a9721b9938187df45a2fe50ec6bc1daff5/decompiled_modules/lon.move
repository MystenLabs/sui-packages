module 0x5c646362ca092a12b3418f10a9f3c4a9721b9938187df45a2fe50ec6bc1daff5::lon {
    struct LON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LON>(arg0, 6, b"LON", b"Suilon", b"420 Vibes on SUI, LFG ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734549993513.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

