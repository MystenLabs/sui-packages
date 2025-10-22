module 0x6dbef0bdb38e0f389af894712258f3ad5b1c6b19eba5ee33db9bc56e15b9ce22::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::burn<MYCOIN>(arg0, arg1);
    }

    public entry fun public_transfer(arg0: 0x2::coin::Coin<MYCOIN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(arg0, arg1);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 5, b"USDT ", b"USDT ", b"my coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/usdt.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYCOIN>(arg0, arg1, arg2, arg3);
    }

    public fun public_balance(arg0: &0x2::coin::Coin<MYCOIN>) : u64 {
        0x2::coin::value<MYCOIN>(arg0)
    }

    public entry fun public_swap(arg0: 0x2::coin::Coin<MYCOIN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

