module 0x8af3b22ff761e5ee899377bf932f34745985c1e64426736cfd70789fab044527::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 6, b"ROBOT", b"MIQUELA", b" 21-year-old Robot living in LA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045104_d58912c2eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

