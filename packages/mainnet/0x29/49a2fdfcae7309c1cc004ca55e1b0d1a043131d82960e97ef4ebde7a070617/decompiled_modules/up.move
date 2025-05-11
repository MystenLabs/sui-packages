module 0x2949a2fdfcae7309c1cc004ca55e1b0d1a043131d82960e97ef4ebde7a070617::up {
    struct UP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP>(arg0, 6, b"UP", b"DoubleUp Moonbags", x"546865205072656d6965722042657474696e6720457870657269656e6365207c2024555020636f6d696e6720736f6f6e207c20486f6d65206f6620746865200a40436974697a656e7344656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4rqhrsk3pbxausbn3eyghlmzfwx6enwm3eitbwx5ylh4rtic54q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

