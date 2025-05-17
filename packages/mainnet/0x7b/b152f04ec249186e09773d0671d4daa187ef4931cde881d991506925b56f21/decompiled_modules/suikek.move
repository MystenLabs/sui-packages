module 0x7bb152f04ec249186e09773d0671d4daa187ef4931cde881d991506925b56f21::suikek {
    struct SUIKEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEK>(arg0, 6, b"SUIKEK", b"SUIKEK MAXIMUS", b"KEKIKUS MAXIMUS reverse spelling = SUIKEK MAXIMUS KEKIUS MAXIMUS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_24_30418ae99c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

