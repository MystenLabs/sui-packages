module 0x3ef1f0ae041952f51a67bf3ac3dc9eea35a82e8390e736f2958627395002c255::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCAT>(arg0, 9, b"POPCAT", b"Popcat", b"Popcat keeps on popping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea493a0a-38d2-4a2c-ad59-581ab69a816c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

