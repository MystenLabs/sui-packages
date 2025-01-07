module 0x3fefec354c5806c1879ff34761110ab1f53bac549b2120686dd2da6ed7e57bfe::firoll {
    struct FIROLL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FIROLL>, arg1: 0x2::coin::Coin<FIROLL>) : u64 {
        0x2::coin::burn<FIROLL>(arg0, arg1)
    }

    fun init(arg0: FIROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIROLL>(arg0, 9, b"FIROLL", b"PE", b"FIROLL is a pioneering token on the Sui network, designed for decentralized gaming and betting applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://your-icon-url.com/firoll.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIROLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIROLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FIROLL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FIROLL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

