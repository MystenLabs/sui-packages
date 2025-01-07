module 0xe41ea6ae9fb68e503e50638c3360dc3a1ac182c911e78520726fb8a5a2a5cd91::robotmagnet {
    struct ROBOTMAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTMAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTMAGNET>(arg0, 6, b"ROBOTMAGNET", b"WE ROBOT MAGNET", b"WE ROBOT MAGNET, high value robot magnet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_B29043_E_D6_CA_4772_AB_8_B_E1_F439_EA_59_E6_535c721088.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTMAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTMAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

