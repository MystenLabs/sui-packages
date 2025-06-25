module 0xe99b95766f0324a5fc93953360154f85c0b41ccbf11f853716d0b402998f14ea::reddo {
    struct REDDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDDO>(arg0, 6, b"REDDO", b"RED BOY", b"RED BOY CONQUER SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr3vmvte3fso3em65fsfra2fvzl4a7x3boabz63uluh3tgyhb6ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REDDO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

