module 0xd820127d03a9b683bb02cbe36def5fca81617a97fd54f5da4bf9575855c3dfcb::suiregdug {
    struct SUIREGDUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREGDUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREGDUG>(arg0, 6, b"SUIREGDUG", b"SUI CUREG DUG", b"Cureg is a popular 90s cartoon. He is a timid pink dog with paranoia problems. His owners are an old couple living on a farm full of bizarre adversaries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_20_A_s_14_53_11_dc42a906_5a86fee7d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREGDUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREGDUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

