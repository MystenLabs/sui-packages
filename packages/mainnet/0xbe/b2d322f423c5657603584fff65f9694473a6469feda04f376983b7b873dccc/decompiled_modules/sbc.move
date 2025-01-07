module 0xbeb2d322f423c5657603584fff65f9694473a6469feda04f376983b7b873dccc::sbc {
    struct SBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBC>(arg0, 6, b"SBC", b"Suibacca", b"May SUI Force be with you. I am your father.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2024_10_11_174232_8c348203c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

