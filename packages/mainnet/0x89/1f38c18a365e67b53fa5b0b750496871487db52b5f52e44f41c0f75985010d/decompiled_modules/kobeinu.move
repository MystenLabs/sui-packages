module 0x891f38c18a365e67b53fa5b0b750496871487db52b5f52e44f41c0f75985010d::kobeinu {
    struct KOBEINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBEINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBEINU>(arg0, 6, b"Kobeinu", b"Kobeinu - Shibs Brother", b"Kobeinu - Shibs Brother. Just launched  on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_18_04_50_3ae2ebd66d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBEINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBEINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

