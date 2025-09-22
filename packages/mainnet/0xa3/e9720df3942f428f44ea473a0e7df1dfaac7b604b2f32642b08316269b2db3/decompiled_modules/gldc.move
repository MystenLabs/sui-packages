module 0xa3e9720df3942f428f44ea473a0e7df1dfaac7b604b2f32642b08316269b2db3::gldc {
    struct GLDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLDC>(arg0, 6, b"GLDC", b"GLDC", b"GLDC is a 1:1 gold backed token. 1 GLDC represents 1/1000 of 1 troy oz (31.1 grams) of 24kt gold. Deployed and managed by Buffalo Canyon Capital, LLC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNhBaQUFgPdnV9sRZmnBUERqqe88o9XbvVKRgZvAhddrg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

