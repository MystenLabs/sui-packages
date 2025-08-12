module 0x42f39163e10a3ee86a1f56816025c3a7b4f4042195de5a38a4d81171a3c0911b::pee {
    struct PEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEE>(arg0, 6, b"PEE", b"Peecoin", b"$PEE - My stream goes down, but your portfolio goes up, Peecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiao5lfmxxshoylu366dktntvbcbdt4tabeg6cxrtaasy7tpef3w6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

