module 0xa9bb4bd274014afbad119fa9189bfec486b037fe4fe1045cb94ec243c55e8bb6::fritz {
    struct FRITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRITZ>(arg0, 6, b"FRITZ", b"FRITZ SUI", x"5468652066616d6f7573205079676d7920486970706f0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_44_e2a71962ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRITZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRITZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

