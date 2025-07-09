module 0x6bd55ea543e42802a6c612ea10240b7c378afad2c50b116c78d080bf584c6515::x1000 {
    struct X1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: X1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X1000>(arg0, 6, b"X1000", b"1000x On Sui", b"Sui x1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiciumaorjr6wces2qnbr7ypolu3pmbuk364fya4r2wgozzmyotdoi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X1000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<X1000>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

