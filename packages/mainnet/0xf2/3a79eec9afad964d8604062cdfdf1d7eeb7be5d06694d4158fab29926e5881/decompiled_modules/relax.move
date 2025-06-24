module 0xf23a79eec9afad964d8604062cdfdf1d7eeb7be5d06694d4158fab29926e5881::relax {
    struct RELAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RELAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RELAX>(arg0, 9, b"RELAX", b"RELAX_COIN", b"RELAX COIN AND HOLDING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/caca0b46ec6067c2f6a4541d51622c8eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RELAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RELAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

