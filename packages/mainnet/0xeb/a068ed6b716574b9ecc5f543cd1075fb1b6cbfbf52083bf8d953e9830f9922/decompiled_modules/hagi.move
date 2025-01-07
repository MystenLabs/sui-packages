module 0xeba068ed6b716574b9ecc5f543cd1075fb1b6cbfbf52083bf8d953e9830f9922::hagi {
    struct HAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGI>(arg0, 9, b"HAGI", b"Rahagi", b"Rahagi token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0bfdb7c-c74f-4a52-a3c6-e308b6384daa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

