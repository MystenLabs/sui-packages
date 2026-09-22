module 0x301ca1b63c283a39c6355de77c2dccb17201c225906d334ab5664801d25c5e9f::tigl {
    struct TIGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGL>(arg0, 9, b"TIGL", b"Tiger Link", b"Tiger Link is a culture-forward meme token channeling monkey mischief for YouTube shorts, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmNSk7GKyVMtFAz9aSR4E9dwXTVWoc6ixSCrKab8Z9D8Aq")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TIGL>>(0x2::coin::mint<TIGL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

