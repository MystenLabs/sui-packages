module 0x54f288fb692ce4c22a767ee15e87824543bd82fb993bef498eaada4857e75ccd::bananaai {
    struct BANANAAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BANANAAI>, arg1: 0x2::coin::Coin<BANANAAI>) {
        0x2::coin::burn<BANANAAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<BANANAAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BANANAAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BANANAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GpVjd94Wj19gJnMAHhh9ENViwezVYpy4Z5JEM5wuxCjB.png?size=lg&key=4ed1bd                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BANANAAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BANANAAI  ")))), trim_right(b"BANANA AI                       "), trim_right(x"68747470733a2f2f64642e64657873637265656e65722e636f6d2f64732d646174612f746f6b656e732f736f6c616e612f4770566a643934576a3139674a6e4d4148686839454e566977657a56597079345a354a454d35777578436a422e706e673f73697a653d6c67266b65793d3465643162640a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANANAAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BANANAAI>>(v5);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

