module 0x3e6301c892060fb78ca8ca1d0ac0600e801f8cecf83e946dd935169cb5996fe5::pepebull {
    struct PEPEBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEBULL>(arg0, 9, b"PEPEBULL", b"Pepe", b"Pepe to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67293e9f-a428-4fd2-8f5f-e1eea29a97f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

