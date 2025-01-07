module 0x996ebcfd5c0719072b38f8b40a114c41aa735b41da1c055fa50fd6a28c7b0ade::sni {
    struct SNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNI>(arg0, 9, b"SNI", b"SuiNami", b"SuiNami was inspired by a vision of the Sui Blockchain taking the world by storm just like the Tsunami does when it starts to rage. We will definitely add some utilities, but for now, enjoy the Rage of a Sui take over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53a92cc5-bd51-46ee-9a41-96133cbea6c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

