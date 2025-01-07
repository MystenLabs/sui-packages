module 0x85e5b4fda2a57184aae6834d15f7f4071881e199f6289a13b03e533aa71f7388::mogii {
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

