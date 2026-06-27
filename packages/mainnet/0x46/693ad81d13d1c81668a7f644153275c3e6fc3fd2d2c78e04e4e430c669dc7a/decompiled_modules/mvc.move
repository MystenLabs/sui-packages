module 0x46693ad81d13d1c81668a7f644153275c3e6fc3fd2d2c78e04e4e430c669dc7a::mvc {
    struct MVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVC>(arg0, 6, b"MVC", b"Personal Fund", b"non la solita \"meme coin\" vuole rappresentare una parte del mio portafoglio di investimento sull'ecosistema Sui e i proventi sia del token e la gestione del mio portaglio portano ad incrementare posizioni in burn del token stesso e l'accumulo di XBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1782554970488.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MVC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

