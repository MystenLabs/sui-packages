module 0x864bc1384339cadc5603dbce4c96f30a277a9d1ded66f8a55e51b49fd8b839df::coolfrog {
    struct COOLFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLFROG>(arg0, 6, b"COOLFROG", b"Cool Frog", x"5269626269742c207269626269742120436f6f6c2046726f6720697320686f7070696e67206f6e746f207468652053756920626c6f636b636861696e2061732074686520636f6f6c657374206d656d65746f6b656e20696e2074686520706f6e642e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cool_Frog_24bc924a49.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

