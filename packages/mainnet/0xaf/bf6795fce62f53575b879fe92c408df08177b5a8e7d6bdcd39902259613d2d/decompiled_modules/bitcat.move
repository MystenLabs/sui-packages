module 0xafbf6795fce62f53575b879fe92c408df08177b5a8e7d6bdcd39902259613d2d::bitcat {
    struct BITCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCAT>(arg0, 6, b"BITCAT", b"Bitcoin Cat", b"Just Bitcoin Cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BITCAT_c78443e2dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

