module 0x67745fb95fa33bb9fa77012dcae6bfdaef9a4bffa20a2924c5b78a3652d0f9f6::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 6, b"SUIGAR", b"Suigar Saga", x"5375696761722053616761202824535549474152293a204469766520696e746f2061205765623320616476656e74757265206f6e207468652053756920626c6f636b636861696e2c20776865726520506f6bc3a96d6f6e2d7374796c65204e465420636f6c6c65637469626c65732c20746163746963616c2067616d65706c61792c20616e64207365616d6c65737320626c6f636b636861696e2074726164696e67206372656174652061206361707469766174696e6720657870657269656e636520666f7220636f6c6c6563746f727320616e6420706c61796572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiexmywxhisoo6mlcfkdfemz7mk2jkxmdrvlmzmk2ye5wn7w7tdyni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

