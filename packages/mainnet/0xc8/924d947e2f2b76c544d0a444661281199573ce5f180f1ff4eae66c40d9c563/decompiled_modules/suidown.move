module 0xc8924d947e2f2b76c544d0a444661281199573ce5f180f1ff4eae66c40d9c563::suidown {
    struct SUIDOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOWN>(arg0, 6, b"SUIDOWN", b"WE WRESTLE EVERYTHING", b"WWE inspired Token we're SUI TOKEN joined in SMACKDOWN/SUIDOWN and ROYAL RUMBLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib6s3k73qgjksbciaokpy7nk2z47ycdlu5vhenqrbax3j22qm34ue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDOWN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

