module 0x1c3519ab3aebd02acbf6c9699979bffe0bf97ae634845c411226fd9c3890d4cb::lolol {
    struct LOLOL has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<LOLOL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOLOL>>(arg0, arg1);
    }

    fun init(arg0: LOLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLOL>(arg0, 9, b"LOLOL", b"LOL", b"EEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"WWW")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<LOLOL>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLOL>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

