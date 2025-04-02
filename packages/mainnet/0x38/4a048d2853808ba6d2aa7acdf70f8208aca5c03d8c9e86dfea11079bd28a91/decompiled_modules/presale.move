module 0x384a048d2853808ba6d2aa7acdf70f8208aca5c03d8c9e86dfea11079bd28a91::presale {
    struct PresaleCap has store, key {
        id: 0x2::object::UID,
    }

    struct PRESALE has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct Presale<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        dev: address,
        tokenType: 0x1::string::String,
        tokens: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        sale_price: u64,
        token_unit: u64,
        fee_bps: u64,
        total_tokens: u64,
        tokens_sold: u64,
        expiration: u64,
    }

    struct NewPresale has copy, drop {
        presale_id: 0x2::object::ID,
        admin: address,
        dev: address,
        tokenType: 0x1::string::String,
        sale_price: u64,
        token_unit: u64,
        fee_bps: u64,
        total_tokens: u64,
        expiration: u64,
        timestamp: u64,
    }

    struct Purchase has copy, drop {
        presale_id: 0x2::object::ID,
        buyer: address,
        tokens_bought: u64,
        sui_spent: u64,
        fee_paid: u64,
        timestamp: u64,
    }

    struct AddFunds has copy, drop {
        presale_id: 0x2::object::ID,
        sender: address,
        tokens: u64,
        total_tokens: u64,
        timestamp: u64,
    }

    struct WithdrawFunds has copy, drop {
        presale_id: 0x2::object::ID,
        dev: address,
        sui_withdrawn: u64,
        token_withdrawn: u64,
        timestamp: u64,
    }

    struct FeesWithdrawn has copy, drop {
        presale_id: 0x2::object::ID,
        admin: address,
        amount_withdrawn: u64,
        timestamp: u64,
    }

    struct TransferDev has copy, drop {
        presale_id: 0x2::object::ID,
        dev: address,
        new_dev: address,
        timestamp: u64,
    }

    struct TransferAdmin has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
        new_admin: address,
        timestamp: u64,
    }

    public fun add_funds<T0>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.expiration, 2);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg0.tokens, v0);
        arg0.total_tokens = arg0.total_tokens + v1;
        let v2 = AddFunds{
            presale_id   : 0x2::object::id<Presale<T0>>(arg0),
            sender       : 0x2::tx_context::sender(arg3),
            tokens       : v1,
            total_tokens : arg0.total_tokens,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AddFunds>(v2);
    }

    public fun admin<T0>(arg0: &Presale<T0>) : address {
        arg0.admin
    }

    public fun buy_tokens<T0>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.expiration, 2);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v2 = calculate_tokens_to_buy(v1, arg0.sale_price, arg0.token_unit);
        assert!(v2 > 0, 3);
        assert!(v2 <= arg0.total_tokens - arg0.tokens_sold, 4);
        let v3 = calculate_fee(v1, arg0.fee_bps);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v0);
        let v4 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.tokens, v2, arg3), v4);
        arg0.tokens_sold = arg0.tokens_sold + v2;
        let v5 = Purchase{
            presale_id    : 0x2::object::id<Presale<T0>>(arg0),
            buyer         : v4,
            tokens_bought : v2,
            sui_spent     : v1,
            fee_paid      : v3,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Purchase>(v5);
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun calculate_tokens_to_buy(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u128) * (arg2 as u128) / (arg1 as u128);
        if (v0 > (18446744073709551615 as u128)) {
            (18446744073709551615 as u64)
        } else {
            (v0 as u64)
        }
    }

    public fun create_presale<T0>(arg0: &AdminCap, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.admin, 0);
        assert!(arg5 <= 10000, 6);
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::coin::into_balance<T0>(arg7);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 4);
        let v3 = Presale<T0>{
            id           : v0,
            admin        : 0x2::tx_context::sender(arg9),
            dev          : arg1,
            tokenType    : 0x1::string::utf8(arg2),
            tokens       : v1,
            sui_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            sale_price   : arg3,
            token_unit   : arg4,
            fee_bps      : arg5,
            total_tokens : v2,
            tokens_sold  : 0,
            expiration   : arg6,
        };
        0x2::transfer::share_object<Presale<T0>>(v3);
        let v4 = NewPresale{
            presale_id   : 0x2::object::uid_to_inner(&v0),
            admin        : 0x2::tx_context::sender(arg9),
            dev          : arg1,
            tokenType    : 0x1::string::utf8(arg2),
            sale_price   : arg3,
            token_unit   : arg4,
            fee_bps      : arg5,
            total_tokens : v2,
            expiration   : arg6,
            timestamp    : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<NewPresale>(v4);
    }

    public fun dev<T0>(arg0: &Presale<T0>) : address {
        arg0.dev
    }

    public fun expiration<T0>(arg0: &Presale<T0>) : u64 {
        arg0.expiration
    }

    public fun fee_balance_value<T0>(arg0: &Presale<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    public fun fee_bps<T0>(arg0: &Presale<T0>) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: PRESALE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PRESALE>(arg0, arg1);
        let v0 = PresaleCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PresaleCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<AdminCap>(v1);
    }

    public fun sale_price<T0>(arg0: &Presale<T0>) : u64 {
        arg0.sale_price
    }

    public fun set_admin(arg0: &mut AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.admin = arg1;
        let v0 = TransferAdmin{
            admin_cap_id : 0x2::object::id<AdminCap>(arg0),
            admin        : arg0.admin,
            new_admin    : arg1,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TransferAdmin>(v0);
    }

    public fun set_dev<T0>(arg0: &mut Presale<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dev == 0x2::tx_context::sender(arg3), 1);
        arg0.dev = arg1;
        let v0 = TransferDev{
            presale_id : 0x2::object::id<Presale<T0>>(arg0),
            dev        : arg0.dev,
            new_dev    : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TransferDev>(v0);
    }

    public fun sui_balance_value<T0>(arg0: &Presale<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun token_type<T0>(arg0: &Presale<T0>) : 0x1::string::String {
        arg0.tokenType
    }

    public fun token_unit<T0>(arg0: &Presale<T0>) : u64 {
        arg0.token_unit
    }

    public fun tokens_available<T0>(arg0: &Presale<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun tokens_sold<T0>(arg0: &Presale<T0>) : u64 {
        arg0.tokens_sold
    }

    public fun total_tokens<T0>(arg0: &Presale<T0>) : u64 {
        arg0.total_tokens
    }

    public fun withdraw_fees_admin<T0>(arg0: &AdminCap, arg1: &mut Presale<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.fee_balance);
        assert!(v0 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.fee_balance, v0, arg3), arg0.admin);
        let v1 = FeesWithdrawn{
            presale_id       : 0x2::object::id<Presale<T0>>(arg1),
            admin            : arg0.admin,
            amount_withdrawn : v0,
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    public fun withdraw_funds<T0>(arg0: &mut Presale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.dev == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.expiration || arg0.tokens_sold == arg0.total_tokens, 5);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0, arg2), arg0.dev);
        };
        let v1 = 0x2::balance::value<T0>(&arg0.tokens);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.tokens, v1, arg2), arg0.dev);
        };
        let v2 = WithdrawFunds{
            presale_id      : 0x2::object::id<Presale<T0>>(arg0),
            dev             : arg0.dev,
            sui_withdrawn   : v0,
            token_withdrawn : v1,
            timestamp       : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<WithdrawFunds>(v2);
    }

    public fun withdraw_funds_admin<T0>(arg0: &AdminCap, arg1: &mut Presale<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_balance, v0, arg3), arg1.dev);
        };
        let v1 = 0x2::balance::value<T0>(&arg1.tokens);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.tokens, v1, arg3), arg1.dev);
        };
        let v2 = WithdrawFunds{
            presale_id      : 0x2::object::id<Presale<T0>>(arg1),
            dev             : arg1.dev,
            sui_withdrawn   : v0,
            token_withdrawn : v1,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawFunds>(v2);
    }

    // decompiled from Move bytecode v6
}

