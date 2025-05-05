module 0xc4e733e412d6b259253c010e70afc6c4cbfeab1f077879579fefff577868964::NOO {
    struct NOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOO>(arg0, 6, b"NOO", b"Noo La Polizia", b"Noo... la polizia... not tralalelo tralala...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmeTCXXmTMAbAcKwy1dgKqHhnnbHVUg1tiK3C2dFnjSi1c")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

