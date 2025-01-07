module 0xefad1862e2b46ca53b12cc4ae9661380e242a5688f90a64ce9bc5416d96cd941::poptrump {
    struct POPTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTRUMP>(arg0, 6, b"POPTRUMP", b"POP TRUMP", x"706f7020706f7020706f7020706f7020706f7020706f700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y_Va_SZ_Mp3fd8nd_P861_UJP_Da9_A24_Gaqrcn_Hrn4_Mbj3_Js_Ff_7a16343d38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

