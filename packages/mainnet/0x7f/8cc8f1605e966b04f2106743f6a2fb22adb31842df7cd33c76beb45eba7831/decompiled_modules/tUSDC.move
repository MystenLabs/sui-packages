module 0x7f8cc8f1605e966b04f2106743f6a2fb22adb31842df7cd33c76beb45eba7831::tUSDC {
    struct TUSDC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUSDC>, arg1: 0x2::coin::Coin<TUSDC>) {
        0x2::coin::burn<TUSDC>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUSDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TUSDC>>(0x2::coin::mint<TUSDC>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<TUSDC>) : u64 {
        0x2::coin::total_supply<TUSDC>(arg0)
    }

    fun init(arg0: TUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSDC>(arg0, 6, b"tUSDC", b"Test USDC", b"Test stablecoin for development - pegged to nothing, worth nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/usd-coin-usdc-logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSDC>>(v1);
    }

    public fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<TUSDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TUSDC> {
        assert!(arg1 > 0, 0);
        0x2::coin::mint<TUSDC>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

