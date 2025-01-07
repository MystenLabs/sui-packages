module 0x8ea6c6e54ba613d2d992efc7ff81f042c0911cfe0b86a9cef62dc49503c232bc::dee {
    struct DEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEE>(arg0, 9, b"DEE", b"desert", x"7761726d20616e642062656175746966756c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3886fc69-7cb6-43d4-bb68-ceec28d33664.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

