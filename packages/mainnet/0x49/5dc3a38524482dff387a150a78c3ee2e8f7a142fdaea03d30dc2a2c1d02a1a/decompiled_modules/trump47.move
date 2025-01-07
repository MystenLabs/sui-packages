module 0x495dc3a38524482dff387a150a78c3ee2e8f7a142fdaea03d30dc2a2c1d02a1a::trump47 {
    struct TRUMP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47>(arg0, 6, b"TRUMP47", b"47TRUMP", b"47TRUMP token celebrates the election of donald trump as the 47th president of the united states which brought us a new ATH for Bitcoin. A new wave in the crypto market and a brilliant future await us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F_Ymq_SEN_Gy_Z_Us_HP_Aknq8_K1tutt4_PYD_Rgqnjed4p_E4pump_82075c3d00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP47>>(v1);
    }

    // decompiled from Move bytecode v6
}

