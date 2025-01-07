module 0x3e9db84597fba86e50ae00223f18c0a82e2b5d00dd8d948ae0e76f5deaff4044::chilly {
    struct CHILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLY>(arg0, 6, b"Chilly", b"Chilly the Snowman", b"Chilly the Snowman, very chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chilly_c0a7d1699e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

