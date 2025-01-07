module 0xcf0faff8d531b369b7273081858d5fc18b6e07fb7e495c08b3e56e0b634209b6::suikotaro {
    struct SUIKOTARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOTARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOTARO>(arg0, 6, b"SuiKotaro", b"Kotaro", b"TOP.1 memecoin on Suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYI_Xleg_Xk_A_Aym3_D_099185c316.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOTARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOTARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

