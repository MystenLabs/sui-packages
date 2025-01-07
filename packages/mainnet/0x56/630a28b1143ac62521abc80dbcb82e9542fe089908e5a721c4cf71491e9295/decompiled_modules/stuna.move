module 0x56630a28b1143ac62521abc80dbcb82e9542fe089908e5a721c4cf71491e9295::stuna {
    struct STUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUNA>(arg0, 6, b"STUNA", b"Spicy Tuna", b"Spicy Tuna on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pai_I_4_R_Fdgcrww_BG_ceb1335260.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

