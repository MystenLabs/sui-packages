module 0xa2fb73dc306849434e57928c1256e6291bfb745e71924d4f8cdbec665a254991::reflection {
    struct REFLECTION has drop {
        dummy_field: bool,
    }

    struct CoinCap has key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        from: address,
        fee_amount: u64,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REFLECTION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::mint<REFLECTION>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun transfer(arg0: &CoinCap, arg1: 0x2::coin::Coin<REFLECTION>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<REFLECTION>(&arg1);
        let v1 = v0 * 5 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::split<REFLECTION>(&mut arg1, v1, arg3), @0x84631ff961b7bdc7193deed7393d8f7c74f7c6ec34b86e3f09f63aa3dc196c7f);
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(arg1, arg2);
        let v2 = FeeCollected{
            amount     : v0,
            from       : 0x2::tx_context::sender(arg3),
            fee_amount : v1,
        };
        0x2::event::emit<FeeCollected>(v2);
    }

    public fun fee_percentage() : u64 {
        5
    }

    fun init(arg0: REFLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFLECTION>(arg0, 9, b"RFLX", b"Reflection Token", b"Reflection token with rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = CoinCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<CoinCap>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFLECTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REFLECTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

