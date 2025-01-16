module 0xdc70afc39b002b2ac5db8c4ea9c532394b6a7745833b344410867c68e605cebf::bebyshek {
    struct BEBYSHEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBYSHEK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BEBYSHEK>(arg0, 6, b"BEBYSHEK", b"Bebyshrek by SuiAI", x"426562c3aa20736872656b20666f66696e686f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6820_2790cce129.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEBYSHEK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBYSHEK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

