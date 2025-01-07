module 0x56a41e7322dd5a2ed7785cee39ae5cfa9539907f2527241b62b39c126038f429::bretsu {
    struct BRETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETSU>(arg0, 6, b"BRETSU", b"BRETSUI", b"The bitch of SUI. The only girl manages to sleep with all members of the Boys Club, enjoys her power and attention. Despite initial resistance, they eventually succumb to her charms, creating drama and chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_02_03_45_8813552865.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

