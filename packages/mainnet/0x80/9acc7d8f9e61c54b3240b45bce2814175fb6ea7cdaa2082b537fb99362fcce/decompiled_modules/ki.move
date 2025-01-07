module 0x809acc7d8f9e61c54b3240b45bce2814175fb6ea7cdaa2082b537fb99362fcce::ki {
    struct KI has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<KI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KI>>(arg0, arg1);
    }

    fun init(arg0: KI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KI>(arg0, 9, b"KI", b"ki", b"kio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiexplorer.com/txblock/552Rwv3nJCZh1nHvCVLnkawFjmwoa1S7H4TVdPD13qRg?network=mainnet")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<KI>(&mut v2, 555000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KI>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KI>>(v1);
    }

    // decompiled from Move bytecode v6
}

