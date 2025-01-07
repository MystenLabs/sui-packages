module 0xd2f747d29fa3054ce0ec9f32b160aba4110f80f0d4f6cd4c77edf82f4f6af43a::josee {
    struct JOSEE has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<JOSEE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JOSEE>>(arg0, arg1);
    }

    fun init(arg0: JOSEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSEE>(arg0, 9, b"JOSEE", b"JOSEE", b"JOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"EEEE")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<JOSEE>(&mut v2, 30000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOSEE>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOSEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

