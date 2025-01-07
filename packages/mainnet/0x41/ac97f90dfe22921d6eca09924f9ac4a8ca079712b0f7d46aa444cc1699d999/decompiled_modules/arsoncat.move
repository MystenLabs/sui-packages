module 0x41ac97f90dfe22921d6eca09924f9ac4a8ca079712b0f7d46aa444cc1699d999::arsoncat {
    struct ARSONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARSONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARSONCAT>(arg0, 6, b"ArsonCat", b"ArsoCat", b"It's time to light a fire on sui. Let's start a fire together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1733497818146_89cb1ac78f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARSONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARSONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

