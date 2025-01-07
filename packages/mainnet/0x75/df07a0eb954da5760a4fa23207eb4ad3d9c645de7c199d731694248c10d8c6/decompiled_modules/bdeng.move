module 0x75df07a0eb954da5760a4fa23207eb4ad3d9c645de7c199d731694248c10d8c6::bdeng {
    struct BDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDENG>(arg0, 6, b"Bdeng", b"Baby Moo deng", b"Baby Moondeng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1039_772436929f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

