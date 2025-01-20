module 0xd19a0795a805dfd7057dba4aa98dcc807e3bbfc5aed3e11a94f7360d41ca4408::mlk {
    struct MLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MLK>(arg0, 6, b"MLK", b"MLK AI by SuiAI", b"MLK AI - A Digital Legacy of Hope and Unity..Join us in making history. As Dr. King said, 'We are now faced with the fact that tomorrow is today.'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Martin_c999742131.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MLK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

