module 0x5db57de4c2ede11b72ca84575f3ab55098fbe203a54a55696a0b166f55a11fb1::short {
    struct SHORT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHORT>, arg1: 0x2::coin::Coin<SHORT>) {
        0x2::coin::burn<SHORT>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<SHORT>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORT>>(arg0, @0x0);
    }

    fun init(arg0: SHORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORT>(arg0, 6, b"SHORT", b"SHORT AI", b"SHORT AI ($SHORT) is a Web3-native platform that transforms long videos into viral short-form content using AI - and rewards creators with crypto. Built on SUI, $SHORT powers editing tools, staking, content boosting, and governance. Create. Earn. Own your content.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/UV1qRtQ.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHORT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHORT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHORT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

