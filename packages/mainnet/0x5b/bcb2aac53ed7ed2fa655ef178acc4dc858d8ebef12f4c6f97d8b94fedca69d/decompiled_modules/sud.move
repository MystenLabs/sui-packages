module 0x5bbcb2aac53ed7ed2fa655ef178acc4dc858d8ebef12f4c6f97d8b94fedca69d::sud {
    struct SUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUD>(arg0, 6, b"SUD", b"SuiUnity DAO", x"202a2a537569556e6974792044414f2a2a20203130302520636f6d6d756e6974792d6f776e65642c20646563656e7472616c697a65642c20616e64207472616e73706172656e742065636f73797374656d212020200a204e6f206269672077616c6c6574732c20616c6c206c69717569646974792062656c6f6e677320746f207468652070656f706c652120200a204a6f696e20757320616e642067726f7720746f67657468657220696e20756e6974792120200a0a23537569556e697479202344414f2023576562332023446563656e7472616c697a6174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_02_25_20_52_08_A_high_quality_modern_and_minimalist_logo_design_for_Sui_Unity_The_logo_should_feature_sharp_technological_elements_with_a_circular_shape_symboli_ded58da724.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

