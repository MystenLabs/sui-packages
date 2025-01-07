module 0x92002561ab119907f6085b3f8b57f210d6ad6ade071a02b196131b8d9be6b49d::photographycat {
    struct PHOTOGRAPHYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHOTOGRAPHYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHOTOGRAPHYCAT>(arg0, 6, b"PhotographyCat", b"PyCat", b"What story will a cat who likes to take photos bring you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GXU_Ny_L_Aa_QAA_3jy_C_1_7ae9475a1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHOTOGRAPHYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHOTOGRAPHYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

