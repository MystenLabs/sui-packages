module 0xeeb28f1b91e78e75e9ff5184e7c52a3b87e4da763006d9cfa4455f404abf6697::damasco {
    struct DAMASCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAMASCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAMASCO>(arg0, 6, b"Damasco", b"SUI DAMASCO AI", b"My first project!!! LFG $Damasco", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul82_20250112013851_5a208dcfc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAMASCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAMASCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

