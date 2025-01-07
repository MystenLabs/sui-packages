module 0xce65c81537a41677406701f6b73dc7487d2c286d06416fc92db1b1a8d7ffa426::tomwe {
    struct TOMWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMWE>(arg0, 9, b"TOMWE", b"Not WEWE", b"You don't like WEWE, you like TOMWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/325c642c-9411-4570-b406-e09b8b992039.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

