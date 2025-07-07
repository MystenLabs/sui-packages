module 0x8b3ddb0da6342e36d5423733cd0cdce5724f0d04601aaad3bff241975c23af88::lpt {
    struct LPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPT>(arg0, 9, b"LPT", b"7K Dex LP Token", b"The LPT token secures the 7K Dex protocol.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

