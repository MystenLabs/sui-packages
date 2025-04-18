module 0xff353171fc5053871f010041a2b30123d59c586d5f58d11b6c02e99f49e841c6::fag {
    struct FAG has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<FAG>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAG>>(arg0, arg1);
    }

    fun init(arg0: FAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAG>(arg0, 9, b"FAG", b"FearAndGreed", b"imple rule : sell when market greed, buy when market fear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"-")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<FAG>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAG>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

