module 0x53dede738628c2df01b50c3508e7e765ed960d8c7f4019b922902847c245336c::bnby {
    struct BNBY has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<BNBY>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BNBY>>(arg0, arg1);
    }

    fun init(arg0: BNBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNBY>(arg0, 9, b"BNBY", b"Binance Yours", b"A coin made on Interest Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.creativefabrica.com/wp-content/uploads/2021/06/14/Cryptocurrency-Binance-Logo-Graphics-13393898-1.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BNBY>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNBY>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

