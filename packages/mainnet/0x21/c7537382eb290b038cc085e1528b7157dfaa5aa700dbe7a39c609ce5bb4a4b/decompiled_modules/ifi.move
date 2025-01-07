module 0x21c7537382eb290b038cc085e1528b7157dfaa5aa700dbe7a39c609ce5bb4a4b::ifi {
    struct IFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFI>(arg0, 9, b"IFI", b"Hhh", b"Vxvxkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c79f49a-09d3-4b29-88e0-c9938962686d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

