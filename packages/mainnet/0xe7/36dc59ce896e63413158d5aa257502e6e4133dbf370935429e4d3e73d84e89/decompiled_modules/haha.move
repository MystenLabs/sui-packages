module 0xe736dc59ce896e63413158d5aa257502e6e4133dbf370935429e4d3e73d84e89::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 9, b"haha", b"haha", b"haha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"haha")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAHA>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAHA>>(v2);
    }

    // decompiled from Move bytecode v6
}

