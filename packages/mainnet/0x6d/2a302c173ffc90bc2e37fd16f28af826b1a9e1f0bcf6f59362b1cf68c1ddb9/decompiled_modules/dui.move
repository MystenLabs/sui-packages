module 0x6d2a302c173ffc90bc2e37fd16f28af826b1a9e1f0bcf6f59362b1cf68c1ddb9::dui {
    struct DUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUI>(arg0, 6, b"DUI", b"DOGUI", b"DOGE SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_doge_coding_design_criativo_de_logotipo_em_desenho_animado_152710_379_d8339b4d02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

