module 0x49058445aca43b573a4848f39201d4889542038365fcecd2140edb5918f8db13::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 9, b"KAI", b"Official Kai On Sui", b"Official Kai Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVw756vRNAVM4sKucbo6tB7EKTHjeMpcCJH3uMjp781ek")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

