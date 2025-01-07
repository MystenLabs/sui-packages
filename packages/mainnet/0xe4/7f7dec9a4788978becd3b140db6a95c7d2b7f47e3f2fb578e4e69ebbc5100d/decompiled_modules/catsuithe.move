module 0xe47f7dec9a4788978becd3b140db6a95c7d2b7f47e3f2fb578e4e69ebbc5100d::catsuithe {
    struct CATSUITHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUITHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUITHE>(arg0, 6, b"CATSUITHE", b"CATSUITHENAS", b"CATSUITHENAS SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_17_A_s_13_24_43_b591c54b_a382f86ab7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUITHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSUITHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

