module 0xd7656b5029ae0a156ea6870d0f38e97220a142ff311241d421e67912ff1bc925::ifi {
    struct IFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFI>(arg0, 9, b"IFI", b"Hhh", b"Vxvxkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/22b1e049-ce7f-4f1a-b712-e0e0973ecb72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

