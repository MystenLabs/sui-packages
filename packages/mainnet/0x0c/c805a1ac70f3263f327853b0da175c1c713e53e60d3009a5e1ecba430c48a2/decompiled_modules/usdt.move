module 0xcc805a1ac70f3263f327853b0da175c1c713e53e60d3009a5e1ecba430c48a2::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: 0x2::coin::Coin<USDT>) {
        0x2::coin::burn<USDT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"Tether USD", b"yulezhuanyong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.svgrepo.com/show/367256/usdt.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
        let v3 = &mut v2;
        mint(v3, 987654321000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

