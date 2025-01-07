module 0x44c0d08f323e02d84c7d540e26d222da41ad81fc1c4f0974fe2d58525095c37::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 6, b"ONE", b"First One on Sui", b"The First One on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_14_29_00_1024x1024_6d5d547482.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

