module 0x15d76b59ffc38568fe7768ce4797814e6e45f09aad62b2d05c890e317bea09ff::sgk {
    struct SGK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGK>(arg0, 6, b"SGK", b"Suingoku", b"Powered by the lightning speed and efficiency of Sui, were aiming for the top and beyond! This is your chance to join a revolution, take part in an epic journey, and watch Suingoku break boundaries in the crypto space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_14_45_04_781b133e45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGK>>(v1);
    }

    // decompiled from Move bytecode v6
}

