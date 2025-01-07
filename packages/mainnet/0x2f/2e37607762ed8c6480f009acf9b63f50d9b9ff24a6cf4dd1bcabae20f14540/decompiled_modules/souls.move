module 0x2f2e37607762ed8c6480f009acf9b63f50d9b9ff24a6cf4dd1bcabae20f14540::souls {
    struct SOULS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOULS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOULS>(arg0, 9, b"SOULS", b"Soul", b"Soul joy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e3ab818-b592-4a71-8e9d-94340d86854f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOULS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOULS>>(v1);
    }

    // decompiled from Move bytecode v6
}

