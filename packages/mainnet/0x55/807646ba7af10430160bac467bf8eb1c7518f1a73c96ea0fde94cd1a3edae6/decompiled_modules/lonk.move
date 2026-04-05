module 0x55807646ba7af10430160bac467bf8eb1c7518f1a73c96ea0fde94cd1a3edae6::lonk {
    struct LONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONK>(arg0, 9, b"LONK", b"Baby Lonk", b"Baby Lonk Token on Sui - Community Driven", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LONK>>(0x2::coin::mint<LONK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LONK>>(v2);
    }

    // decompiled from Move bytecode v7
}

