module 0xf92ab41641a33f3ce7e687965725cdebed88ff0de633109d05f7f0ea950ffabc::tstl {
    struct TSTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTL>(arg0, 6, b"TSTL", b"TST Lock Token", b"Fake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

