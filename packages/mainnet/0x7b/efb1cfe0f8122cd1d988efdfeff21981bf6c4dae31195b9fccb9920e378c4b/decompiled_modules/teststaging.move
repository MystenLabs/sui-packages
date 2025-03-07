module 0x7befb1cfe0f8122cd1d988efdfeff21981bf6c4dae31195b9fccb9920e378c4b::teststaging {
    struct TESTSTAGING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSTAGING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741361598071.png"));
        let (v1, v2) = 0x2::coin::create_currency<TESTSTAGING>(arg0, 6, b"staging", b"testStaging", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSTAGING>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTSTAGING>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TESTSTAGING>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TESTSTAGING>>(arg0);
    }

    // decompiled from Move bytecode v6
}

