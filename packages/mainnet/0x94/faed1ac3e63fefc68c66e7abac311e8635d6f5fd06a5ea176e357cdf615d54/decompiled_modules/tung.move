module 0x94faed1ac3e63fefc68c66e7abac311e8635d6f5fd06a5ea176e357cdf615d54::tung {
    struct TUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNG>(arg0, 9, b"TUNG", b"Tungtung sui", b"Anomali tung tung ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4cf8c361a32e17bb9e2291976832eca0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

