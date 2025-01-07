module 0xad79e8ca45cbb79e79c12bf235e80825279b29a6d25ad1ccda68715199796fa3::froge {
    struct FROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGE>(arg0, 6, b"FROGE", b"Froge SUI", b"The ugliest frog in Sui|Frope $Fro inheriting Pepe's legacy while forging his own path.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_06_34_18_789c869e38.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

