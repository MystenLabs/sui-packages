module 0x309065209e8da6f811b01f8559889f9028cbeab5705a1fa5724d3f2ccece88ba::reflection {
    struct REFLECTION has drop {
        dummy_field: bool,
    }

    struct ReflectionCoin has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<REFLECTION>,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        fee: u64,
        from: address,
        to: address,
    }

    public fun join(arg0: &mut ReflectionCoin, arg1: ReflectionCoin) {
        let ReflectionCoin {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<REFLECTION>(&mut arg0.balance, v1);
    }

    public fun split(arg0: &mut ReflectionCoin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ReflectionCoin {
        let v0 = arg1 * 5 / 100;
        let v1 = ReflectionCoin{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::split<REFLECTION>(&mut arg0.balance, v0),
        };
        0x2::transfer::public_transfer<ReflectionCoin>(v1, @0x84631ff961b7bdc7193deed7393d8f7c74f7c6ec34b86e3f09f63aa3dc196c7f);
        ReflectionCoin{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::split<REFLECTION>(&mut arg0.balance, arg1 - v0),
        }
    }

    public fun value(arg0: &ReflectionCoin) : u64 {
        0x2::balance::value<REFLECTION>(&arg0.balance)
    }

    public entry fun transfer(arg0: &mut ReflectionCoin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = split(arg0, arg1, arg3);
        0x2::transfer::public_transfer<ReflectionCoin>(v0, arg2);
        let v1 = FeeCollected{
            amount : arg1,
            fee    : arg1 * 5 / 100,
            from   : 0x2::tx_context::sender(arg3),
            to     : arg2,
        };
        0x2::event::emit<FeeCollected>(v1);
    }

    fun init(arg0: REFLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFLECTION>(arg0, 9, b"RFLX", b"Reflection Token", b"Token with auto fee", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFLECTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REFLECTION>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REFLECTION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ReflectionCoin{
            id      : 0x2::object::new(arg3),
            balance : 0x2::coin::mint_balance<REFLECTION>(arg0, arg1),
        };
        0x2::transfer::public_transfer<ReflectionCoin>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

