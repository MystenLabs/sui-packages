module 0x1bb86c87b74fb0d6611a05bd6bb062dd56ac29c16d1adb47cfd24647fe48486::my_token {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: 0x2::coin::Coin<MY_TOKEN>) {
        0x2::coin::burn<MY_TOKEN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_TOKEN>>(0x2::coin::mint<MY_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN>(arg0, 9, b"MTK", b"MyToken", b"My configurable token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/token-icon.png")), arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MY_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

