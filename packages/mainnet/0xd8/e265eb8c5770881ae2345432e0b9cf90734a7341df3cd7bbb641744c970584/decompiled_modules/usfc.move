module 0xd8e265eb8c5770881ae2345432e0b9cf90734a7341df3cd7bbb641744c970584::usfc {
    struct USFC has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USFC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<USFC>(arg0) + arg1 <= 100290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USFC>>(0x2::coin::mint<USFC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USFC>(arg0, 6, b"USFC", b"USFC", b"USFC Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://archive.cetus.zone/assets/image/sui/pyth.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USFC>>(0x2::coin::mint<USFC>(&mut v2, 100290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USFC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USFC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

