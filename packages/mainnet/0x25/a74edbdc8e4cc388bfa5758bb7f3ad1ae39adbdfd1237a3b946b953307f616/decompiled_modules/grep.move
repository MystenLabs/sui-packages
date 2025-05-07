module 0x25a74edbdc8e4cc388bfa5758bb7f3ad1ae39adbdfd1237a3b946b953307f616::grep {
    struct GREP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREP>(arg0, 6, b"GREP", b"GiveRep", b"The reputation must follow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifeqrh3jq2eptbd23wk2w36ukiipjziaxrcpnhr267en2pmowk2ai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GREP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

