module 0x9b85eb5eda25014b903811545143ca131001c5d450879f967005b3a1f7fdd2e1::kingai {
    struct KINGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGAI>(arg0, 6, b"KINGAI", b"King of AI", b"Please dive in Sui world!. KingAI introduce you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZjLC3g5jHhit8cwyZBSS5c9b78X5KSZtn8tXi8MDRffF")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINGAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

