module 0x1479c7eac43e3531887c78273359f1f1e9c45aa83fbc0ad082eadfe526ac8cf9::pbl {
    struct PBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBL>(arg0, 6, b"PBL", b"PABLO MARCALL", b"O Token Pablo Maral  uma representao digital nica que captura a essncia e a viso inovadora do empreendedor, influenciador e mentor. Com um foco em desenvolvimento pessoal e transformao, este token simboliza o compromisso de Pablo em inspirar e capacitar indivduos a alcanarem seus objetivos. Ao adquirir este token, voc se junta a uma comunidade de pessoas que valorizam o crescimento, a autenticidade e a busca por excelncia. Este ativo digital  mais do que uma simples moeda;  um convite para embarcar em uma jornada de aprendizado e autoconhecimento, guiada pelos ensinamentos de um dos lderes mais influentes da atualidade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2_3e363e374a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

