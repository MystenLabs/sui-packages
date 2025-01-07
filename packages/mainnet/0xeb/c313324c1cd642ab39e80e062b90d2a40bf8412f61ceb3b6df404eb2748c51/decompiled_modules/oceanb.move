module 0xebc313324c1cd642ab39e80e062b90d2a40bf8412f61ceb3b6df404eb2748c51::oceanb {
    struct OCEANB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEANB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEANB>(arg0, 9, b"OCEANB", b"OCEANBANK ", b"Nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fab94f71-cd35-4cb5-adc0-a38e1fc08a78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEANB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEANB>>(v1);
    }

    // decompiled from Move bytecode v6
}

