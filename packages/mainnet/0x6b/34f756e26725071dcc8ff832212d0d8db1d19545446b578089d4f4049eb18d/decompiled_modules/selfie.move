module 0x6b34f756e26725071dcc8ff832212d0d8db1d19545446b578089d4f4049eb18d::selfie {
    struct SELFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFIE>(arg0, 6, b"SELFIE", b"SELFIE CAT", x"57656c636f6d6520746f2053454c464945204341540a546865206d6f73742070686f746f67656e696320434154206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_00_55_01_926e1686b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

