module 0xa707e82200aeb6aa8c608b9c683b8c59271c8df51f7891f22c7f6b74f26d212a::not {
    struct NOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOT>(arg0, 6, b"NOT", b"Nothing", b"Only nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihvnr4mkeoz5xlbezrlfadss2mygqv2otl7y3lkmckimeojwzxuta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

