module 0x162233b43f4739070771ed2f0e849de286dba050c82eef4cb2ef9d924a7f21d2::schiba {
    struct SCHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHIBA>(arg0, 6, b"SCHIBA", b"SUI CHIBA", b"THE ORIGIN STORY - Inspired by the Chiba-Wan rescue of Kabosu, the dog behind #DOGE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_71_bd29a1608b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

