module 0xdb8715a4e8527694dbc9709813063a7ef68ec4d801d3e1c146c6e9abfd889eef::pino {
    struct PINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINO>(arg0, 6, b"PINO", b"Pino the dino", b"Meet Pino, legendary best friends with Matt Furies Boys Club characters. The Bad Boy of Solana, a True Crypto Degen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_01_23_11_54_removebg_preview_d9af52768b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

