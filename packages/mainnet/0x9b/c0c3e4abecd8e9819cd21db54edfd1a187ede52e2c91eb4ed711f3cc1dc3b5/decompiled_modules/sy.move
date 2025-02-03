module 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::sy {
    struct CreationEvent<phantom T0: drop> has copy, drop {
        syId: 0x2::object::ID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
    }

    struct DepositEvent<phantom T0: drop> has copy, drop {
        sy_id: 0x2::object::ID,
        amount_in: u64,
        share_out: u64,
    }

    struct RedeemEvent<phantom T0: drop> has copy, drop {
        sy_id: 0x2::object::ID,
        share_in: u64,
        amount_out: u64,
    }

    struct SYCoin<phantom T0: drop> has drop {
        dummy_field: bool,
    }

    struct SYStruct<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SYCoin<T0>>,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun burn<T0: drop>(arg0: 0x2::coin::Coin<SYCoin<T0>>, arg1: &mut SYStruct<T0>) : u64 {
        0x2::balance::decrease_supply<SYCoin<T0>>(&mut arg1.supply, 0x2::coin::into_balance<SYCoin<T0>>(arg0))
    }

    public(friend) fun create<T0: drop>(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SYCoin<T0>{dummy_field: false};
        let v1 = 0x1::ascii::string(arg2);
        let v2 = 0x1::ascii::string(arg1);
        0x1::ascii::insert(&mut v1, 0, 0x1::ascii::string(b"SY "));
        0x1::ascii::insert(&mut v2, 0, 0x1::ascii::string(b"SY-"));
        let v3 = SYStruct<T0>{
            id       : 0x2::object::new(arg3),
            supply   : 0x2::balance::create_supply<SYCoin<T0>>(v0),
            name     : 0x1::ascii::into_bytes(v1),
            symbol   : 0x1::ascii::into_bytes(v2),
            decimals : arg0,
            balance  : 0x2::balance::zero<T0>(),
        };
        let v4 = CreationEvent<T0>{
            syId     : 0x2::object::uid_to_inner(&v3.id),
            name     : v3.name,
            symbol   : v3.symbol,
            decimals : v3.decimals,
        };
        0x2::event::emit<CreationEvent<T0>>(v4);
        0x2::transfer::share_object<SYStruct<T0>>(v3);
    }

    public fun decimals<T0: drop>(arg0: &SYStruct<T0>) : u8 {
        arg0.decimals
    }

    public(friend) fun deposit<T0: drop>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SYCoin<T0>> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 > 0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::sy_zero_deposit());
        assert!(arg2 >= arg1, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::sy_insufficient_sharesOut());
        0x2::balance::join<T0>(&mut arg3.balance, arg0);
        let v1 = DepositEvent<T0>{
            sy_id     : 0x2::object::uid_to_inner(&arg3.id),
            amount_in : v0,
            share_out : arg2,
        };
        0x2::event::emit<DepositEvent<T0>>(v1);
        0x2::coin::from_balance<SYCoin<T0>>(0x2::balance::increase_supply<SYCoin<T0>>(&mut arg3.supply, arg2), arg4)
    }

    public fun exchange_rate<T0: drop>(arg0: &SYStruct<T0>) : 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::FixedPoint64 {
        0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::fixed_point64::one()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun mint<T0: drop>(arg0: u64, arg1: &mut SYStruct<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SYCoin<T0>> {
        0x2::coin::from_balance<SYCoin<T0>>(0x2::balance::increase_supply<SYCoin<T0>>(&mut arg1.supply, arg0), arg2)
    }

    public fun name<T0: drop>(arg0: &SYStruct<T0>) : vector<u8> {
        arg0.name
    }

    public(friend) fun redeem<T0: drop>(arg0: 0x2::balance::Balance<SYCoin<T0>>, arg1: u64, arg2: u64, arg3: &mut SYStruct<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<SYCoin<T0>>(&arg0);
        assert!(v0 > 0, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::sy_zero_redeem());
        assert!(arg2 >= arg1, 0x9bc0c3e4abecd8e9819cd21db54edfd1a187ede52e2c91eb4ed711f3cc1dc3b5::error::sy_insufficient_amountOut());
        0x2::balance::decrease_supply<SYCoin<T0>>(&mut arg3.supply, arg0);
        let v1 = RedeemEvent<T0>{
            sy_id      : 0x2::object::uid_to_inner(&arg3.id),
            share_in   : v0,
            amount_out : arg2,
        };
        0x2::event::emit<RedeemEvent<T0>>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg3.balance, arg2), arg4)
    }

    public fun symbol<T0: drop>(arg0: &SYStruct<T0>) : vector<u8> {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

