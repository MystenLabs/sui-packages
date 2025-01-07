module 0x3135c813006796c0d097116e8c75bc87963408b0821b2245e65eea30241d7d38::fwogsui {
    struct FWOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGSUI>(arg0, 6, b"FWOGSUI", b"FWOG ON SUI", x"2046574f47206f6e205355490a4f56455220243130304d206d63206f6e20534f4c2e204a757374206c61756e6368206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_5c830884ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

