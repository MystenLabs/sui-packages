module 0x2853672af5dcc6b1219a1667d525357fdef5b7afbb93fe09f7112867f7085b74::BADINU {
    struct BADINU has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<BADINU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BADINU>>(arg0, arg1);
    }

    fun init(arg0: BADINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADINU>(arg0, 4, b"BADINU", b"Bad Inu", b"Where Other Memecoins Come to Die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmd22Frhm2p1yTuYPq6b5VAo9gV21pX1dCtg1x5qbDEQEN"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BADINU>>(v1, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add);
        0x2::coin::mint_and_transfer<BADINU>(&mut v2, 5000000000000000000, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADINU>>(v2, @0x1620bc616589bd3c5630acb77a7276db1c87ce26deef920aabb3cfd6c2225add);
    }

    public entry fun transfer_metadata(arg0: 0x2::coin::CoinMetadata<BADINU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BADINU>>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<BADINU>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADINU>>(arg0, arg1);
    }

    public entry fun update_coin_description(arg0: &0x2::coin::TreasuryCap<BADINU>, arg1: &mut 0x2::coin::CoinMetadata<BADINU>, arg2: 0x1::string::String) {
        0x2::coin::update_description<BADINU>(arg0, arg1, arg2);
    }

    public entry fun update_coin_name(arg0: &0x2::coin::TreasuryCap<BADINU>, arg1: &mut 0x2::coin::CoinMetadata<BADINU>, arg2: 0x1::string::String) {
        0x2::coin::update_name<BADINU>(arg0, arg1, arg2);
    }

    public entry fun update_coin_symbol(arg0: &0x2::coin::TreasuryCap<BADINU>, arg1: &mut 0x2::coin::CoinMetadata<BADINU>, arg2: 0x1::ascii::String) {
        0x2::coin::update_symbol<BADINU>(arg0, arg1, arg2);
    }

    public entry fun update_coin_url(arg0: &0x2::coin::TreasuryCap<BADINU>, arg1: &mut 0x2::coin::CoinMetadata<BADINU>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<BADINU>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

