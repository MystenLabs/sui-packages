module 0x8164e992299aba70af102bac66826dcd80e67de48ceab290f8bf3feb2dcce913::pisscoin {
    struct PISSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISSCOIN>(arg0, 6, b"Pisscoin", b"PissCoin", x"50697373636f696e206f6e207468652053756920576174657220436861696e20204c6971756964204173736574732c205265616c20466c6f772e0a4e6f205447207069737320696e20706561636520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5048_fdbf4c0acf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISSCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

