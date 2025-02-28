module 0x86d2a84076213612b9efaeb249ccc026b649d73d9d57a62322bb5691391d1c79::DIU {
    struct DIU has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DIU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<DIU>(arg0) + arg1 <= 1000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<DIU>>(0x2::coin::mint<DIU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIU>(arg0, 6, b"DIU", b"DIU", b"DIU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon.suntool.cc/file/divi.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DIU>>(0x2::coin::mint<DIU>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIU>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

