module 0xaadbcd82170d24c251925ea9dacbfd7f8bfaf1c5c684e409f1a3bbc6cab43f21::gdsg {
    struct GDSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSG>(arg0, 9, b"GDSG", b"SDGDSA", b"GVSSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b66064ee-f348-4269-951e-06ffe7d44180.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

