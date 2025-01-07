module 0x824c56f6bbee9d57283ad3a5f9c96c9b0095e50ca49bdb93232cf30afd1e0095::bms {
    struct BMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMS>(arg0, 9, b"BMS", b"BANHMI", b"This coin was created when I was hungry and thinking about Vietnamese food.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9369c349-c151-4c93-9d1e-918372e1ab8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

