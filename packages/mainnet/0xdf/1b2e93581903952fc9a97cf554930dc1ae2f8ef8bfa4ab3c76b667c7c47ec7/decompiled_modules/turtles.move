module 0xdf1b2e93581903952fc9a97cf554930dc1ae2f8ef8bfa4ab3c76b667c7c47ec7::turtles {
    struct TURTLES has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TURTLES>, arg1: 0x2::coin::Coin<TURTLES>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TURTLES>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TURTLES>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: TURTLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLES>(arg0, 6, b"turtles", b"TURTLES", x"54686520636f696e207374616d7065646520796f75206469646ee28099742073656520636f6d696e672e20546865207368656c6ce28099732061626f757420746f20637261636b2c20646f6ee2809974206d69737320796f7572206d6f6f6e73686f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkpo6c3me/image/upload/v1728028065/turtles_m8wg5r.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURTLES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLES>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<TURTLES>, arg1: 0x2::coin::Coin<TURTLES>) : u64 {
        0x2::coin::burn<TURTLES>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<TURTLES>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TURTLES> {
        0x2::coin::mint<TURTLES>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

