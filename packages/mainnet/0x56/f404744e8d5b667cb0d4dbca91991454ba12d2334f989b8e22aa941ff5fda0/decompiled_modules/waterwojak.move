module 0x56f404744e8d5b667cb0d4dbca91991454ba12d2334f989b8e22aa941ff5fda0::waterwojak {
    struct WATERWOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERWOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERWOJAK>(arg0, 6, b"WATERWOJAK", b"Water Wojak", b"Help! Glub, glub...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_13_163244_531f085a1e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERWOJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERWOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

