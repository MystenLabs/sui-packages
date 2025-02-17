module 0x527f8d9190114dd45b8074605a68666495d09b1bb86b957412bce6f08c785612::dood {
    struct DOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOD>(arg0, 9, b"DOOD", b"doodles", b"the creative revolution is here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYQK7spb5CchQM5NQTBHmHhq1dTtRcA2Z2sVFVMGtsSVc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOOD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

