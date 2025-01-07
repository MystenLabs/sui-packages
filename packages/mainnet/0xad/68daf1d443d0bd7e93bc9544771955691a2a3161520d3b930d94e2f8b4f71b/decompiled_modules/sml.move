module 0xad68daf1d443d0bd7e93bc9544771955691a2a3161520d3b930d94e2f8b4f71b::sml {
    struct SML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SML>(arg0, 6, b"SML", b"Sui My Love", b"Sui My Love is a token launched on the Sui blockchain, designed to celebrate love and strengthen connections in the digital era. This token aims to not only integrate into the cryptocurrency ecosystem but also create a meaningful impact by promoting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732282026126.00")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SML>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SML>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

