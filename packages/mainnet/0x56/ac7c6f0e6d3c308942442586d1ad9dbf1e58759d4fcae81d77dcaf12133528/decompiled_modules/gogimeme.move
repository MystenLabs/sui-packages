module 0x56ac7c6f0e6d3c308942442586d1ad9dbf1e58759d4fcae81d77dcaf12133528::gogimeme {
    struct GOGIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGIMEME>(arg0, 9, b"GOGIMEME", b"Gogi Meme ", b"Gogi Meme Is Project based on Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/366b1646-aff9-414b-90e7-ed1c6f620dc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

