module 0x14a342e752ddfc598104e8474b7e9dd1ce5012a53cd22d1ace6d01b27e5314a1::suih {
    struct SUIH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIH>>(0x2::coin::mint<SUIH>(arg0, arg1, arg3), arg2);
    }

    public(friend) fun create_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe(0x1::ascii::string(arg0))
    }

    fun init(arg0: SUIH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIH>(arg0, 9, b"SUIH", b"SUIHEAD", b"SUIH is the governance and utility token of suihDAO, with a fixed supply of 500,000 tokens. It incentivizes long-term holding through staking rewards (1-2% APY in CHOP) and voting rights on DAO decisions, distributions, and ecosystem growth. Liquidity is managed conservatively to prioritize commitment over speculation.", 0x1::option::some<0x2::url::Url>(create_url(b"https://chopsui.co/suih.jpg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 500000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

