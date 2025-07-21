module 0xcaa938ceef06b895e554d596c7d9bafb5d2591ce4356b995ed39dd254b8499be::chocky {
    struct CHOCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOCKY>(arg0, 6, b"Chocky", b"Chocky The Bird", x"43686f636b7920736565206a656574732e2043686f636b792061696d2e2043686f636b792073686f6f742e0a200a4a656574732072756e2e2043686f636b79207361792c204e6f2073656c6c2c206f6e6c7920666c792e0a456163682074696d652043486f636b79207468696e6b732061626f757420666164696e672043686f636b792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigspbi35wyplrv6vqukaa5unietmda7wp2ur23se67m7efgg3iqsi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHOCKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

