module 0x93c9d71c3072f6bdf686527d13b7467defdf7a44626566b6a0af1e7a55ea1b74::CPYT {
    struct CPYT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CPYT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<CPYT>(arg0) + arg1 <= 1000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<CPYT>>(0x2::coin::mint<CPYT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CPYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPYT>(arg0, 6, b"CPYT", b"CPYT", b"CPYT Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ens.suiscan.xyz/uploads/posts/2023-01/thumbs/citadel.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<CPYT>>(0x2::coin::mint<CPYT>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPYT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CPYT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

