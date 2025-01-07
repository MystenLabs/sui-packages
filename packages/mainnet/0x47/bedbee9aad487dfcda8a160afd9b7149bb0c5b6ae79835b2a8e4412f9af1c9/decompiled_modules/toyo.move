module 0x47bedbee9aad487dfcda8a160afd9b7149bb0c5b6ae79835b2a8e4412f9af1c9::toyo {
    struct TOYO has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<TOYO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TOYO>>(arg0, arg1);
    }

    fun init(arg0: TOYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOYO>(arg0, 9, b"TOYO", b"Toyota", b"Toyota", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"hhh")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TOYO>(&mut v2, 100000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOYO>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

