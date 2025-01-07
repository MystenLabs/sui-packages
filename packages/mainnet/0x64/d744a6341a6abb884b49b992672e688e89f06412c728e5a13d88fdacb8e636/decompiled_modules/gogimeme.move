module 0x64d744a6341a6abb884b49b992672e688e89f06412c728e5a13d88fdacb8e636::gogimeme {
    struct GOGIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGIMEME>(arg0, 9, b"GOGIMEME", b"Gogi Meme ", b"Gogi Meme Is Project based on Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/daf24dbe-9dae-464c-8693-468786a3c6c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

