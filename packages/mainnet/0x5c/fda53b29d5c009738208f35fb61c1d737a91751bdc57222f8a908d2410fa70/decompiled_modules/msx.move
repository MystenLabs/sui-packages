module 0x5cfda53b29d5c009738208f35fb61c1d737a91751bdc57222f8a908d2410fa70::msx {
    struct MSX has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<MSX>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MSX>>(arg0, arg1);
    }

    fun init(arg0: MSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSX>(arg0, 9, b"MSX", b"Maison", b"MaisonTokenOne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/j3oYM5a")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<MSX>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSX>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

