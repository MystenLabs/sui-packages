module 0xe6d17ec702274fc4bb0ac71c8a675a38eb66cc00410409c2b56e41119bfb848::swif {
    struct SWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIF>(arg0, 9, b"SWIF", b"SUIDWIFHAT", b"Dogwifhat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a0f311d-1c94-40cc-9043-f5f5c55a9d57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

