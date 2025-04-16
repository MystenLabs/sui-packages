module 0x57ff406799aeb894cb6e44b2e21ba3d32db685b8ace3417f0833f51cedb260ab::mdogg {
    struct MDOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDOGG>(arg0, 6, b"MDOGG", b"MBR DOG", b"MDOGG for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MDOGG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

