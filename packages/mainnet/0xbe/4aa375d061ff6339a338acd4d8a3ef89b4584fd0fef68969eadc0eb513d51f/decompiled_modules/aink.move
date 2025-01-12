module 0xbe4aa375d061ff6339a338acd4d8a3ef89b4584fd0fef68969eadc0eb513d51f::aink {
    struct AINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AINK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AINK>(arg0, 6, b"AINK", b"AInk Agent by SuiAI", b"AInk Agent create a new AI world on Sui Network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1219_B15_F_D39_C_4_BCA_AE_44_52_B41_D91298_C_fda370f497.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AINK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AINK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

