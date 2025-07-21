module 0x925e586fd7564320c705c1040e6954b5f08a7ee1c8043620ae043f7e60493e25::mindi {
    struct MINDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINDI>(arg0, 6, b"MINDI", b"Mindi Coin", b"A minimal Mindi coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MINDI>>(0x2::coin::mint<MINDI>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINDI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

