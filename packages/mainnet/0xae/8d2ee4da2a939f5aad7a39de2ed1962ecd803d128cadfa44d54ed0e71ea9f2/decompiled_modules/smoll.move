module 0xae8d2ee4da2a939f5aad7a39de2ed1962ecd803d128cadfa44d54ed0e71ea9f2::smoll {
    struct SMOLL has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<SMOLL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SMOLL>>(arg0, arg1);
    }

    fun init(arg0: SMOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOLL>(arg0, 9, b"SMOLL", b"Smoll", b"Smaller than a little", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"Smoll")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SMOLL>(&mut v2, 20000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOLL>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

