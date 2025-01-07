module 0x1cc86d333251c7eb002e7b75c71e81e56812061534490a77ce63a96f3d4864d4::kirk {
    struct KIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRK>(arg0, 9, b"KIRK", b"Lazarus", b"Kirk Lazarus is the goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44ab0267-86f0-4613-b349-83ea21eb7e21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

