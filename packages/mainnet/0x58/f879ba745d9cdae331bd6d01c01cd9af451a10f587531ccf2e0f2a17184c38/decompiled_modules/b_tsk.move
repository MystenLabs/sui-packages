module 0x58f879ba745d9cdae331bd6d01c01cd9af451a10f587531ccf2e0f2a17184c38::b_tsk {
    struct B_TSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TSK>(arg0, 9, b"bTSK", b"bToken TSK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

