module 0xe7453e5e81b403354e1d4ed758a595a6c708929f8722386b7eb1d1b2b757c551::flog {
    struct FLOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOG>(arg0, 6, b"FLOG", b"Sui Flog", b"Not just meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960656263.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

