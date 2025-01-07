module 0xc849294252f35505e877fd7e953ab55aa0eb3c83a6ed0bf0b987d53fc3fb96cf::ying {
    struct YING has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<YING>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YING>>(arg0, arg1);
    }

    fun init(arg0: YING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YING>(arg0, 9, b"YING", b"Ying", b"ef4f4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"2r32r")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<YING>(&mut v2, 20434000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YING>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YING>>(v1);
    }

    // decompiled from Move bytecode v6
}

