module 0x51c7982ad35e6d7d499563f66fe296d8c0b454c7992697990a5e75e9ebc2455a::brv {
    struct BRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRV>(arg0, 9, b"BRV", b"brave", b"BE BRAVE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db26370b-e024-4187-bdfe-ccea87f2a322.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRV>>(v1);
    }

    // decompiled from Move bytecode v6
}

