module 0x8d69f0a8d6a9c3cccb9659db84793458b236ed138d83eab7ef02719bfb1434c3::wbc {
    struct WBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBC>(arg0, 9, b"WBC", b"WBConSUI", b"World Bitcoin Cash on SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4eeda55f-c85b-4944-a8ba-f8a3f696a735.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

