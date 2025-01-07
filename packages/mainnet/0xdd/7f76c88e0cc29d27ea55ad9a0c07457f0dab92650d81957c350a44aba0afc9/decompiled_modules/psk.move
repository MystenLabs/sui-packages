module 0xdd7f76c88e0cc29d27ea55ad9a0c07457f0dab92650d81957c350a44aba0afc9::psk {
    struct PSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSK>(arg0, 9, b"PSK", b"Pashka", b"My lovely boy will be greatest man in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bdb559d-2385-4448-91c4-1b7fe253f8d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

