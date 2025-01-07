module 0xbce2162f7ec489d6c0467fc58fa2d3012f5edf977b3b41f565b0c9d6243ba04f::anti {
    struct ANTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTI>(arg0, 9, b"ANTI", b"Antitoken", b"Antitoken is the negatively [-] charged token of the Quantum Tokenomics Model", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeFsV4Yiod2gDDwKwxijn4rV25ViQo8hNCdiU9CwbVanK")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

