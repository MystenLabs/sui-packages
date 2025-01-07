module 0x8c731b1f4343203f0a9b141ad97c931bde49990b3308204ed34d5afb971d91a7::sipo {
    struct SIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPO>(arg0, 6, b"SIPO", b"SIPO SUI", x"245049504f207c2045737461626c697368696e672074686520686567656d6f6e79206f662074686520686970706f73200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pipo_D_Hs_O_Fq7_U_121541b6ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

