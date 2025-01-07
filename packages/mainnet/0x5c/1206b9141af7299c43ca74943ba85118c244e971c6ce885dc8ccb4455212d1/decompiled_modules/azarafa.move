module 0x5c1206b9141af7299c43ca74943ba85118c244e971c6ce885dc8ccb4455212d1::azarafa {
    struct AZARAFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZARAFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZARAFA>(arg0, 6, b"AZARAFA", b"Azarfa", b"Welcome to AZARAFA, a meme coin that combines elegance, history, and crypto in one stunning package. Inspired by the legendary giraffe, Azarafa, who captivated the world with her beauty and grace, AZARAFA brings this timeless symbol of grandeur into the digital age.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Gh_L_Pqu_Sd_FFXF_2_A6_NZ_8b1is_Kuivc16_Mj_G_Bvj_KP_Eoo_B_Xk_78fbc9836a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZARAFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZARAFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

