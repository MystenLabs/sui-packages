module 0x5887a8e13c5ad3d7b3e6634582f0139e622da51cac11b295e869e9bc68896a3d::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 6, b"DERP", b"derpman", b"derpa derpa derpa derpa DERPMAN! derpman.meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OSL_2k5_Bq_400x400_1_3db7fc6e92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

