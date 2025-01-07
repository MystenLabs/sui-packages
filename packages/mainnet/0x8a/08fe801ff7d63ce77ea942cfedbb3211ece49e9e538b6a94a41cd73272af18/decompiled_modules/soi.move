module 0x8a08fe801ff7d63ce77ea942cfedbb3211ece49e9e538b6a94a41cd73272af18::soi {
    struct SOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOI>(arg0, 9, b"SOI", b"Soii", b"Soii token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc0badbb-c183-4977-8398-31e4a07754d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

