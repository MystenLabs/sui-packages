module 0xc44afc722cf284e0b91c1bc24e822d37ecf3f8c6cd9bb022f5813f4930bb351a::supe {
    struct SUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPE>(arg0, 6, b"SUPE", b"SuiPepe", b"SuiPepe: The King of Memes on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepeee_727fceb400.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

