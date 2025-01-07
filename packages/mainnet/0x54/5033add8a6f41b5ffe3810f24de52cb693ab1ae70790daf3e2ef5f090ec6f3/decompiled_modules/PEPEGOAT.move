module 0x545033add8a6f41b5ffe3810f24de52cb693ab1ae70790daf3e2ef5f090ec6f3::PEPEGOAT {
    struct PEPEGOAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPEGOAT>, arg1: 0x2::coin::Coin<PEPEGOAT>) {
        0x2::coin::burn<PEPEGOAT>(arg0, arg1);
    }

    fun init(arg0: PEPEGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEGOAT>(arg0, 6, b"pepeGOAT", b"SuiGoats", b"https://twitter.com/SuiGoats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/FvgldtqaAAA1y14?format=jpg&name=small")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEGOAT>>(v1);
        0x2::coin::mint_and_transfer<PEPEGOAT>(&mut v2, 10000000000000000000, 0x2::address::from_u256(113723033461549510598633151651152055397876219054315116070387240095774643430855), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEGOAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEGOAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPEGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

