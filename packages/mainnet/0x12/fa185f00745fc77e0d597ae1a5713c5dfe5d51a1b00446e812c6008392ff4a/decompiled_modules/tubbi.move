module 0x12fa185f00745fc77e0d597ae1a5713c5dfe5d51a1b00446e812c6008392ff4a::tubbi {
    struct TUBBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUBBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUBBI>(arg0, 6, b"TUBBI", b"Tubbi", b"TUBBI takes playful chaos to new heights as the first-ever playable character in MemeArena, the ultimate cross-chain battleground for meme projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_C_Sm5o_Z4_400x400_183e314739.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUBBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUBBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

