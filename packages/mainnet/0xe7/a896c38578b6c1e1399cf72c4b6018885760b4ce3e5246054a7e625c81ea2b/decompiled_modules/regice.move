module 0xe7a896c38578b6c1e1399cf72c4b6018885760b4ce3e5246054a7e625c81ea2b::regice {
    struct REGICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REGICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGICE>(arg0, 6, b"REGICE", b"Regice On Sui", x"52454d454d42455220544845204c41535420313058200a594f55204d49535345443f204d4520544f4f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifatr2qbsabkgpckyuthkw7kpevxpy5jh5zjwkezy4y66zikacwyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REGICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

