module 0x15e80a48954835421ca85d0ea2832a9e2dd5ee6a6790a049a0059e82ff9a4218::priceless {
    struct PRICELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRICELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRICELESS>(arg0, 9, b"PRICELESS", x"5472e1bb8d6e6720536d696c", b"Trustnone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5990c83a-a364-4368-a126-0b3aa76d6408.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRICELESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRICELESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

