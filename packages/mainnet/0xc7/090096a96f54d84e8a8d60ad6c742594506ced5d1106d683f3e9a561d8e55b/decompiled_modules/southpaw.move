module 0xc7090096a96f54d84e8a8d60ad6c742594506ced5d1106d683f3e9a561d8e55b::southpaw {
    struct SOUTHPAW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOUTHPAW>, arg1: 0x2::coin::Coin<SOUTHPAW>) {
        0x2::coin::burn<SOUTHPAW>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOUTHPAW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOUTHPAW>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SOUTHPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUTHPAW>(arg0, 0, b"southpaw", b"{name}", b"Releap Profile Token: southpaw", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUTHPAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUTHPAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<SOUTHPAW>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SOUTHPAW> {
        0x2::coin::mint<SOUTHPAW>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

