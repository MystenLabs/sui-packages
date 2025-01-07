module 0x97249f6db093e26022989605aa6062ebd2370a65eb174c7f5bcc105fc542f19b::fsonic {
    struct FSONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSONIC>(arg0, 6, b"FSONIC", b"FSONIC SUI", b"fSONIC is a MEME based project that is designed to empower SUI ecosystem by boosting NFT and Defi sector.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x05e31a691405d06708a355c029599c12d5da8b28_30b7914699.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

