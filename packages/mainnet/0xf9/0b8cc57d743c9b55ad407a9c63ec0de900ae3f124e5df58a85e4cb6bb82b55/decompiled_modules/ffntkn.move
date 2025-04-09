module 0xf90b8cc57d743c9b55ad407a9c63ec0de900ae3f124e5df58a85e4cb6bb82b55::ffntkn {
    struct FFNTKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFNTKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFNTKN>(arg0, 9, b"FFNTKN", b"forfuntoken", b"for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/19c9622f99f2f87d2e8803757c8c8a3dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFNTKN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFNTKN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

