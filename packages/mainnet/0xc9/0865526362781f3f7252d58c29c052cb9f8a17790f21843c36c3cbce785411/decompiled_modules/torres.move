module 0xc90865526362781f3f7252d58c29c052cb9f8a17790f21843c36c3cbce785411::torres {
    struct TORRES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORRES>(arg0, 1, b"TORRES", b"GOAT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TORRES>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORRES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORRES>>(v1);
    }

    // decompiled from Move bytecode v6
}

