module 0x97f8deb52713c24f3815cc5b26f693a069dd1ba40bcc0e9470f5cd7c6a0d8be8::ffffff {
    struct FFFFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFFFF>(arg0, 6, b"FFFFFF", b"fffff", b"dfsfsgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifk45wtw7kabk52pq7ephmzujqz3xb4n4f6hv7oolx4qmaeetky5a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FFFFFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

