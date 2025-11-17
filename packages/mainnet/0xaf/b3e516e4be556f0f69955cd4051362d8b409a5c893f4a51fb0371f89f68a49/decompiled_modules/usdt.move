module 0xafb3e516e4be556f0f69955cd4051362d8b409a5c893f4a51fb0371f89f68a49::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<USDT>,
    }

    public fun mint(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDT> {
        0x2::coin::mint<USDT>(&mut arg0.cap, arg1, arg2)
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<USDT>(arg0, v0, b"USDT", b"USDT", b"Test USDT", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<USDT>(&mut v3, 0x2::math::pow(10, v0 + 3), 0x2::tx_context::sender(arg1), arg1);
        let v4 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v3,
        };
        0x2::transfer::share_object<Treasury>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v2);
    }

    // decompiled from Move bytecode v6
}

