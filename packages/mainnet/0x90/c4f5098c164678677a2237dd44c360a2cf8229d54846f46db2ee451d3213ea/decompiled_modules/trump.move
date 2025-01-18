module 0x90c4f5098c164678677a2237dd44c360a2cf8229d54846f46db2ee451d3213ea::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"Trump", b"OG OFFICIAL TRUMP", b"After having my head knocked off on Trump, who didn't have his liquidity burn! We launching TRUMP on movepump as a CTO! sponsored by Bluemove and therefore with secure liquidity. SUI to sponsor TRUMP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_da_e_I_cran_2025_01_18_a_I_20_46_36_f2e89e4775.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

