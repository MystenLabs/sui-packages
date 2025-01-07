module 0xf0010f92245e81b1306a36fca6d3102b7ff206f764a3fb12165f68b2cf3064b6::rwt {
    struct RWT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RWT>, arg1: 0x2::coin::Coin<RWT>) {
        0x2::coin::burn<RWT>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<RWT>, arg1: &mut 0x2::coin::Coin<RWT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<RWT>(arg0, 0x2::coin::split<RWT>(arg1, arg2, arg3));
    }

    fun init(arg0: RWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWT>(arg0, 6, b"RWT", b"RevaLink Wallet Token", b"RevaLink Wallet Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.coinranking.com/xWgEEexAr/REV.PNG"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RWT>(&mut v2, 500000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RWT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

