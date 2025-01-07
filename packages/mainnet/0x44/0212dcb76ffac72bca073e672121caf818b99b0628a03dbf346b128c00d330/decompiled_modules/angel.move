module 0x440212dcb76ffac72bca073e672121caf818b99b0628a03dbf346b128c00d330::angel {
    struct ANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGEL>(arg0, 6, b"Angel", b"Sui Angel", b"The true Angel of Sui. Bold, relentless, and here to dominate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/water_drop_angel_with_wings_vector_cartoon_character_193274_19973_7e3a800c25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

