module 0xd3212f509658f1373cd0b221fc22ee23a636b98c2be2291c6cf3ee18ba39323d::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 9, b"ACT", b"Act I : The AI Prophecy", b"Act I : The AI Prophecy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/GJAFwWjJ3vnTsrQVabjBVK2TYB1YtRCQXRDfDgUnpump.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

