module 0xb2e8c1a2e93059fdc21382eebca5730fe7821f148a3c0ee79f8f8ca5f6ec7d84::priceless {
    struct PRICELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRICELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRICELESS>(arg0, 9, b"PRICELESS", x"5472e1bb8d6e6720536d696c", b"Trustnone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c7b0001-03a7-4e8a-ba5b-bfb1fb4caec0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRICELESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRICELESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

