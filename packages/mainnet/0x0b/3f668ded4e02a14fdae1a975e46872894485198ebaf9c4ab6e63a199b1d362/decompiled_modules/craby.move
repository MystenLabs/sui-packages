module 0xb3f668ded4e02a14fdae1a975e46872894485198ebaf9c4ab6e63a199b1d362::craby {
    struct CRABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABY>(arg0, 6, b"CRABY", b"SuiCraby", b"the only crab alive on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_73_a09c8bbf95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

