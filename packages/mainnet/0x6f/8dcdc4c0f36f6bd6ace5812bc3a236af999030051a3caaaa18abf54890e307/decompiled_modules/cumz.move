module 0x6f8dcdc4c0f36f6bd6ace5812bc3a236af999030051a3caaaa18abf54890e307::cumz {
    struct CUMZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUMZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUMZ>(arg0, 9, b"CUMZ", b"Cummunism", b"Cummunism token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87535ef8-c46d-4cb6-8e59-1e881a8db2aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUMZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUMZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

