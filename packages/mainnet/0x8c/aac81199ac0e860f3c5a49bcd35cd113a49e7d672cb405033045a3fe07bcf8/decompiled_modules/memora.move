module 0x8caac81199ac0e860f3c5a49bcd35cd113a49e7d672cb405033045a3fe07bcf8::memora {
    struct MEMORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMORA>(arg0, 6, b"MEMORA", b"Memora Core", x"43726561746520746865206d6f7374206c6966656c696b652068756d616e6f6964204149206167656e74732077697468206d656d6f72792c206665656c696e67732c20656d6f74696f6e732c20616e642073686172656420657870657269656e6365732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_UM_74je7_Nrt_Y2s_Q7_ZL_Ea_Kn_Mn_Za_W2p5m_X_Huz_Tr_CASCRX_3i_ede3ce21b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

