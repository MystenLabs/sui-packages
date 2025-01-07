module 0xc469f6cc6ae0764793806aed415a1b29bc83d3749b3e6806191d2d693240654::glk {
    struct GLK has drop {
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

    public entry fun transfer(arg0: 0x2::coin::Coin<GLK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GLK>>(arg0, arg1);
    }

    fun init(arg0: GLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLK>(arg0, 9, b"GLK", b"Giul", b"giulikutza coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"QmTKeezi1PyokfmEKyatTw4e6bF5LjQgawa1MjXjJ23fyV")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<GLK>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLK>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

