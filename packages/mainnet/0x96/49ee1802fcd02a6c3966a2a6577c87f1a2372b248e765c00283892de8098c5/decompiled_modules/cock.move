module 0x9649ee1802fcd02a6c3966a2a6577c87f1a2372b248e765c00283892de8098c5::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 6, b"COCK", b"Cocktopus", b"The Destroyer of the Female Organs.. The guy who u were waiting for.. The ONE AND ONLY.. The True KING OF THE SEA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieuhimal6i7rx62t7lkbcyjbtx4333l3iqnev56do7tn2bniwinem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

