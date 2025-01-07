module 0x4328ce93eb07d6cb37daa6739ae62560ae028529e0e9354f44083ed380dd7bf9::son {
    struct SON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SON>(arg0, 6, b"SON", b"areyawinningson", x"4152452059412057494e4e494e4720534f4e3f0a4152452059412057494e4e494e4720534f4e3f0a4152452059412057494e4e494e4720534f4e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_09_25_131233_4e63330799.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SON>>(v1);
    }

    // decompiled from Move bytecode v6
}

