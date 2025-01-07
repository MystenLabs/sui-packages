module 0x3e4d84dd52ecc1f81a3f630dcd9a80352ae9c37ccbad0009e03f44be6729aaf0::axi {
    struct AXI has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<AXI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AXI>>(arg0, arg1);
    }

    fun init(arg0: AXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXI>(arg0, 9, b"AXI", b"AXI", b"AXI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"AA0")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<AXI>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXI>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

