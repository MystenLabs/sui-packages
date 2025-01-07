module 0x7fbd19bde9f98d24cc782419429585c7a5430f17a2d9034623465900df20448a::suirangers {
    struct SUIRANGERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRANGERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRANGERS>(arg0, 6, b"SUIRANGERS", b"Sui Rangers", b" It's Morphin Time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_03_A_s_23_47_46_b38e711d_58cade8d36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRANGERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRANGERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

