module 0xf859f092cb1356f0c4514310a96b9fcfa9c5e8d5d9ff414694cb2a9c1a5b8927::pce {
    struct PCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCE>(arg0, 9, b"PCE", b"Peace", b"This is a God of David community project created for crypto currency expansion ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67f138e3-e4e4-485a-a5d1-8363a2a88044.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

