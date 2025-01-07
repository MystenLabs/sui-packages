module 0x5bf44d74e9e39214e28b7c60bc6cdd4d85556c9b455e3a8f49c444e1f32473d7::truth {
    struct TRUTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUTH>(arg0, 9, b"TRUTH", x"5472757468205465726d696e616ce280997320317374205477656574", b"Twitter : https://x.com/truth_terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1808816849620250625/AQIUpfL3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUTH>(&mut v2, 450000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUTH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

