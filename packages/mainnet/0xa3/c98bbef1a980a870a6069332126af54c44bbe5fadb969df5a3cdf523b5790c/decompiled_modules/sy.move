module 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::sy {
    struct CreationEvent<phantom T0: drop> has copy, drop {
        syId: 0x2::object::ID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
    }

    struct DepositEvent<phantom T0: drop> has copy, drop {
        syId: 0x2::object::ID,
        receiver: address,
        amountIn: u64,
        shareOut: u64,
    }

    struct RedeemEvent<phantom T0: drop> has copy, drop {
        syId: 0x2::object::ID,
        receiver: address,
        shareIn: u64,
        amountOut: u64,
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

    public(friend) fun deposit<T0: drop>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: &mut SYStruct<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SYCoin<T0>>>(deposit_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5), arg0);
    }

    fun deposit_internal<T0: drop>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: &mut SYStruct<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SYCoin<T0>> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::sy_zero_deposit());
        assert!(arg3 >= arg2, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::sy_insufficient_sharesOut());
        0x2::balance::join<T0>(&mut arg4.balance, arg1);
        let v1 = DepositEvent<T0>{
            syId     : 0x2::object::uid_to_inner(&arg4.id),
            receiver : arg0,
            amountIn : v0,
            shareOut : arg3,
        };
        0x2::event::emit<DepositEvent<T0>>(v1);
        0x2::coin::from_balance<SYCoin<T0>>(0x2::balance::increase_supply<SYCoin<T0>>(&mut arg4.supply, arg3), arg5)
    }

    public(friend) fun deposit_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: &mut SYStruct<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SYCoin<T0>> {
        deposit_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun exchangeRate<T0: drop>(arg0: &SYStruct<T0>) : 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::FixedPoint64 {
        0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::fixed_point64::one()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun name<T0: drop>(arg0: &SYStruct<T0>) : vector<u8> {
        arg0.name
    }

    public(friend) fun redeem<T0: drop>(arg0: address, arg1: 0x2::balance::Balance<SYCoin<T0>>, arg2: u64, arg3: u64, arg4: &mut SYStruct<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(redeem_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5), arg0);
    }

    fun redeem_internal<T0: drop>(arg0: address, arg1: 0x2::balance::Balance<SYCoin<T0>>, arg2: u64, arg3: u64, arg4: &mut SYStruct<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<SYCoin<T0>>(&arg1);
        assert!(v0 > 0, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::sy_zero_redeem());
        assert!(arg3 >= arg2, 0xa3c98bbef1a980a870a6069332126af54c44bbe5fadb969df5a3cdf523b5790c::error::sy_insufficient_amountOut());
        0x2::balance::decrease_supply<SYCoin<T0>>(&mut arg4.supply, arg1);
        let v1 = RedeemEvent<T0>{
            syId      : 0x2::object::uid_to_inner(&arg4.id),
            receiver  : arg0,
            shareIn   : v0,
            amountOut : arg3,
        };
        0x2::event::emit<RedeemEvent<T0>>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg4.balance, arg3), arg5)
    }

    public(friend) fun redeem_with_coin_back<T0: drop>(arg0: address, arg1: 0x2::balance::Balance<SYCoin<T0>>, arg2: u64, arg3: u64, arg4: &mut SYStruct<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        redeem_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun symbol<T0: drop>(arg0: &SYStruct<T0>) : vector<u8> {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

