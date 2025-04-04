module 0x3a97367f8a2f53dda059be00d416871529a8664b37551116fc689360ec820d1::topit {
    struct TOPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPIT>(arg0, 9, b"TOPIT", b"Top", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/29738aa386ffd8b4b2c3f60fc08ea141blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOPIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

