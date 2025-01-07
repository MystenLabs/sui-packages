module 0xeda2faabc1a220ec866d9d268d6729e847c9e5e15c018a76d8948d80767f243b::bibkatlr {
    struct BIBKATLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBKATLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBKATLR>(arg0, 9, b"BIBKATLR", b"Bibka", b"Bibka can bio bip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1490252-21e2-467e-8561-d21e352faaf7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBKATLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBKATLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

