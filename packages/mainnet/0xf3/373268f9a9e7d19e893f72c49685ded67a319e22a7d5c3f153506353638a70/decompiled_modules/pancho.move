module 0xf3373268f9a9e7d19e893f72c49685ded67a319e22a7d5c3f153506353638a70::pancho {
    struct PANCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANCHO>(arg0, 6, b"PANCHO", b"Sui Pancho", b"Pancho - Revolutionizing crypto with humor and audacity on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000025042_83e6145360.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

