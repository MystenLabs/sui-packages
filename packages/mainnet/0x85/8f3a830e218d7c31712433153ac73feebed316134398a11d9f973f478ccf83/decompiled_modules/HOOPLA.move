module 0x858f3a830e218d7c31712433153ac73feebed316134398a11d9f973f478ccf83::HOOPLA {
    struct HOOPLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOPLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOPLA>(arg0, 8, b"HOOPLA", b"Sui Hoopla", b"Hoopla Hoopla Hoopla Hoopla Hoopla Hoopla Hoopla Hoopla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmbaeFqrfLctbxne2qp5emfagb12aFkZbpRoex5p9RRhJS?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOOPLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HOOPLA>>(0x2::coin::mint<HOOPLA>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HOOPLA>>(v2);
    }

    // decompiled from Move bytecode v6
}

