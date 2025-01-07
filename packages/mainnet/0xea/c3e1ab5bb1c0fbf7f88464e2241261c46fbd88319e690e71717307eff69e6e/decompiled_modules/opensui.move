module 0xeac3e1ab5bb1c0fbf7f88464e2241261c46fbd88319e690e71717307eff69e6e::opensui {
    struct OPENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPENSUI>(arg0, 6, b"OPENSUI", b"OPEN SUI", b"SUI on  OPENSEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/opensea_logo_0_FFCF_87312_seeklogo_316b57cf26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

