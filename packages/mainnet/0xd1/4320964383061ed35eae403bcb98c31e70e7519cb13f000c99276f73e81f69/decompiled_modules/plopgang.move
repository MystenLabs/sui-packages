module 0xd14320964383061ed35eae403bcb98c31e70e7519cb13f000c99276f73e81f69::plopgang {
    struct PLOPGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOPGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOPGANG>(arg0, 6, b"PLOPGANG", b"PlopGang", b"The Plop Token Gang.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/145071693_genial_personaje_de_dibujos_animados_de_gotas_de_lluvia_con_gafas_negras_caras_0c22fb0625.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOPGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOPGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

