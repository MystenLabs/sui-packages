module 0xf9a771ba344b6997927847293f35b47990af3fcc7d543ac08ce26cb62cd7fb66::seno {
    struct SENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENO>(arg0, 6, b"SENO", b"SENO ON SUI", x"53454e4f2069732061206d7974686963616c206368617261637465722c206275742068652068617320612073746f727920746f2074656c6c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_16_27_05_3e9961923d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENO>>(v1);
    }

    // decompiled from Move bytecode v6
}

