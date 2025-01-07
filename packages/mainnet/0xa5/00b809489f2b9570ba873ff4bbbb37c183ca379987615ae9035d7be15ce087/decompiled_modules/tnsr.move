module 0xa500b809489f2b9570ba873ff4bbbb37c183ca379987615ae9035d7be15ce087::tnsr {
    struct TNSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNSR>(arg0, 9, b"TNSR", b"TNSR", b"TNSR", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TNSR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNSR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

