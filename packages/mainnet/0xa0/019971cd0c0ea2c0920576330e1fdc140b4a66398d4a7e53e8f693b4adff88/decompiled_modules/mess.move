module 0xa0019971cd0c0ea2c0920576330e1fdc140b4a66398d4a7e53e8f693b4adff88::mess {
    struct MESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESS>(arg0, 6, b"Mess", b"Messiah", b"The messiah who will save sui has come", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiavbhmlbpalzzowxy3qjvmqtor4k32z6ircopg3smekz6bw762xsy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MESS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

