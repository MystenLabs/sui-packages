module 0xba8323eaa4e3ab036ce541bfc06701ce0b8bde66be5599367b463fffa811105a::cheeks {
    struct CHEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEKS>(arg0, 6, b"CHEEKS", b"CHEEKS SUI", b"In a space where doxxed devs are hard to find", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_23_ea3946a4a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

