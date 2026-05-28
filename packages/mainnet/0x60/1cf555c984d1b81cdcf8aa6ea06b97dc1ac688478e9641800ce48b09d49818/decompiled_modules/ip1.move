module 0x601cf555c984d1b81cdcf8aa6ea06b97dc1ac688478e9641800ce48b09d49818::ip1 {
    struct IP1 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IP1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<IP1>>(0x2::coin::mint<IP1>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IP1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IP1>(arg0, 9, b"ip1", b"ip1", b"ip1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ip1.app/favicon.ico")), arg1);
        let v2 = v0;
        if (1000000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<IP1>>(0x2::coin::mint<IP1>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IP1>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IP1>>(v1);
    }

    // decompiled from Move bytecode v7
}

