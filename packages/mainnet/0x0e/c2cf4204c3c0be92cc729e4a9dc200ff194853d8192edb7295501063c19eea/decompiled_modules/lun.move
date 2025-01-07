module 0xec2cf4204c3c0be92cc729e4a9dc200ff194853d8192edb7295501063c19eea::lun {
    struct LUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUN>(arg0, 9, b"LUN", b"Lunar", b"Happy Lunar New year to all celebrating! May the year of the dragon bring you and your loved ones prosperity, boundless opportunities, success, and joy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://miro.medium.com/v2/resize:fit:1024/1*YGvwCFgKnAo7W3s_YxBDwQ.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

