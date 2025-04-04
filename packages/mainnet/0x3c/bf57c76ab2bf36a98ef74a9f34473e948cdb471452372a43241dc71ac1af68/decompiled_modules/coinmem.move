module 0x3cbf57c76ab2bf36a98ef74a9f34473e948cdb471452372a43241dc71ac1af68::coinmem {
    struct COINMEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINMEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINMEM>(arg0, 9, b"COINMEM", b"Coin", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/23e894232bbda2d3f28e09b106b61a9dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINMEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINMEM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

