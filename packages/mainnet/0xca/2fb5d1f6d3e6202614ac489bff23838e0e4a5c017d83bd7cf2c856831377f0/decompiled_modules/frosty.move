module 0xca2fb5d1f6d3e6202614ac489bff23838e0e4a5c017d83bd7cf2c856831377f0::frosty {
    struct FROSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROSTY>(arg0, 6, b"FROSTY", b"Frosty the Sui Snowman", x"2446524f5354592074686520536e6f776d616e206368696c6c696e206f6e2053756920426c6f636b636861696e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_P_Lv_PR_Mz_N_Lij_Zsnk6h_YA_Lzz7_Pz_Re6excv_MLU_Fmcpump_1_454e78bd6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

