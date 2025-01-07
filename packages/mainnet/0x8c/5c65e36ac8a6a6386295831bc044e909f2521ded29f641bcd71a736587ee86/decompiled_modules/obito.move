module 0x8c5c65e36ac8a6a6386295831bc044e909f2521ded29f641bcd71a736587ee86::obito {
    struct OBITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBITO>(arg0, 9, b"OBITO", b"Without u, the world is nothing", b"Mat em, the gioi trong toi tro nen vo nghia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fc11f4a61c66171f0b7d621cce39647dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBITO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBITO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

