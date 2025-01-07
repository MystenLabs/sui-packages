module 0x1cf6bb62bd216b2ef39b670b8cf11c58b5894db67f3a32a08b90cafccc24dda5::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 9, b"TROLL", b"TROLLn", x"5472c58d6c6c6865696d20436f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/daniel23/image/upload/v1705188555/WhatsApp_Image_2024-01-13_at_23.58.45_ypsuqz.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLL>>(v1);
        0x2::coin::mint_and_transfer<TROLL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

