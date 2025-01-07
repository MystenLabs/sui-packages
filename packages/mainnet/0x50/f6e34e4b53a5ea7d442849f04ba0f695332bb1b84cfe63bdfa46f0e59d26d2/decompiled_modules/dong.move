module 0x50f6e34e4b53a5ea7d442849f04ba0f695332bb1b84cfe63bdfa46f0e59d26d2::dong {
    struct DONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONG>(arg0, 6, b"Dong", b"bingdong", b"hello test ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973934108.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

