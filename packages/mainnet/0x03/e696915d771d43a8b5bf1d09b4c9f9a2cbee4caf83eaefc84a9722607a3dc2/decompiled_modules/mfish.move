module 0x3e696915d771d43a8b5bf1d09b4c9f9a2cbee4caf83eaefc84a9722607a3dc2::mfish {
    struct MFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFISH>(arg0, 6, b"Mfish", b"MoonFish", b"This fish wants to go to the Moon. So do you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7416_AFE_8_C969_4241_A403_E9_E2_A1_BBE_75_B_1d70fb634a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

