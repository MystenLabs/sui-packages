module 0x21417b307cf0d64bb61f4dad47b91b23248b5436bd46a28c4ec6cdc2cbee6696::hay {
    struct HAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAY>(arg0, 9, b"HAY", b"haa", b"ASDSAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5dd704c-fbdd-4a2d-8e5a-51539b0537f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

