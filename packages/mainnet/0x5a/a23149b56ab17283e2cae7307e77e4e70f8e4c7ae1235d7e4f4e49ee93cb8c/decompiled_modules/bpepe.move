module 0x5aa23149b56ab17283e2cae7307e77e4e70f8e4c7ae1235d7e4f4e49ee93cb8c::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BPEPE>(arg0, 6, b"BPEPE", b"BlackPEPE by SuiAI by SuiAI", b"We spent 4 days sculpting the Black Pepe by SuiAI, turning it into more than just a meme. It's a symbol. $BPEPE is here, to get backed by a community that celebrates this masterpiece. Marlboro in hand, Pepe's legacy lives on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/333_adac609532.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BPEPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

