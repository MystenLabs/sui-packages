module 0x6a7262eb92a6f076ea88e246e0730c2b8041f93b3480b08f4f66660d45933965::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"Walrus Protocol", b"Welcome to the next generation of data storage. Secure, efficient, and decentralized - walrus.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1823362179245953024/Cnn-5KzC_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAL>>(0x2::coin::mint<WAL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAL>>(v2);
    }

    // decompiled from Move bytecode v6
}

