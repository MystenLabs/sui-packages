module 0x186d0f392a2da0fec994f659f436f51022c20db9ee25e7e7690b015cee9f5627::fdoge {
    struct FDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDOGE>(arg0, 9, b"FDOGE", b"FUNDOGE", b"FUN DOGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b301dfa97e19ff98c9d3c53a6d2944d6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

