module 0x85223e392d39490c4fe5afb1c8f5de2f68ee041e687f4a76c5630ecddc7a25f3::meteor {
    struct METEOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: METEOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METEOR>(arg0, 6, b"METEOR", b"Meteor", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<METEOR>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METEOR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<METEOR>>(v2);
    }

    // decompiled from Move bytecode v6
}

