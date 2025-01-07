module 0xad134131053231843470b75cc3b9dd72ed3936467a73bd210fe8de2f4b9dba91::suisink {
    struct SUISINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISINK>(arg0, 6, b"SUISINK", b"SuiSink", b"I've decided instead of running for office. I'll just install a Sink in the Oval office. The real power move.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbraz_RVW_8_A_Em_BOK_1924301ce0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

