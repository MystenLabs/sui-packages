module 0x13d88318eec67268528097f990cb43120ce0147ce7c7fb082f592663cef936de::esc {
    struct ESC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESC>(arg0, 6, b"ESC", b"ESCAPE", b"ESCAPE with us on SUI Get rich quick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733496991388.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

