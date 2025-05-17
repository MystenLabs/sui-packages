module 0x192a002d082897dc31c17202c354f41a7ef179f44b644284c4cf47a4a396095e::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLY>(arg0, 9, b"WALLY", b"WALLIKA", b"SUPERHEROE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6fb763e1cd00408883fce23ee990843cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

