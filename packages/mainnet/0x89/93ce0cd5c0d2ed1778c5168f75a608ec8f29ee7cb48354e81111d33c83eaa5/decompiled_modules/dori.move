module 0x8993ce0cd5c0d2ed1778c5168f75a608ec8f29ee7cb48354e81111d33c83eaa5::dori {
    struct DORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORI>(arg0, 6, b"DORI", b"Dori", b"Just Dori", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cc56e0a9c44e125570b574fc102c1014_d068f02493.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

