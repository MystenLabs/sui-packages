module 0xb2b1b9e654e4eeeb84d20e8c37c8d13ddd46bd9a3819c3c029a82030e58ce851::ganesh {
    struct GANESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANESH>(arg0, 9, b"GANESH", b"Fire", b"Hugh ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4fd1fb60-86ed-4e2e-a9aa-58e63cd70367.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GANESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

