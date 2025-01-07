module 0xae7b61c5ac1f0fc6a1fc3c89702ede46e517ca0c24e3f0ba3adcab880229d5d3::shb {
    struct SHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHB>(arg0, 6, b"SHB", b"Shiba SUI", b"A playful fusion of Shiba Inu charm and sushi delight. A meme coin that's both fun and flavorful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/anh_cho_meme_yody_vn8_df972ad915.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHB>>(v1);
    }

    // decompiled from Move bytecode v6
}

