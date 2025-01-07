module 0x8c18c6c4875f73fc112c36298124ac66cdee1d93f1a1cb90b19f6fc0958accb::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"Bee On Sui", b"bee coming to sui ,next meme coin will make you more happy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AAAAA_d288de9f6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

