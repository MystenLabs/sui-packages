module 0x96603003b6911a90e75a307ec700e42b8f5c76c74b66c043e1eba3e6b0fee7c8::lsgg {
    struct LSGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSGG>(arg0, 9, b"Lsgg", b"mainstream  ", b"mainstream", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f75935438a901c4244bce30dcfefdc7cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LSGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

