module 0x288ff4ef76fa9f060cffc109c752d966bcc9901cabc710bf62e139660e35d767::b_deep {
    struct B_DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DEEP>(arg0, 6, b"B DEEP", b"BLue Deep", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<B_DEEP>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B_DEEP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<B_DEEP>>(v2);
    }

    // decompiled from Move bytecode v6
}

