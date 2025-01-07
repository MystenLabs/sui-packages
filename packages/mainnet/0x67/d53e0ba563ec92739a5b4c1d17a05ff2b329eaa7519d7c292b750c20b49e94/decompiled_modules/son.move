module 0x67d53e0ba563ec92739a5b4c1d17a05ff2b329eaa7519d7c292b750c20b49e94::son {
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

