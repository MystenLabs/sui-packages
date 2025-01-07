module 0x6b8e9d59289a1f673a5d2ccdb340281a46812ec049a53a22dfa71f540fbcd05c::dogat {
    struct DOGAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGAT>, arg1: 0x2::coin::Coin<DOGAT>) {
        0x2::coin::burn<DOGAT>(arg0, arg1);
    }

    fun init(arg0: DOGAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGAT>(arg0, 9, b"doge cat", b"dogat", x"e2809c536f20736f6d656f6e6520746f6c64206d652049206861766520746865206361742076657273696f6e206f662074686520646f6765206d656d65e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/5pQSTDfeUppb6tV415RWygL8n3ctyakBTV7QzBn5pump.png?size=xl&key=578d76")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGAT>>(v1);
        0x2::coin::mint_and_transfer<DOGAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGAT>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

