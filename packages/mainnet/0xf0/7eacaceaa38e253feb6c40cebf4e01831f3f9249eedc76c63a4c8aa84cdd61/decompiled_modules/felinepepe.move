module 0xf07eacaceaa38e253feb6c40cebf4e01831f3f9249eedc76c63a4c8aa84cdd61::felinepepe {
    struct FELINEPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELINEPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELINEPEPE>(arg0, 6, b"FelinePepe", b"PepeCat", x"506570654361742020436f6d696e6720746f2053554920434861696e206e6f772e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Feline_Pepe_TWF_Yf_M_9_Esa_B22_F_Nbk_G_ce92ecce56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELINEPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FELINEPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

