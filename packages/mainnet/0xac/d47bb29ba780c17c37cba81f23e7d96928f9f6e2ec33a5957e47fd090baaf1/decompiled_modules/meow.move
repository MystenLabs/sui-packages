module 0xacd47bb29ba780c17c37cba81f23e7d96928f9f6e2ec33a5957e47fd090baaf1::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"Meowsmith", b"A fortress of conspiracy secrets. $MEOW token community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidktm4rgj5pvrx4snk4lbeogplcj7zozl64pivlkknzbuazkxov5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

