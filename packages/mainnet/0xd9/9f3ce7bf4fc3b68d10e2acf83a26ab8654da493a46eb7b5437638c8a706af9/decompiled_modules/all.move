module 0xd99f3ce7bf4fc3b68d10e2acf83a26ab8654da493a46eb7b5437638c8a706af9::all {
    struct ALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALL>(arg0, 6, b"all", b"allchains", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

