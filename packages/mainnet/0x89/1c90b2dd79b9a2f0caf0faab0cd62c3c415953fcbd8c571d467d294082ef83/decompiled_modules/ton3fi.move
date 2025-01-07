module 0x891c90b2dd79b9a2f0caf0faab0cd62c3c415953fcbd8c571d467d294082ef83::ton3fi {
    struct TON3FI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TON3FI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TON3FI>(arg0, 9, b"TON3FI", b"TON3FI mem", b"9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/306677d2-5505-4f1c-b903-a9c307922050.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TON3FI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TON3FI>>(v1);
    }

    // decompiled from Move bytecode v6
}

