module 0xc746b365e98e927b9bddd2c48a9bc4149d63c4d266c3aa2a8c8615750ee29183::acat {
    struct ACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACAT>(arg0, 6, b"Acat", b"Apple Cat", x"4920616d206a757374206120636174207468617420676f7420737475636b20696e20616e206170706c650a7c204e6f2c206920646f6e27742077616e7420746f2074616c6b2061626f757420697420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vsntjr_J_400x400_fcf8910fc1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

