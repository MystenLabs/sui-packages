module 0xb331cb40a8d7c2ea0c9eb32c16fad83630aaac506299254fe5971e1184897b9f::usd_coins {
    struct USD_COINS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USD_COINS>, arg1: 0x2::coin::Coin<USD_COINS>) {
        0x2::coin::burn<USD_COINS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USD_COINS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USD_COINS>>(0x2::coin::mint<USD_COINS>(arg0, arg1, arg3), arg2);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<USD_COINS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USD_COINS>>(0x2::coin::split<USD_COINS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USD_COINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD_COINS>(arg0, 9, trim_right(b"USDC"), trim_right(b"USD Coins"), trim_right(b"Low fee peer-to-peer electronic cash alternative to Bitcoin"), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(trim_right(b"https://i.ibb.co/tMTCrdzd/US1-DC-Logo.png"))), arg1);
        let v2 = v0;
        if (10000000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USD_COINS>>(0x2::coin::mint<USD_COINS>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD_COINS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USD_COINS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun merge(arg0: &mut 0x2::coin::Coin<USD_COINS>, arg1: 0x2::coin::Coin<USD_COINS>) {
        0x2::coin::join<USD_COINS>(arg0, arg1);
    }

    public entry fun mint_for_self(arg0: &mut 0x2::coin::TreasuryCap<USD_COINS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USD_COINS>>(0x2::coin::mint<USD_COINS>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (*0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != 32) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

