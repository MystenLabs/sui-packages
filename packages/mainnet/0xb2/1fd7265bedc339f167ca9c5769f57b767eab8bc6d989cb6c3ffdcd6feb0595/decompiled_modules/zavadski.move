module 0xb21fd7265bedc339f167ca9c5769f57b767eab8bc6d989cb6c3ffdcd6feb0595::zavadski {
    struct ZAVADSKI has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<ZAVADSKI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZAVADSKI>>(arg0, arg1);
    }

    fun init(arg0: ZAVADSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAVADSKI>(arg0, 9, b"ZAVADSKI", b"Andrei", b"TEST Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w.forfun.com/fetch/95/95d31ed3228d6828a5a8f9f27cf242b0.jpeg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ZAVADSKI>(&mut v2, 10000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAVADSKI>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAVADSKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

