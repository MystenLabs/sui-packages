module 0x611a32c7d34d95c4296754ca25f370d0b9304a4717b8314bc33e74c2c53fc8b1::clownfish {
    struct CLOWNFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWNFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWNFISH>(arg0, 6, b"CLOWNFISH", b"ClownFish", b"Every transaction looks like a laugh! This meme coin brings humor and joy to cryptocurrency trading, join our underwater party.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cabe_A_alho_para_Twitter_Minimalista_com_Foto_e_CA_rculos_Azul_1_2307ace939.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWNFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOWNFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

