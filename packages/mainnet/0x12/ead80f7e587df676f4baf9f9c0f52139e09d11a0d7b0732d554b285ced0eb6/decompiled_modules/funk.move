module 0x12ead80f7e587df676f4baf9f9c0f52139e09d11a0d7b0732d554b285ced0eb6::funk {
    struct FUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNK>(arg0, 9, b"FUNK", b"FUNFUN K", b"dfef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7b54f0e4d83f512dc5d2eb5f77b207f3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

