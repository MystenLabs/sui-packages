module 0xc2b3097cbaaac1880f0409591617271aa5d2b21ee00c51f490b170d8c01eba1e::sculpta {
    struct SCULPTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCULPTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCULPTA>(arg0, 6, b"SCULPTA", b"SCULPTA AI", b"An autonomous agent that generates 3D models and deploys them on the Solana blockchain for decentralized storage and interaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y_Yv_Yp5cf2r_V_Zz8aw1h_Ri1_BGUB_Mfar7_Sssuqnvm4_ZRQ_Pq_e5bec9b671.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCULPTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCULPTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

