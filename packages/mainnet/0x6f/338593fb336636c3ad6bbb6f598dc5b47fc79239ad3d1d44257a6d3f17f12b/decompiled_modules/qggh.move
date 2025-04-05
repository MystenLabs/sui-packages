module 0x6f338593fb336636c3ad6bbb6f598dc5b47fc79239ad3d1d44257a6d3f17f12b::qggh {
    struct QGGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: QGGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QGGH>(arg0, 9, b"Qggh", b"jyjyjhg", b"tyhjdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c1a3f9059d5bca2b5f3917a606efd96bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QGGH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QGGH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

