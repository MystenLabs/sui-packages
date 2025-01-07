module 0x74a2636d9c83fee09a22bef04bf0d33e86c450793e8530afe9a6b52216b59771::asui {
    struct ASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUI>(arg0, 6, b"ASUI", b"Aqua Sui", b"First Aqua on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_13_3a6ae211a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

