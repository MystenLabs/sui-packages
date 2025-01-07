module 0x678e44396088237905b5fa0aea10567f122bd970a6951790f8b9070a17687d1a::als {
    struct ALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALS>(arg0, 6, b"ALS", b"ailen on sui", b"Im Ailen, were all Ailen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_12_c90e0596b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

