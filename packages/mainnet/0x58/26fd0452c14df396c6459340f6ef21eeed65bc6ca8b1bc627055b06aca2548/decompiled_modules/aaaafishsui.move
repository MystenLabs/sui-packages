module 0x5826fd0452c14df396c6459340f6ef21eeed65bc6ca8b1bc627055b06aca2548::aaaafishsui {
    struct AAAAFISHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAFISHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAFISHSUI>(arg0, 6, b"AAAAFISHSUI", b"AAAAFISH", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_025026407_895686e7d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAFISHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAFISHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

