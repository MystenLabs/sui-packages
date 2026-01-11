module 0x1da8c11f898a64ec44d4db7f9eaabacea7bfd89cacc2fb670cc4198fd3de0769::age21 {
    struct AGE21 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGE21, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGE21>(arg0, 6, b"AGE21", b"21 Years Old", b"The legendary Japanese meme \"21 Years Old\" has finally arrived on-chain. Celebrate the eternal 21st birthday on Pump.fun. It's not just a number; it's a lifestyle. I'm 21 years old. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1768108844908.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGE21>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGE21>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

