module 0xc0267262a91ba1ee4df2588fb0f22f8867f4c1b22fb6d44a5fbe2995dd11c0a6::baj {
    struct BAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAJ>(arg0, 6, b"BAJ", b"Buddha and Jesus", b"Different beliefs, one friendship. We are all united as friends!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0819_5aed569494.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

