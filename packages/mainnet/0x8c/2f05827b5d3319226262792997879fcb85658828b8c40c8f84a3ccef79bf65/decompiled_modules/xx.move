module 0x8c2f05827b5d3319226262792997879fcb85658828b8c40c8f84a3ccef79bf65::xx {
    struct XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XX>(arg0, 9, b"xx", b"xx", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XX>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

