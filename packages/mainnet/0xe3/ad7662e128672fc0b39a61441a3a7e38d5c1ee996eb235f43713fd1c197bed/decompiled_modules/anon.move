module 0xe3ad7662e128672fc0b39a61441a3a7e38d5c1ee996eb235f43713fd1c197bed::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 6, b"ANON", b"anoncast", x"506f737420616e6f6e796d6f75736c7920746f2046617263617374657220616e6420582f547769747465720a506f73747320617265206d61646520616e6f6e796d6f7573207573696e67207a6b2070726f6f66732e2044756520746f2074686520636f6d706c65782063616c63756c6174696f6e732072657175697265642c20697420636f756c642074616b6520757020746f206120666577206d696e7574657320746f20706f737420616e642074616b65206f7468657220616374696f6e732e205765276c6c20776f726b206f6e207370656564696e67207468697320757020696e20746865206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_23_170839_e72b32ab10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANON>>(v1);
    }

    // decompiled from Move bytecode v6
}

