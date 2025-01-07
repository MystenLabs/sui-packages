module 0xcfe2b2fd5ca0ed81d16ababa6f751bc1f0a0d825934de0db145b8123797e84b7::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE>(arg0, 6, b"FIRE", b"doginphire", b"ALSO A DOG WIF A HAT BUT IN PHIRE WIF A HAT. Who needs a dog wif just a hat when you can have a dog in phire and a hat? Because, let's face it, a hat is cool, but a dog wif a hat in phire is 'pawsitively' lit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_G8js2_Fj_Dt_Mb_V_Dzh5_A_Ca_TLGHG_Dw_Bha_M5_LB_Nu_HK_Me_Z7_Bd_20ca715fc7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

