module 0x6584931d6932162cb01a7c81ee7a6f550af12f7d7d2773d554572aa8cdfc6cb5::catcola {
    struct CATCOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCOLA>(arg0, 6, b"CATCOLA", b"COCA CAT COLA SUI", x"42656175746966756c207472696275746520746f2063617473206e6f7720696e20436f636120436f6c612063616e732c206e6f7720746865792061726520616c736f20696e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_14_A_s_09_56_55_e9a9c8f8_10241ce670.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATCOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

