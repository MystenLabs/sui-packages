module 0x4fa02f5882e894c729c801f02b4247eab61a599105a48cd23957a1185b0c59c::mil {
    struct MIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIL>(arg0, 9, b"MIL", b"mill", b"Grind out success with MillCoin: The industrious cryptocurrency that's powering through the market, delivering grain-by-grain profits and building a solid foundation for your portfolio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d8027c3-7183-465b-84d6-55f445257c94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

