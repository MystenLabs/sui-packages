module 0xf0d1fdb49d8a9bc1cc4a7c0c138852e51d094d60ae617d599d17506c00e27337::smill {
    struct SMILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILL>(arg0, 6, b"SMILL", b"Sui Millionaire", b"Sui Millionaire is the meme-fueled golden ticket to the top on the Sui blockchain - created for degens, dreamers, and future millionaires who believe that the next wealth wave starts right here. $SMILL aims to turn loyal hodlers into legends. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749535536570.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

