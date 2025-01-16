module 0x89d1bb798a676ebc483eb92913978ab3899fcc0937a6a52f19814a3edd3427fc::fiverr {
    struct FIVERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIVERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVERR>(arg0, 6, b"Fiverr", b"fivver", b"fiver", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fiverr_Logo_c776c8443d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIVERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIVERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

