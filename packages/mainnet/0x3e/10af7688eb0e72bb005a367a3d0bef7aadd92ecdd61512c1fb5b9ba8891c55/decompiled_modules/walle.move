module 0x3e10af7688eb0e72bb005a367a3d0bef7aadd92ecdd61512c1fb5b9ba8891c55::walle {
    struct WALLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLE>(arg0, 6, b"WALLE", b"WALLERUS", b"Join the $WALLE Squad! Dive into the world of $WALLE, the FUNNIEST Walrus on SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieuml635aecsn235okosqii2omdcodrze5izaf6jpniniqa7vx6ey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

