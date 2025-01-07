module 0xc426576cd50cebd37dba724f6be9cfbe10b9ced83bd5cd956df7feb0b6d20c74::ant {
    struct ANT has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<ANT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ANT>>(arg0, arg1);
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANT>(arg0, 9, b"ANT", b"Antalya", b"holidays token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"QmNwEp952DJAxnNZmomd6VuwpGyo4x5q88qg8eSXdpxTb8")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ANT>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANT>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

