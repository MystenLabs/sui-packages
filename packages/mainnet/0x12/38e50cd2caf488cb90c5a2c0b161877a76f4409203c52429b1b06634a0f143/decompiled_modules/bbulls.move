module 0x1238e50cd2caf488cb90c5a2c0b161877a76f4409203c52429b1b06634a0f143::bbulls {
    struct BBULLS has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<BBULLS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BBULLS>>(arg0, arg1);
    }

    fun init(arg0: BBULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBULLS>(arg0, 9, b"BBULLS", b"Bouncing Bulls", b"Bouncing Bulls is a Bull coin holder, these coin will give great benefits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"www.cryptoporium.co.za")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<BBULLS>(&mut v2, 1000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBULLS>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBULLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

