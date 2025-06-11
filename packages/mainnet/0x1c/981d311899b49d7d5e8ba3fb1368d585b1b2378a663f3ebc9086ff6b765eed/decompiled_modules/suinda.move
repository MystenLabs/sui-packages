module 0x1c981d311899b49d7d5e8ba3fb1368d585b1b2378a663f3ebc9086ff6b765eed::suinda {
    struct SUINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINDA>(arg0, 6, b"SUINDA", b"SUINDAQUIL", b"suinda-suinda!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqzcbu3v63lvrjmrypzsdpjzcdk57gq5pq237ez73ze4iyfjdt7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

