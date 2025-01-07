module 0x2c150d8468fe75be6c0530cb51161a5f90b89aade8146951a20227decd636e41::city {
    struct CITY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CITY>, arg1: 0x2::coin::Coin<CITY>) {
        0x2::coin::burn<CITY>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<CITY>, arg1: &mut 0x2::coin::Coin<CITY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<CITY>(arg0, 0x2::coin::split<CITY>(arg1, arg2, arg3));
    }

    fun init(arg0: CITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CITY>(arg0, 6, b"CITY", b"CITY", b"Man City Fan Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/vi/thumb/1/1d/Manchester_City_FC_logo.svg/1200px-Manchester_City_FC_logo.svg.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CITY>(&mut v2, 500000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CITY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

