module 0x6fbb1b7d730ef15da254559ba7094e67ed021d41e9a25b5153fa9bf0b3a94677::hcat {
    struct HCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAT>(arg0, 6, b"HCAT", b"House Cat", b"Say Hello to House Cat Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif4iegmhr4s4d6walivpcgzvkdj2felx4vvpoy3eavrdz75r5h5iu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

