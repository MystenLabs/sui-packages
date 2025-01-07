module 0xd1c328ddad40ff4a1985a5b73fa53258d6e3dcd683d696a4a0a140f22c134663::mendog {
    struct MENDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENDOG>(arg0, 6, b"MENDOG", b"MenswearDog", b"Menswear Dog  The Most Stylish Dog in the World Woulded a funny internet meme symbol People would enjoy seeing this dog in ridiculous menswear outfits.\" 'Menswear Dog' MenDog turns Shiba Inu into viral style icon  Menswear Dog is The fashion icon of the decade. Thats right, the whole decade. $MENDOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nyh1q_G_Hw_Azexp_REB_99vg_FJ_8sw8r7t_M_Mnb_X8_Rtu_GF_Zq_HQ_7e40f0791e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MENDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

