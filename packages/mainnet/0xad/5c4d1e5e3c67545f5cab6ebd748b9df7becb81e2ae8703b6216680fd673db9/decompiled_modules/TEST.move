module 0xad5c4d1e5e3c67545f5cab6ebd748b9df7becb81e2ae8703b6216680fd673db9::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn_treasury_cap(arg0: 0x2::coin::TreasuryCap<TEST>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(arg0, @0x0);
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"TEST", b"Built for the next generation of users, TEST will Incubate and launch the most anticipated projects on the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://th.bing.com/th/id/OIP.9IL0D6lZWR79BviKIJMjhAHaFj?w=237&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_maximum_supply(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST>(arg0, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

