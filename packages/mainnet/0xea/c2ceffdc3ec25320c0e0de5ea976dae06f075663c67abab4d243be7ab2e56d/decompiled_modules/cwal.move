module 0xeac2ceffdc3ec25320c0e0de5ea976dae06f075663c67abab4d243be7ab2e56d::cwal {
    struct CWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWAL>(arg0, 9, b"CWAL", b"Chill Walrus", b"Chill Walrus... WAL WAL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/00058aeac90db284c28f31e8337cf605blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

