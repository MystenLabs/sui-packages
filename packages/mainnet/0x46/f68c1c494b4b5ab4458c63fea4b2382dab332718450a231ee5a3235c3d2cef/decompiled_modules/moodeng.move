module 0x46f68c1c494b4b5ab4458c63fea4b2382dab332718450a231ee5a3235c3d2cef::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 9, b"MOODENG", b"Moo Deng", b"This is MOODENG aka MOODENGCOINSUI, just a viral lil hippo but now MOODENG comming on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1843868823281381376/gfMFDET-_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOODENG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

