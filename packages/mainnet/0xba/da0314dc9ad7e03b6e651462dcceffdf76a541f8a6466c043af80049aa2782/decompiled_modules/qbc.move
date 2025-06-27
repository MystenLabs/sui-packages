module 0xbada0314dc9ad7e03b6e651462dcceffdf76a541f8a6466c043af80049aa2782::qbc {
    struct QBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QBC>(arg0, 6, b"QBC", b"Queen blue cat", b"Im is queen blue cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiacqvstkv4mgsjfjmaj4frhos5inzl7a2gfvw5i4t3gbcl35amejm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QBC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

