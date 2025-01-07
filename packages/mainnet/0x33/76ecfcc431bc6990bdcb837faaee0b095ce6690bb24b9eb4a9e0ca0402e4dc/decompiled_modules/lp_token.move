module 0x3376ecfcc431bc6990bdcb837faaee0b095ce6690bb24b9eb4a9e0ca0402e4dc::lp_token {
    struct LP_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP_TOKEN>(arg0, 10, b"LP_TOKEN", b"lpcoin", b"lp coin desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LP_TOKEN>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_TOKEN>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LP_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

