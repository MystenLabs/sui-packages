module 0x673a7e5dfa67da26a38ac38c8326b0192b03a962c5625158a87236d29d562a61::tugo {
    struct TUGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUGO>(arg0, 5, b"TUGO", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUGO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUGO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

