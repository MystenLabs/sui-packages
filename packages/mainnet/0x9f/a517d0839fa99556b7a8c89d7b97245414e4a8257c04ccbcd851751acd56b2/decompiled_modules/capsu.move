module 0x9fa517d0839fa99556b7a8c89d7b97245414e4a8257c04ccbcd851751acd56b2::capsu {
    struct CAPSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPSU>(arg0, 6, b"CAPSU", b"Captain TSUIbasa", b"Mascot Football in SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Add_a_subheading_1_9a7f885abb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

