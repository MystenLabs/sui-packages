module 0x24b1f18c224db4d25bfff9eb8b9c3b8e8ff43980390a9c9176377a5aaa665073::lowiq {
    struct LOWIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOWIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOWIQ>(arg0, 6, b"LowiQ", b"Low iQ", b"The lowest IQ-s on chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_18_4a1e63ad1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOWIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOWIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

