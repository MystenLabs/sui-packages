module 0x486e984bdced1b0fbfc96575d0fdda4a6a815cdc43e11a3ed36a414b4e383d71::srvp {
    struct SRVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRVP>(arg0, 9, b"SRVP", b"SERVIPAY", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRVP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRVP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

