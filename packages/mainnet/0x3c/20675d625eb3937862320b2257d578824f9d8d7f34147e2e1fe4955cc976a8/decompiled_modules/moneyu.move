module 0x3c20675d625eb3937862320b2257d578824f9d8d7f34147e2e1fe4955cc976a8::moneyu {
    struct MONEYU has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MONEYU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<MONEYU>(arg0) + arg1 <= 1290000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MONEYU>>(0x2::coin::mint<MONEYU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MONEYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONEYU>(arg0, 6, b"MONEYU", b"MONEYU", b"MONEYU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hk.tpstatic.net/token/tokenpocket-1617347664664.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MONEYU>>(0x2::coin::mint<MONEYU>(&mut v2, 1290000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEYU>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONEYU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

