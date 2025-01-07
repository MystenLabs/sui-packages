module 0xeba550563b1291462e3a75d1118a876f7b4048ef0f43a13aad8f9399d9a5582c::mewmew {
    struct MEWMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWMEW>(arg0, 6, b"MEWMEW", b"MEWMEW SUI", b"Make-e-Wish O!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_09_35_56_1e77cc525a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWMEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEWMEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

