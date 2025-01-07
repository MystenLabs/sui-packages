module 0xd9f321eaca068d1daa1c3f68e41cbad1c56943447080400bf8990ff6fce05a97::cursedcat {
    struct CURSEDCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURSEDCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURSEDCAT>(arg0, 6, b"CursedCat", b"CURSEDCATSUI", b"The Cursed Cat bringing you the baddest luck on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M_Nbez8_P1_400x400_fbbeb82581.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURSEDCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CURSEDCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

