module 0x52b147a9d04c45935d7c3365a39bd6435a12f198c4386a1da24bd6ad6d529438::suisung {
    struct SUISUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUNG>(arg0, 6, b"SUISUNG", b"SUISUNG Coin", x"22496e73706972652074686520576f726c642c204372656174652074686520467574757265220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_10_A_s_21_13_27_2c6e834d_aa126c2d2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

