module 0x2665aa0947582ffa88dd2de670d1b447cd3e8097b9e086ac44c03c5feec1e62d::ttok {
    struct TTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTOK>(arg0, 6, b"TTOK", b"Testo Token", b"Testo Token a beautiful token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibdbcozb5tnzebis7a4qgvlu7j22qrjz7yy5tl6wqyc7h22iit6pu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTOK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

