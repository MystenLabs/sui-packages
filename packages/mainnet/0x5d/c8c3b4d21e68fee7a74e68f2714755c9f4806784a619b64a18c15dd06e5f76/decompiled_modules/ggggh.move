module 0x5dc8c3b4d21e68fee7a74e68f2714755c9f4806784a619b64a18c15dd06e5f76::ggggh {
    struct GGGGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGGGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGGGH>(arg0, 6, b"Ggggh", b"ggggg", b"fgggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_20_23_26_fd7d51b972.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGGGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGGGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

