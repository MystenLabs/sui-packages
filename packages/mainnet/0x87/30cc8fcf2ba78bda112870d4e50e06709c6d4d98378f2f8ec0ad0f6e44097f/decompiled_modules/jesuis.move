module 0x8730cc8fcf2ba78bda112870d4e50e06709c6d4d98378f2f8ec0ad0f6e44097f::jesuis {
    struct JESUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUIS>(arg0, 6, b"Jesuis", b"TheJesuisChrist", b"May you find rest, healing, and the light of God as you walk these sacred streets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jesuis_pfp_7f8a11247e_df156e7cd1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

