module 0xd8f441e4558e84667f10ab562840b6ed241179d4dd32b891610064e84c9282e2::bibkatlr {
    struct BIBKATLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBKATLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBKATLR>(arg0, 9, b"BIBKATLR", b"Bibka", b"Bibka can bio bip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ee203aa-46a1-4599-8fb5-bb2346b864ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBKATLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBKATLR>>(v1);
    }

    // decompiled from Move bytecode v6
}

