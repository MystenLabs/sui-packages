module 0x67d3b84df0a93d5960d16cbc4188f0dcf73804b621e494359967af808bc252c5::themostlongtickeeverseeninthisworlddddddddd {
    struct THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD>(arg0, 9, b"THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD", b"THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD", b"THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD>(&mut v2, 99999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THEMOSTLONGTICKEEVERSEENINTHISWORLDDDDDDDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

