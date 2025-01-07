module 0x5db675ab0f772770c1f64e857f58d4c85b3dcc863a675ca431d34094cbda8ff::acd {
    struct ACD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ACD>(arg0, 6, b"ACD", b"Ascend ", b"Life Guidance .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000007128_d76327b7fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ACD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

