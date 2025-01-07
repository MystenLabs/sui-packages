module 0x852d4c6dd8fa6d03fc02901019c47e613223e961bdf986e1dc3e08140b004545::ifi {
    struct IFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFI>(arg0, 9, b"IFI", b"Hhh", b"Vxvxkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5f4ee75-295a-47e4-9640-327f2327b476.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

