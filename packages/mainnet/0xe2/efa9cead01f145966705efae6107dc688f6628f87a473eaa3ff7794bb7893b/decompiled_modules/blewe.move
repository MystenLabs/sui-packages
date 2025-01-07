module 0xe2efa9cead01f145966705efae6107dc688f6628f87a473eaa3ff7794bb7893b::blewe {
    struct BLEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEWE>(arg0, 6, b"BLEWE", b"The gones blewe", b"BLEWE is laid back and carefree living in a whimsical world, embodying the playful and surreal essence of the book Mindviscosity. Published in 2020 by renowned artist Matt Furie. BLEWE's relaxed and adventurous spirit captures the heart of this imaginative universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048549_950f21cd6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

