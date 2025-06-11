module 0x6fb18cc7d910177d42c7879dc41c89831015048d134486c525a226ef1c33249b::pgg {
    struct PGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGG>(arg0, 6, b"PGG", b"POKEMONGO", x"506f6b656d6f6e20476f206973206120736d61727470686f6e652067616d65207468617420757365732047505320746563686e6f6c6f677920616e64204175676d656e746564205265616c69747920746f20636174636820616e6420747261696e20506f6bc3a96d6f6e2063686172616374657273207768696c6520706c6179657273206578706c6f726520746865207265616c20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia7dwwaarjbvlcpt5tcws6jdn3ztliq6ys35c6t622xceiwcqdcia")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PGG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

