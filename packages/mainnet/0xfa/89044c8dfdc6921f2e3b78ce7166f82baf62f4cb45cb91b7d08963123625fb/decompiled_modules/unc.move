module 0xfa89044c8dfdc6921f2e3b78ce7166f82baf62f4cb45cb91b7d08963123625fb::unc {
    struct UNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNC>(arg0, 9, b"UNC", b"UNIC", b"UNIC for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23f8da2b-a540-4710-93ad-12863f509b6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

