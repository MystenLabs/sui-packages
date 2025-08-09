module 0xe4a8144dbf1f6d06ace6b38ac99e0e15c123057c92cdeb8e4ff50be9b41e7474::PRIW {
    struct PRIW has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIW>>(0x2::coin::mint<PRIW>(arg0, arg1, arg3), arg2);
    }

    public entry fun update_icon_url<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: vector<u8>) {
        0x2::coin::update_icon_url<T0>(arg0, arg1, 0x1::ascii::string(arg2));
    }

    fun init(arg0: PRIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIW>(arg0, 6, b"PRIW", b"Primitivo Wine", b"The official token of Primitivo Wine", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PRIW>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

