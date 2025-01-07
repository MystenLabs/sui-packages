module 0x4a12466630d2f95183749268b69de287063df3e34c2f1692eb7c26b608ea3ee4::snx {
    struct SNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNX>(arg0, 9, b"SNX", b"Sanx", b"Sanx adalah coin buatan san", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d7ed023-c554-493e-8418-1b50a1be7aeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

