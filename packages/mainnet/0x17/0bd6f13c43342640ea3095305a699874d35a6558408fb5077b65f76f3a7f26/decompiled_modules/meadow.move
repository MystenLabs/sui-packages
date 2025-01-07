module 0x170bd6f13c43342640ea3095305a699874d35a6558408fb5077b65f76f3a7f26::meadow {
    struct MEADOW has drop {
        dummy_field: bool,
    }

    public entry fun burn_treasury_cap(arg0: 0x2::coin::TreasuryCap<MEADOW>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEADOW>>(arg0, @0x0);
    }

    fun init(arg0: MEADOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEADOW>(arg0, 9, b"MED", b"Meadow", b"Built for the next generation of users, Meadow will Incubate and launch the most anticipated projects on the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.meadowlaunch.com/_next/image?url=%2Fprojects%2F0.png&w=64&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEADOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEADOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_maximum_supply(arg0: &mut 0x2::coin::TreasuryCap<MEADOW>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEADOW>(arg0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

