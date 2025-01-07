module 0x13c74aba16498f89dd36a7e8a4025d6d34faf4a07421e0f52ec303423204b670::scapy {
    struct SCAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAPY>(arg0, 6, b"SCAPY", b"Capybara", b"capybaraa on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7d36d304_c16f_48ce_9917_ee301ab7bdd1_bf1d7e380f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

