module 0xf06ca6274e3fd4592a012a710483210690d960d9832afdba2f17c508bf19dc1e::jt {
    struct JT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JT>(arg0, 9, b"JT", b"JETT", b"Jett Valorant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcbd8086-679b-49ce-b83c-4f3aef7239b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JT>>(v1);
    }

    // decompiled from Move bytecode v6
}

