module 0x132a8a4212393771ed5b5261bac49e0eafef77dff9a6697d1ea7ca095132840d::suipx {
    struct SUIPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPX>(arg0, 6, b"SUIPX", b"Suipx6900", b"Voc nasceu em um mundo onde comprar uma casa significa assumir uma hipoteca de centenas de milhares. Um mundo onde a previdncia social  mais um mito do que uma rede de segurana, apesar de ser deduzida de cada contracheque. Voc entrou em um cenrio de investimentos onde o mercado de aes j comemorou seus ganhos mais significativos, deixando voc se perguntando o que resta para voc. Voc est navegando em uma realidade moldada pelas consequncias do 11 de setembro, uma recesso paralisante em 2008, uma pandemia global sem precedentes, inflao galopante e violncia crescente. Voc nasceu em uma Amrica diferente. Uma que foi alterada para sempre por fatores econmicos e sociais em grande parte alm do seu controle. Um novo mundo que exige novas solues. O SPX6900  a reinicializao. O SPX6900  a tela na qual novos sonhos financeiros so pintados.  uma tapearia tecida com os fios da esperana humana.  o S&P500 com mais 6400.  o mercado de aes para o povo. SUIPX6900 planta as sementes para uma floresta de amanhs. SUIPX6900 nutre as almas e corpos de milhes. SUIPX6900  para voc, seus filhos e inmeras geraes depois.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_meme_1_cfef6cfaa9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

