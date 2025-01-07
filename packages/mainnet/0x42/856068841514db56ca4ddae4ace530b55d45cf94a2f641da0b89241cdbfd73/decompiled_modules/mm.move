module 0x42856068841514db56ca4ddae4ace530b55d45cf94a2f641da0b89241cdbfd73::mm {
    struct MM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MM>(arg0, 8, b"MM", b"MaritimeMint", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU_mq6MlwVODGJ_u4oJ1kU9d5x-CbvKZkC8tuXjYjb25RnOwRs2MmP0KRWx6wh5oyR0x0&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MM>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MM>>(v1);
    }

    // decompiled from Move bytecode v6
}

