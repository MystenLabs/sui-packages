module 0x575cc64bd7e116d4d91ba8c787b9a7459fce9e3977f517e24d09ac11d2009d0c::zai {
    struct ZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAI>(arg0, 9, b"ZAI", b"Zainab ", b"Zaitoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7612015-44ec-4518-8e8a-d2b84d9b2fcd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

