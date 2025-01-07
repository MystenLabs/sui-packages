module 0xf9203d5583f59b9de00bcc22b34ad00ed86ed653713f8bf326abe994f021b35f::wcgh {
    struct WCGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCGH>(arg0, 9, b"WCGH", b"WCGHT", b"MEME INSPIRED IS RANDOMLY OF CUTIES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3516c32-e097-49de-b323-f3823f30fd42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

