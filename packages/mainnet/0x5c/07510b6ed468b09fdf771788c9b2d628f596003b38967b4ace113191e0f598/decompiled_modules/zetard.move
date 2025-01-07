module 0x5c07510b6ed468b09fdf771788c9b2d628f596003b38967b4ace113191e0f598::zetard {
    struct ZETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZETARD>(arg0, 9, b"ZETARD", b"Sui Zombitardio", b"Meet Zombitardio... After a summer in the trenches without food or water and no sleep at all, $ZETARD turned into a retarded zombie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmT7pMXfHeobg1D5eBTStDVxbtn9x3GwWs9YCpxLbWCNJa?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZETARD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZETARD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

