module 0x9e5dba1a80475f7143e4c6d8bcc429c73e1b027a8f5e7a028dc237394321a9be::suibasui {
    struct SUIBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBASUI>(arg0, 6, b"SUIBASUI", b"SUIBASU", b"The secret ingredient has always been a blue dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_014908736_1ccfd58067.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

