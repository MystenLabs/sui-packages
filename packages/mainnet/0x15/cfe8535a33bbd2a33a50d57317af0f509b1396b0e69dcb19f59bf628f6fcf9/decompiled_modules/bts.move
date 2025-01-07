module 0x15cfe8535a33bbd2a33a50d57317af0f509b1396b0e69dcb19f59bf628f6fcf9::bts {
    struct BTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTS>(arg0, 9, b"BTS", b"Bitsui", b"Bitsui is the next Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc3d3a0a-f959-4d63-adff-9d3152e35b26-1000010106.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

