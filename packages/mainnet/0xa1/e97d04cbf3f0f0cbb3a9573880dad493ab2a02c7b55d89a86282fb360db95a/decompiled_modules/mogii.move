module 0xa1e97d04cbf3f0f0cbb3a9573880dad493ab2a02c7b55d89a86282fb360db95a::mogii {
    struct MOGII has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGII>(arg0, 6, b"MOGII", b"MOGIII", b"creative artificial intelligence   We are starting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_03_25_122653_2122505783.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGII>>(v1);
    }

    // decompiled from Move bytecode v6
}

