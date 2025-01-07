module 0xfcbe9de7b8129b461f84eb62c6762eb23e8248fccf4aeeddcf3ba5ba04f48da9::drp {
    struct DRP has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<DRP>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DRP>>(arg0, arg1);
    }

    fun init(arg0: DRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRP>(arg0, 9, b"DRP", b"DRIP", b"FIRST DRIP TOKEN IN SUI, POWERED BY INTEREST PROTOCOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/JCHcvsx")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<DRP>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRP>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

