module 0xef6002173ad82536fc88e40099e3a059c3bcb24eb74de5535cbf8795a6d45a5a::meadow {
    struct MEADOW has drop {
        dummy_field: bool,
    }

    public entry fun burn_treasury_cap(arg0: 0x2::coin::TreasuryCap<MEADOW>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEADOW>>(arg0, @0x0);
    }

    fun init(arg0: MEADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEADOW>(arg0, 9, b"MEADOW", b"MED", b"Built for the next generation of users, Meadow will Incubate and launch the most anticipated projects on the Sui Network", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEADOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEADOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_maximum_supply(arg0: &mut 0x2::coin::TreasuryCap<MEADOW>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEADOW>(arg0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
    }

    public entry fun updateUrl(arg0: &mut 0x2::coin::TreasuryCap<MEADOW>, arg1: &mut 0x2::coin::CoinMetadata<MEADOW>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<MEADOW>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

