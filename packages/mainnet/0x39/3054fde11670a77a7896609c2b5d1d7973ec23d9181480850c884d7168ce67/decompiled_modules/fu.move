module 0x393054fde11670a77a7896609c2b5d1d7973ec23d9181480850c884d7168ce67::fu {
    struct FU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FU>(arg0, 6, b"FU", b"SuiFu", b"Master the Sui Network with precision and power. Unleash your inner warrior spirit and kickstart a journey of action-packed growth. Join the force!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihc2wlb2ntuxhaldc72m4oidcoqf6o4lsje5fd4t5q67klaggv2rm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

