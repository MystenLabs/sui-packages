module 0x82b810aaf1566f3a093451250c434b0c5351d621269222912eff71bcf633672d::als {
    struct ALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALS>(arg0, 6, b"ALS", b"Ailen On Sui", b"Im Ailen, were all Ailen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_11_fa615bb566.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

