module 0x92d571162b0655d235c8c47fad6f0707bbb8177fb1bf0c32b14190268ed855ba::reflection {
    struct REFLECTION has drop {
        dummy_field: bool,
    }

    struct TreasuryStore has key {
        id: 0x2::object::UID,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_percentage: u64,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        from: address,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REFLECTION>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::mint<REFLECTION>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun distribute_rewards(arg0: &mut TreasuryStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee_balance, v0), arg2), arg1);
        };
    }

    public fun get_fee_percentage(arg0: &TreasuryStore) : u64 {
        arg0.fee_percentage
    }

    public fun get_treasury_balance(arg0: &TreasuryStore) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    fun init(arg0: REFLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REFLECTION>(arg0, 9, b"RFLX", b"Reflection Token", b"Reflection token with rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TreasuryStore{
            id             : 0x2::object::new(arg1),
            fee_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_percentage : 5,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REFLECTION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REFLECTION>>(v1);
        0x2::transfer::share_object<TreasuryStore>(v2);
    }

    public entry fun transfer_with_fee(arg0: &mut TreasuryStore, arg1: &mut 0x2::coin::Coin<REFLECTION>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 * arg0.fee_percentage / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg5)));
        0x2::transfer::public_transfer<0x2::coin::Coin<REFLECTION>>(0x2::coin::split<REFLECTION>(arg1, arg3, arg5), arg4);
        let v1 = FeeCollected{
            amount : v0,
            from   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<FeeCollected>(v1);
    }

    // decompiled from Move bytecode v6
}

