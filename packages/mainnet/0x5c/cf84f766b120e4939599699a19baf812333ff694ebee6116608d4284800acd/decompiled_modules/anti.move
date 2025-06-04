module 0x5ccf84f766b120e4939599699a19baf812333ff694ebee6116608d4284800acd::anti {
    struct ANTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTI>(arg0, 6, b"ANTI", b"antiSOCIAL(test do not buy)", b"(test do not buy)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib7clcffnlsifwyiafxy6ihyavemeokg3jsrcq2zsqmyptvjzn72u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANTI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

