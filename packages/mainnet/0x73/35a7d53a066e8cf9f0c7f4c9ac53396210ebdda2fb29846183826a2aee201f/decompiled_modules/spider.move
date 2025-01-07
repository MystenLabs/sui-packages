module 0x7335a7d53a066e8cf9f0c7f4c9ac53396210ebdda2fb29846183826a2aee201f::spider {
    struct SPIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIDER>(arg0, 6, b"SPIDER", b"Blue Tarantula", b"The amazing Cobalt Blue Tarantula, lives in the rainforests of South-East Asia and is ready to devour any other dog, cat or frog MEME character along the SUI and other blockchains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AI_blue_tarantula_cdcacd5352.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

