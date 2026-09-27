module 0xd06635e971a7eccebc23eb3c8028db4de385cf76a51568c7790940dc3948a901::ese {
    struct ESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESE>(arg0, 6, b"ESE", b"eesee", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ESE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

