module 0x59416ffbda71a6ad9cacbd73d11d7f31ffd85e2883e3faa97110c94db9b2f591::pineapple {
    struct PINEAPPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINEAPPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINEAPPLE>(arg0, 9, b"PINEAPPLE", b"PINEAPPLE", b"Digital Artist. Creative.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1570940813999505411/sKkL8Zou_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINEAPPLE>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINEAPPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINEAPPLE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

