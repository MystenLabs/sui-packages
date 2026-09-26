module 0x2f4b87b08150e275602e9def412c29c0b08bb01b3e17172ff5c6b6f780ead5b::cwif {
    struct CWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWIF>(arg0, 6, b"CWIF", b"Cabbage Wif Cat", b"Cat with Cabbage wif hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1790422477882.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

