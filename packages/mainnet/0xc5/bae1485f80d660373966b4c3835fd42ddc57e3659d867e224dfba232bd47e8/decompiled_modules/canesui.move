module 0xc5bae1485f80d660373966b4c3835fd42ddc57e3659d867e224dfba232bd47e8::canesui {
    struct CANESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANESUI>(arg0, 6, b"CaneSUI", b"CanetaSUI", b"The CanetaSUI is a Meme Token inspired by the virality of Manuel Gomes, known for his hit \"Caneta Azul.\" Now, he joins forces with the power of the SUI network, represented by the water drop and its cutting-edge technologies. This token brings humor and innovation, capturing the essence of meme culture and the digital evolution of the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Enquanto_uns_se_separam_Manoel_do_hit_a_Caneta_Azul_anuncia_noivado_com_bela_morena_veja_39_10f0ac7af7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

