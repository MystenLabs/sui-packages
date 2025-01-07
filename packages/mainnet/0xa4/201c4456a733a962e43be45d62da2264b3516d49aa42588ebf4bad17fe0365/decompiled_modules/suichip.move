module 0xa4201c4456a733a962e43be45d62da2264b3516d49aa42588ebf4bad17fe0365::suichip {
    struct SUICHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHIP>(arg0, 6, b"SUICHIP", b"Neurasui", b"bren marcorshep is the feture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_14_T181736_399_adac3aad05.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

