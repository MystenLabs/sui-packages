module 0x4a28f008f761194e3d8211b959f46549f4a0ae03f34aa09f13825138cfef2082::tittit {
    struct TITTIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITTIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITTIT>(arg0, 9, b"TITTIT", b"TITIT", b"THIS THAT DO YOUR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/671a067b-f22a-4bed-a583-fe2e6f6eb253.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITTIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITTIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

