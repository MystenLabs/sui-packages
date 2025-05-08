module 0x40ff88bc931d8be0434bfe4a06f4d72f99d9b42bf1be59dad1fa6d5dfe31d193::zdsd {
    struct ZDSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZDSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZDSD>(arg0, 6, b"ZDSD", b"eazeaz", b"EZSZEEZEQSZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiazih3dbyztun5memxlsqrf6xh5cx2bfeabd2isenyuatawhqvebq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZDSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZDSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

