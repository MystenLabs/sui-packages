module 0x8e41eb3428f40cd3db6d39e0754d7e7f994721673d01314c628f6a9b2fa7922c::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<USDC>,
    }

    public fun mint(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        0x2::coin::mint<USDC>(&mut arg0.cap, arg1, arg2)
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<USDC>(arg0, v0, b"USDC", b"USDC", b"Test USDC", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<USDC>(&mut v3, 0x2::math::pow(10, v0 + 3), 0x2::tx_context::sender(arg1), arg1);
        let v4 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v3,
        };
        0x2::transfer::share_object<Treasury>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v2);
    }

    // decompiled from Move bytecode v6
}

