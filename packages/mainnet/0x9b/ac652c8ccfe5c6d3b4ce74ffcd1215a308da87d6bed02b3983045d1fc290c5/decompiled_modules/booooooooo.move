module 0x9bac652c8ccfe5c6d3b4ce74ffcd1215a308da87d6bed02b3983045d1fc290c5::booooooooo {
    struct BOOOOOOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOOOOOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOOOOOOOO>(arg0, 6, b"Booooooooo", b"Booo", b"Get ready to be spooked!  Introducing booo, the new spooky meme coin on the Sui blockchain. Join the booo community and be a part of the spookiest meme coin on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732303719194.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOOOOOOOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOOOOOOOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

