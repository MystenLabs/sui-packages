module 0xb94ef9c53711a00a587fd7a3151e26ec361375fcb4f93c836bbf7309fe8761a0::victory {
    struct VICTORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VICTORY>(arg0, 9, b"VICTORY", b"Victory", b"Victory over evil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84f05e85-8bd9-4d76-b94b-8f9fbaf97034.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICTORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICTORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

