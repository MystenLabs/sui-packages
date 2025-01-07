module 0x726f6ec0c605ae0904302b588eb505f637a90e296545a1fd920eea143c4c4bc::siak {
    struct SIAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIAK>(arg0, 9, b"SIAK", b"Siavashk", b"Best cati", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a93fc1e-4e06-4b2c-846f-de8790e4af16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

