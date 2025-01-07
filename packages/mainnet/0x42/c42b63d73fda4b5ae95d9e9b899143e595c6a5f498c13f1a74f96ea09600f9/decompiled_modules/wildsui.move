module 0x42c42b63d73fda4b5ae95d9e9b899143e595c6a5f498c13f1a74f96ea09600f9::wildsui {
    struct WILDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILDSUI>(arg0, 6, b"WS", b"WildSui", b"WildSui - The Wildest Meme Token on the Sui Blockchain! www.wildsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wildsui.com/coinlogo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WILDSUI>>(0x2::coin::mint<WILDSUI>(&mut v2, 25000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WILDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILDSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

