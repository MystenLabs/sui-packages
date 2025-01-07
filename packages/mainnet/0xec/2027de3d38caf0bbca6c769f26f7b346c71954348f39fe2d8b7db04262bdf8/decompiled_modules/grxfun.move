module 0xec2027de3d38caf0bbca6c769f26f7b346c71954348f39fe2d8b7db04262bdf8::grxfun {
    struct GRXFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRXFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRXFUN>(arg0, 9, b"GRXFUN", b"GRX", x"5468652066616e20746f6b656e206f662074686520677265617465737420444a206f6620616c6c2074696d652c204d617274696e2047617272697820e29e95e29c96efb88ff09fa9b5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d78b9045-2f02-4473-aa10-b8ca2dfaa7a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRXFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRXFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

