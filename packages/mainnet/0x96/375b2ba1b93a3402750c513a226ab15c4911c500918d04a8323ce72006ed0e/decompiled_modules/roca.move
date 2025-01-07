module 0x96375b2ba1b93a3402750c513a226ab15c4911c500918d04a8323ce72006ed0e::roca {
    struct ROCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCA>(arg0, 9, b"ROCA", b"Roca con", b"Rocaracoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53e4c8eb-3bf6-4d46-88fb-3f6fb2f883de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

