module 0x84a3e0af4e5045dc89bab98307e0f604ebb5661d3eea99034dce81cba11cabcc::cptsui {
    struct CPTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPTSUI>(arg0, 6, b"CPTSUI", b"CPT", b"CPTSUI IS CPT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Il_Hluz_Qffreuo_SGEBJJZVA_567189959_a15f0942ac.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

