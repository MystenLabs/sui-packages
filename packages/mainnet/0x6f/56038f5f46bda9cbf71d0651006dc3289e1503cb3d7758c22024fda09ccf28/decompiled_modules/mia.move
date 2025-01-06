module 0x6f56038f5f46bda9cbf71d0651006dc3289e1503cb3d7758c22024fda09ccf28::mia {
    struct MIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIA>(arg0, 6, b"MIA", b"Meme Insight Analyzer", b"Mia: The first AI meme analyzer on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/svg_564f1b71ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

