module 0x4ef5aad15f71e36566f8d42e9ebc5e879caa6e2302339770c84bd04e8de69b68::badape {
    struct BADAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADAPE>(arg0, 6, b"BADAPE", b"BAD APE", b"https://chatgpt.com/c/678a9a9a-a434-8000-a8a5-093a800d3ef2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737137605640.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADAPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

