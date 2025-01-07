module 0x8b506e338dd662ab3834553b96ba9be61160a2bb11ea93b62855a7f4fff5f1c3::aaaaa {
    struct AAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAA>(arg0, 9, b"aaaaa", b"aa", b"aaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/4x0BLM0w/201.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAAA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

