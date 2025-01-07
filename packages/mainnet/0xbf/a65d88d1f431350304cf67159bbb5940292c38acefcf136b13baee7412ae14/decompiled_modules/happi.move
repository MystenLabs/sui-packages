module 0xbfa65d88d1f431350304cf67159bbb5940292c38acefcf136b13baee7412ae14::happi {
    struct HAPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPI>(arg0, 9, b"HAPPI", b"Happines", b"Lets spread happynes in sui Exocistem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/887fcf18-b346-4234-bb6e-5354f57fc0a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

