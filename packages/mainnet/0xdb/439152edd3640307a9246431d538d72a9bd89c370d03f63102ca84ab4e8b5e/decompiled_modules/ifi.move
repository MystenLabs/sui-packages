module 0xdb439152edd3640307a9246431d538d72a9bd89c370d03f63102ca84ab4e8b5e::ifi {
    struct IFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFI>(arg0, 9, b"IFI", b"Hhh", b"Vxvxkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2fa2c2c-4dc7-4fb1-80bb-bf33b8982c12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

