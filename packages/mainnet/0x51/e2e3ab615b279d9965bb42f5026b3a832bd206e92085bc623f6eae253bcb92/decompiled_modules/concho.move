module 0x51e2e3ab615b279d9965bb42f5026b3a832bd206e92085bc623f6eae253bcb92::concho {
    struct CONCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONCHO>(arg0, 9, b"CONCHO", b"hispanic pepe", b"the original hispanic pepe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXUUwfsa8xusoybFRuiPssPhEsRRwjbbTdF4qKMuQrL3u")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CONCHO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONCHO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONCHO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

