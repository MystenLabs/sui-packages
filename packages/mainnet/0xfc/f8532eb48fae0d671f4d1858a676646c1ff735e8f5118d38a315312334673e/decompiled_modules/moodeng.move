module 0xfcf8532eb48fae0d671f4d1858a676646c1ff735e8f5118d38a315312334673e::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"moodeng", b"moodeng Coin", b"unbothered. moisturized. happy. in my lane. focused. flourishing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://moodengsui.com/images/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOODENG>>(0x2::coin::mint<MOODENG>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOODENG>>(v2);
    }

    // decompiled from Move bytecode v6
}

