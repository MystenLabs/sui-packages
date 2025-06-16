module 0xd841754bc7d501815de14db728ab85faf699475113a268642fa86733f9297943::brock {
    struct BROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCK>(arg0, 6, b"BROCK", b"Trainer Brock", x"42524f434b206f6e20535549207c20204d656d6520506f776572207820436f6d6d756e69747920537472656e6774680a436c6f73656420657965732c206f70656e206761696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieck32vpuckl3wznk6r27wdf6l3kueg5je64sv3uljwf5q5cekyhq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BROCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

