module 0xbd882ad1af96056d8a58b7569ff25be68951bf6062bad3e871bfbb6a0f933715::mcd {
    struct MCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCD>(arg0, 9, b"MCD", b"Mc donalds", b"Cske", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9c13d23-dd4d-4538-b1e7-4363bd8d4eb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

