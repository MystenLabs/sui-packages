module 0xa56f555076949b59371c63bdf27251de04db72d9549bbd157f7af023f1f0449e::osui {
    struct OSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSUI>(arg0, 6, b"OSUI", b"Oshawott Sui", b"Oshawott on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_20_57cf5f2447.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

