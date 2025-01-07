module 0xf7e3efa411b2f207935f1f781397c7806d07bc1c06fb86bad56cfff22bf981dd::wcgh {
    struct WCGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCGH>(arg0, 9, b"WCGH", b"WCGHT", b"MEME INSPIRED IS RANDOMLY OF CUTIES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fafcb1e4-2dc3-435d-8f3d-48796cacc426.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

