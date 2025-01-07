module 0xc406d976cb133a01421ca4e431183db848d9008e13192e2f620fd0fb6d0aa928::ifi {
    struct IFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFI>(arg0, 9, b"IFI", b"Hhh", b"Vxvxkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a20908f9-53a9-43ab-a43a-294195e8d98f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

