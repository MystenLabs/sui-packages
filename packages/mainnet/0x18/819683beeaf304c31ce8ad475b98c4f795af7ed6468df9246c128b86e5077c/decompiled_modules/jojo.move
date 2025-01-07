module 0x18819683beeaf304c31ce8ad475b98c4f795af7ed6468df9246c128b86e5077c::jojo {
    struct JOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOJO>(arg0, 9, b"JOJO", b"Joje", b"Just fon to wave wallet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a01e1f4-adad-49c2-b4fa-8bbb45b5f816.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

