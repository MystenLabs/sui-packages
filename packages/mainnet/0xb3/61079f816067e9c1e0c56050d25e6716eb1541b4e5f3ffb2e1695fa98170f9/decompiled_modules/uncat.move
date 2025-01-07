module 0xb361079f816067e9c1e0c56050d25e6716eb1541b4e5f3ffb2e1695fa98170f9::uncat {
    struct UNCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNCAT>(arg0, 6, b"UNCAT", b"UNKNOWN CAT", b"Don't be scared of the unknown. Ignorance is a bliss.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240913_091255_680_88ca82994c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

