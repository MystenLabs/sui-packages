module 0x21f08e5dd23d1bd275d6550a31be8602cf6485eec6d8af8562ae617276f7dd1e::sweed {
    struct SWEED has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWEED>, arg1: 0x2::coin::Coin<SWEED>) {
        0x2::coin::burn<SWEED>(arg0, arg1);
    }

    fun init(arg0: SWEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEED>(arg0, 6, b"SWEED", b"SWEED", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tickerperry.xyz/sweed.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEED>>(v1);
        0x2::coin::mint_and_transfer<SWEED>(&mut v2, 420000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEED>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWEED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWEED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

