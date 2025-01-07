module 0x1b8063bc7bc51a4bfa683c02a850cf561a913deed0829b64f1505ea5a2f8aab8::suagra {
    struct SUAGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAGRA>(arg0, 6, b"SUAGRA", b"SUIAGRA", x"546869732077696c6c206d616b6520796f7520657863697465642e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_14_A_s_08_55_02_e15397bd_016d140f60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUAGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

