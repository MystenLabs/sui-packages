module 0x9690f6eb6adb26a1083c4ed41a74730da2fadbdf5354c6765f23bc291aff8100::catrdio {
    struct CATRDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATRDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATRDIO>(arg0, 6, b"CATRDIO", b"Giga Retardio Cat", b"https://x.com/ctogigacat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_3c5cc1bbf8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATRDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATRDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

