module 0xf431401cb0f550e468edab9336e7c0928b773a2c564531dc20f2b2df09e0afba::jabaduck {
    struct JABADUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JABADUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JABADUCK>(arg0, 6, b"JABADUCK", b"JABA DUCK SUI", b"JABA DUCK SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_14_A_s_23_12_22_e65a1b5d_5e55df3de4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JABADUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JABADUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

