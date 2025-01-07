module 0x3e9130e96a939221e4170c96d83da7ceef4267df5d6239c51fb788d38d3737ea::naughtydog {
    struct NAUGHTYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAUGHTYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAUGHTYDOG>(arg0, 6, b"NAUGHTYDOG", b"naughtydogcoin", b"meme community coin on sol for all dog lovers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_14_a_I_s_11_58_47_f501b03256.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAUGHTYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAUGHTYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

