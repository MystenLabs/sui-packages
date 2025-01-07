module 0x5e4e0c9646a78c75492b46e1c1a7b45660013ab1fc882b454445e2e599d4a9c4::suiwwe {
    struct SUIWWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWWE>(arg0, 6, b"SUIWWE", b"SUI_WWE", b"Meme fight. Who will win and face me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zq86_NS_Xg_A05d_E3_49526e3c98.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

