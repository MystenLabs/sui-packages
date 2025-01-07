module 0x97fda866911f3620df1cf0d8855427c1567d9b07edcc2595433719aa85e8627b::oodnb {
    struct OODNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OODNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OODNB>(arg0, 9, b"OODNB", b"jekwne", b"hsbsb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18fbb629-0b56-433c-b569-5ea04ecd6944.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OODNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OODNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

