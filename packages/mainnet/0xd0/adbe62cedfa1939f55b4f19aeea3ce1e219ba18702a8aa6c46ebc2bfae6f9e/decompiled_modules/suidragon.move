module 0xd0adbe62cedfa1939f55b4f19aeea3ce1e219ba18702a8aa6c46ebc2bfae6f9e::suidragon {
    struct SUIDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRAGON>(arg0, 6, b"SuiDragon", b"Sui Dragon", b"The first dragon meme coin on the Sui blockchain! LFG!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000185613_2b78c8347b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

