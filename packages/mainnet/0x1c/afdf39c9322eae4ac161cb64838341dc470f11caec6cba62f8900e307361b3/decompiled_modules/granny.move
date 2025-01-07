module 0x1cafdf39c9322eae4ac161cb64838341dc470f11caec6cba62f8900e307361b3::granny {
    struct GRANNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRANNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRANNY>(arg0, 9, b"Granny", b"Granny", b"Mom of mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRANNY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRANNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRANNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

