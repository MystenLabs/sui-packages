module 0xbb3d8027a51c76270dfa6eae41b3e1973a8bc7523a76cc1dd0755e70ac1a901e::socialfi {
    struct SOCIALFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCIALFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCIALFI>(arg0, 9, b"SocialFi", b"SocialFi On Sui", b"socialfi is happening", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQAPrfWHGcKeR16yLeAL4ioWci8ose4tBYG5KTbP8NXMU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOCIALFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOCIALFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCIALFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

