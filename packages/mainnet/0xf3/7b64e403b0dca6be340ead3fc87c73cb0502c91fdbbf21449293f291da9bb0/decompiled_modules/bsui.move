module 0xf37b64e403b0dca6be340ead3fc87c73cb0502c91fdbbf21449293f291da9bb0::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"SUIRBET SUI", x"2442535549202077696c6c206d616b652053756920436861696e206d6f7265206174747261637469766520616e642077696c6c2061747472616374206d616e7920696e766573746f72732066726f6d206f746865722065636f73797374656d7320746f206a6f696e2053756920616e6420696e7665737420696e2024427375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_7_165471f0b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

