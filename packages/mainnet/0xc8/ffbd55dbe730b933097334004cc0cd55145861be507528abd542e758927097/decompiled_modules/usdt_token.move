module 0xc8ffbd55dbe730b933097334004cc0cd55145861be507528abd542e758927097::usdt_token {
    struct USDT_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<USDT_TOKEN>(arg0) + arg1 <= 1000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT_TOKEN>>(0x2::coin::mint<USDT_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT_TOKEN>(arg0, 6, b"USDT", b"Tether USD", b"USDT Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.okx.cab/cdn/web3/currency/token/137-0x1e4a5963abfd975d8c9021ce480b42188849d41d-1.png/type=default_350_0?v=1735291541821&x-oss-process=image/resize,m_lfit,w_100,h_100/ignore-error,1")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT_TOKEN>>(0x2::coin::mint<USDT_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDT_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

