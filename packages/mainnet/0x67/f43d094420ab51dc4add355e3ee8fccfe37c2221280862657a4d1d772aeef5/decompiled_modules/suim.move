module 0x67f43d094420ab51dc4add355e3ee8fccfe37c2221280862657a4d1d772aeef5::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 2, b"SUIM", b"Sui Marketing Token", b"Sui Marketing Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIM>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

