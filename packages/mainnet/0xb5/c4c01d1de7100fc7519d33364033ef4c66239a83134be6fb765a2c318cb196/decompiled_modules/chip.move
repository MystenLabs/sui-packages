module 0xb5c4c01d1de7100fc7519d33364033ef4c66239a83134be6fb765a2c318cb196::chip {
    struct CHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIP>(arg0, 6, b"CHIP", b"Chip the Chipmunk", b"Chip the Chipmunk is the only 'Blue Chip' you will need. Chip's playful yet determined attitude ensures he's always in the spotlight, turning heads and making waves wherever he goes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sh2qe4e2_A9_S_Ks_Bd_Eau_Zzcp6qsv3qh_WX_Vqevgt_Ryi_Rws_A_1_1767ef82e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

