module 0x46e7ca2957a84f5420fcd3ca41ffa76d8641192fd5462802cbdc3ba72fd1bd21::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAN>(arg0, 6, b"BAN", b"banana", b"Elon Musk's favorite motif , Peanut Butter Jelly Time!!! which appears on his cars and rockets as a symbol of freedom and distance, is sure to be loved by Musk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7898_6b602f7822.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

