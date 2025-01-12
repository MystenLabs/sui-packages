module 0xdcb3cabde3a2378c9b17bd3f865500942dc96dc895984aff82c2cdee60ed5fd7::pikai {
    struct PIKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKAI>(arg0, 6, b"PIKAI", b"PIKAI THE REBORN", b"PIKAI: The Ultimate Evolution.PIKAI is an AI Agent that grows with its market cap. Emerging from its Pokeball, the more it evolves, the higher its power soars, until it shakes the SUI blockchain. Try to catch it if you can and join the  PIKAI legend !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_11_22_04_16_66d49ab229.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

