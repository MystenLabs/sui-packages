module 0x608421f86b1e6021b8cb9c2a12ff85cb7158875e0bf1abf01d832906693b9587::suiape {
    struct SUIAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE>(arg0, 6, b"SUIAPE", b"SUI APE", x"5468652061706520686173206573636170656420746865206f6c64206a756e676c652e0a4e6f77206865207377696e6773206f6e2074686520537569204e6574776f726b2c206661737465722c206c6f756465722c20616e642077696c646572207468616e20657665722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifbscrtuabti2ydzasityxtnllzptjs5n2vpy2cmfau37sfxn7dlq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

