module 0x51ad84a7504cb5487190c237d71a21f3a72a7c94a231c0941ce4ed0ab8788a7a::gcob {
    struct GCOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCOB>(arg0, 9, b"GCOB", b"cobold green", b"green cobold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b4f9616c00ca1c53d1a3027eb4036557blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

