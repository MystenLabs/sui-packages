module 0x384e7e224283ce615850cd39c22996489bd59af5b4ad9b577fea1ded2c71afad::starchu {
    struct STARCHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARCHU>(arg0, 6, b"STARCHU", b"Starwarchu On Sui", b"The First Stars War pokemon battle on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieocmib4ehiqb63bqvrzqepspgofjce6ol2ql33apiv5leqml2mw4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARCHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STARCHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

