module 0x276c74407c0bdf38396c4b3da8dd9fcc7bdbc61ae0e6bfea1c3316cb8209dd32::suileman {
    struct SUILEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUILEMAN>(arg0, 6, b"SUILEMAN", b"suileman by SuiAI", b"suileman of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Default_Sure_Heres_a_more_concise_version_of_the_logo_design_p_0_f094572fc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEMAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEMAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

