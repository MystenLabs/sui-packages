module 0x870767b7ada2ad7ce7d8f893d854613aefc88d81e12b84121350535997db99ad::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"Whale", b"Whale on Sui", b"Whale Layer is your guide to the Layer 2 Networks. Insights & Infographics, for business: https://t.me/whale_media", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hp_Gpmq_GT_400x400_3de8865a8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

