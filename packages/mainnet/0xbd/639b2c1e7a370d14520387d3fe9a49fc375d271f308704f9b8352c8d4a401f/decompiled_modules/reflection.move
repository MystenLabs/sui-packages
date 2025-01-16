module 0xbd639b2c1e7a370d14520387d3fe9a49fc375d271f308704f9b8352c8d4a401f::reflection {
    struct REFLECTION has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        from: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<REFLECTION>, arg1: 0x2::coin::Coin<REFLECTION>) {
        0x2::coin::burn<REFLECTION>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REFLECTION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::mint<REFLECTION>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<REFLECTION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 5 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::split<REFLECTION>(arg0, v0, arg3), @0x84631ff961b7bdc7193deed7393d8f7c74f7c6ec34b86e3f09f63aa3dc196c7f);
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::split<REFLECTION>(arg0, arg1 - v0, arg3), arg2);
        let v1 = FeeCollected{
            amount : v0,
            from   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeCollected>(v1);
    }

    public fun fee_percentage() : u64 {
        5
    }

    fun init(arg0: REFLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFLECTION>(arg0, 9, b"RFLX", b"Reflection Token", b"Reflection token with rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFLECTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REFLECTION>>(v1);
    }

    // decompiled from Move bytecode v6
}

