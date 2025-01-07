module 0x70a13d617ff38b3656bc1fa346e34f716c0adff28ea5ac143545b7df35917010::tugo {
    struct TUGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUGO>(arg0, 5, b"TUGO", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUGO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUGO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

