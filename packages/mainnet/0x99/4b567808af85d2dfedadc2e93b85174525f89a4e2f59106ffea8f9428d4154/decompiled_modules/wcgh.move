module 0x994b567808af85d2dfedadc2e93b85174525f89a4e2f59106ffea8f9428d4154::wcgh {
    struct WCGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCGH>(arg0, 9, b"WCGH", b"WCGHT", b"MEME INSPIRED IS RANDOMLY OF CUTIES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a178c3f1-1906-40a7-87e6-29c063e9f5ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

