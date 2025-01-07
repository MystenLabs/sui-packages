module 0x37cca49f253318b9860fdf7bfae8d1ab6150ba63c8435b2e4648c7a3561e589a::iustitiacoin {
    struct IUSTITIACOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUSTITIACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUSTITIACOIN>(arg0, 6, b"IustitiaCoin", b"IUS", b"IUS is a memecoin launched on the SUI blockchain, symbolizing the essence of justice, fairness, and community-driven fun. Inspired by the mythological creature Iusora, IUS aims to create a decentralized ecosystem where humor meets the pursuit of equality and transparency in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cloudtechxxx_02117_httpss_mj_rund4_I58_MMJL_3k_base_on_this_logo_9fc82b24_1616_4a87_8ad9_49f364aef590_2_320f86aeb3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUSTITIACOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUSTITIACOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

