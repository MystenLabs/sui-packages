module 0x8358f50848cab6b1ffc11ed193a67efbf00e6794371db6192577308dfe779181::signal {
    struct SIGNAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGNAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGNAL>(arg0, 6, b"SIGNAL", b"Signal", x"7369676e616c20746f6b656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z2_XS_5vyd65_Bpd_P_Tz_Da_Wz_Ztr_Hbo5_Qq_QK_Km_Cqxo2dgkb_NS_2558d6e6e8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGNAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGNAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

