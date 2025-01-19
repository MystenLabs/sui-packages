module 0xdc9b85ed6e62e5f4fca4907a0e9643b8eaaf3b2393b16606bc85e70703bfde69::trumpump {
    struct TRUMPUMP has drop {
        dummy_field: bool,
    }

    struct LiquidityLock has store, key {
        id: 0x2::object::UID,
        locked_until: u64,
        balance: 0x2::balance::Balance<TRUMPUMP>,
        owner: address,
    }

    struct TransactionLimits has store, key {
        id: 0x2::object::UID,
        max_transaction: u64,
        burn_rate: u64,
        liquidity_rate: u64,
        last_tx_timestamp: u64,
        extra_tax_threshold: u64,
        extra_tax_rate: u64,
        whale_tax_threshold: u64,
        whale_tax_rate: u64,
        owner: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        tax_type: u8,
    }

    struct AddLiquidityEvent has copy, drop {
        amount: u64,
    }

    public entry fun transfer(arg0: &mut 0x2::coin::TreasuryCap<TRUMPUMP>, arg1: &mut 0x2::coin::Coin<TRUMPUMP>, arg2: u64, arg3: address, arg4: &mut TransactionLimits, arg5: &mut LiquidityLock, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg4.max_transaction, 1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 >= arg4.last_tx_timestamp + 30000, 4);
        arg4.last_tx_timestamp = v0;
        let (v1, v2) = if (arg2 >= arg4.whale_tax_threshold) {
            (arg4.burn_rate + arg4.whale_tax_rate, 2)
        } else if (arg2 >= arg4.extra_tax_threshold) {
            (arg4.burn_rate + arg4.extra_tax_rate, 1)
        } else {
            (arg4.burn_rate, 0)
        };
        let v3 = arg2 * v1 / 10000;
        let v4 = arg2 * arg4.liquidity_rate / 10000;
        0x2::coin::burn<TRUMPUMP>(arg0, 0x2::coin::split<TRUMPUMP>(arg1, v3, arg7));
        let v5 = BurnEvent{
            amount   : v3,
            tax_type : v2,
        };
        0x2::event::emit<BurnEvent>(v5);
        let v6 = 0x2::coin::split<TRUMPUMP>(arg1, v4, arg7);
        add_liquidity(arg5, v6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPUMP>>(0x2::coin::split<TRUMPUMP>(arg1, arg2 - v3 - v4, arg7), arg3);
    }

    public entry fun add_liquidity(arg0: &mut LiquidityLock, arg1: 0x2::coin::Coin<TRUMPUMP>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AddLiquidityEvent{amount: 0x2::coin::value<TRUMPUMP>(&arg1)};
        0x2::event::emit<AddLiquidityEvent>(v0);
        0x2::balance::join<TRUMPUMP>(&mut arg0.balance, 0x2::coin::into_balance<TRUMPUMP>(arg1));
    }

    fun init(arg0: TRUMPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPUMP>(arg0, 9, b"TRUMPUMP", b"TRUMP PUMP", b"Meme token for the people", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = TransactionLimits{
            id                  : 0x2::object::new(arg1),
            max_transaction     : 1000000000000,
            burn_rate           : 250,
            liquidity_rate      : 250,
            last_tx_timestamp   : 0,
            extra_tax_threshold : 100000000,
            extra_tax_rate      : 300,
            whale_tax_threshold : 500000000,
            whale_tax_rate      : 500,
            owner               : v0,
        };
        let v4 = LiquidityLock{
            id           : 0x2::object::new(arg1),
            locked_until : 1737478800000,
            balance      : 0x2::balance::zero<TRUMPUMP>(),
            owner        : v0,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPUMP>>(v1, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPUMP>>(v2);
        0x2::transfer::public_share_object<TransactionLimits>(v3);
        0x2::transfer::public_share_object<LiquidityLock>(v4);
    }

    public entry fun update_limits(arg0: &0x2::coin::TreasuryCap<TRUMPUMP>, arg1: &mut TransactionLimits, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg9), 2);
        arg1.max_transaction = arg2;
        arg1.burn_rate = arg3;
        arg1.liquidity_rate = arg4;
        arg1.extra_tax_threshold = arg5;
        arg1.extra_tax_rate = arg6;
        arg1.whale_tax_threshold = arg7;
        arg1.whale_tax_rate = arg8;
    }

    public entry fun withdraw_liquidity(arg0: &mut LiquidityLock, arg1: &0x2::coin::TreasuryCap<TRUMPUMP>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPUMP>>(0x2::coin::from_balance<TRUMPUMP>(0x2::balance::split<TRUMPUMP>(&mut arg0.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

