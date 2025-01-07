module 0xf40aec6d3f0b77f395cdb2d1db942ab15babb66f9be8d7b3909875d16c84a607::golfgle {
    struct GOLFGLE has drop {
        dummy_field: bool,
    }

    public entry fun update_description<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String) {
        0x2::coin::update_description<T0>(arg0, arg1, arg2);
    }

    public entry fun update_icon_url<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<T0>(arg0, arg1, arg2);
    }

    public entry fun update_symbol<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<T0>(arg0, arg1, arg2);
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<GOLFGLE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLFGLE>>(arg0, arg1);
    }

    fun init(arg0: GOLFGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLFGLE>(arg0, 9, b"GOLFGLE", b"golfgle", b"A coin made on Interest Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suins.io/auction/golfgle.sui/")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<GOLFGLE>(&mut v2, 9990000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLFGLE>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLFGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

