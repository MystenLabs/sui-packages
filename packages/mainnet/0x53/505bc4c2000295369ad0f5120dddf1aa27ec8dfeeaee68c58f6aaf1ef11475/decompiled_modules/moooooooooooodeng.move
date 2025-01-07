module 0x53505bc4c2000295369ad0f5120dddf1aa27ec8dfeeaee68c58f6aaf1ef11475::moooooooooooodeng {
    struct MOOOOOOOOOOOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOOOOOOOOOOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOOOOOOOOOOODENG>(arg0, 0, b"MOOOOOOOOOOOODENG", b"MOOOOOOOOOOOODENG SUI", b"https://t.me/catonapeworld http://catonapeworld.xyz/ https://x.com/catonapeworld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOOOOOOOOOOOODENG>(&mut v2, 669856985412, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOOOOOOOOOOODENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOOOOOOOOOOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

