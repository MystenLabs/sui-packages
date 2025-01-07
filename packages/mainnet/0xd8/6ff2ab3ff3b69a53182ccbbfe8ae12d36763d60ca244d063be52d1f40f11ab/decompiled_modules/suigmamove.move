module 0xd86ff2ab3ff3b69a53182ccbbfe8ae12d36763d60ca244d063be52d1f40f11ab::suigmamove {
    struct SUIGMAMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGMAMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMAMOVE>(arg0, 6, b"SUIGMAMOVE", b"SUIGMA", b"Swims alone, but never sinks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_17_023922664_578aeb3033.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMAMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGMAMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

