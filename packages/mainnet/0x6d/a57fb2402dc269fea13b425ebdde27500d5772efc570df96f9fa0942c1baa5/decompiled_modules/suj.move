module 0x6da57fb2402dc269fea13b425ebdde27500d5772efc570df96f9fa0942c1baa5::suj {
    struct SUJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUJ>(arg0, 6, b"SUJ", b"SuiJam", b"Lets JAM with SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifnlh44mfrlxt6cz2s5bqueiu57bte3nxbxwc5ugvtbogqojyharq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUJ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

