module 0x2a6166760273e0e40f4499eda63770c211d0f532dec1dc7b970e92159bba03a::float {
    struct FLOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOAT>(arg0, 6, b"FLOAT", b"Float", b"FLOA is a viral social-financial experiment blending memecoins, NFTs, and user-generated content into a community-driven movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091417_acbf392ae5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

