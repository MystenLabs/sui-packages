module 0xb7bd24b936068894fddfa3aa89db2ba636a91087346ea1a525a81d079e5994a7::MOXU {
    struct MOXU has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOXU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<MOXU>(arg0) + arg1 <= 10000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOXU>>(0x2::coin::mint<MOXU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOXU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOXU>(arg0, 6, b"MOXU", b"MOXU", b"MOXU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/thumbs/mxc.png?v=040")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MOXU>>(0x2::coin::mint<MOXU>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOXU>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOXU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

