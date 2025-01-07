module 0xba3260694382c57c9f8632043e3613bf6b8d4dc981b238d350db805bab7b2389::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMC>(arg0, 6, b"SMC", b"Ski Mask Cat", b" Hi there, its me   Mask Cat! Once, I was just a tiny, scrappy furball left all alone in the big, scary world. But guess what? I fought back! Now, Im more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020410_7cfba33347.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

