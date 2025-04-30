module 0xb9fc3348564e95f9cf1173f24a54a0712801c9f4b828b09bec3483bcba56bbf2::snow {
    struct SNOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOW>(arg0, 6, b"SNOW", b"snowman", b"snowman coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snowman_5a93295db5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

