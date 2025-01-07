module 0xdab5dad5875161c667d068bcee825238651bd78c73eeb2f1b5a21d47e76da7c7::source {
    struct SOURCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOURCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOURCE>(arg0, 6, b"SOURCE", b"Source Agents", x"536f75726365204167656e74732028534f55524345290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmef_Xa_Qnmfu_Qu7o91_Wy_Jfrt_A71_C5_A1_ZS_2bcd6vj_Z1nbk5_W_3165a36004.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOURCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOURCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

