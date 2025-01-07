module 0xbc3e9db112918ec0409bfda2a0b57cc0e568e4156a49a5bdaf0f5da3978a9854::wacat {
    struct WACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WACAT>(arg0, 9, b"WACAT", b"WAWE", b"WAWE is a meme inspired by the sprit of adventure and freedom with WAWE. We are not just riding the waves- we are mastering them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b79a13b-5b94-4460-8e5c-fe9e41e1a5f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

