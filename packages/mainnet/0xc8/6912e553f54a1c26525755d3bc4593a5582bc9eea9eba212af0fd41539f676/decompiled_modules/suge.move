module 0xc86912e553f54a1c26525755d3bc4593a5582bc9eea9eba212af0fd41539f676::suge {
    struct SUGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGE>(arg0, 6, b"SUGE", b"Sui Doge", b"Fade $SUGE at your own risk!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TOGE_T_Fsa_Em_T6_B3dii9v_EE_2_08e67481e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

