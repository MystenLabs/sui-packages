module 0xb48d564a4527d7cc687b4c118d33de28fdce3239a547e982274a8c142c559242::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"Raysui", x"52617973756920686173207375726661636564210a546865206465657020736561206a75737420676f74204445455045522e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiezvpmgquvho6tv3h6iry4mj7wki677v7oh3jdvapoenbzw6qtrk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

