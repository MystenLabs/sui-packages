module 0x39bbec13f0285b3afe6343d48032d1dcf2f31d27db0ad326db1492555bc4d3f1::peppe {
    struct PEPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPPE>(arg0, 6, b"PEPPE", b"PEPPERONI", b"Our Pepe with a Pepperoni flavour! Delicious!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a374x5e_700b_0800d7c61b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

