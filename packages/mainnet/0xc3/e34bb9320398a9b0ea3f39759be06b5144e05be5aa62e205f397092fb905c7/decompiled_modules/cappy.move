module 0xc3e34bb9320398a9b0ea3f39759be06b5144e05be5aa62e205f397092fb905c7::cappy {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 9, b"CAPPY", b"SUI CAPPYBARA", x"596f2c206d65657420537569204361707079e28094746865206368696c6c657374206d6173636f74206f6e205375692c2068616e647320646f776e2e20f09fa7a220416c77617973206b656570696ee2809920697420636f6f6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1861363623807098880/nncoebF3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAPPY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPPY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

