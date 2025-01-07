module 0xd3fa782691aa5ff32d72cfcc0cdd599bb4b56709021bf403370580c69b55e2a7::macho {
    struct MACHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACHO>(arg0, 6, b"MACHO", b"machosui", b"Welcome to the MachoVerse where we aim to build successful income producing TG games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F7_RB_4c_HW_400x400_08780535d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

