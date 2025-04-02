module 0x384a048d2853808ba6d2aa7acdf70f8208aca5c03d8c9e86dfea11079bd28a91::vested_presale {
    struct PresaleCap has store, key {
        id: 0x2::object::UID,
    }

    struct VESTED_PRESALE has drop {
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
        vesting_enabled: bool,
        vesting_expiration: u64,
        nft_name_prefix: 0x1::string::String,
        nft_description: 0x1::string::String,
        nft_base_url: 0x2::url::Url,
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
        vesting_enabled: bool,
        vesting_expiration: u64,
        nft_name_prefix: 0x1::string::String,
        nft_description: 0x1::string::String,
        nft_base_url: 0x2::url::Url,
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

    struct LockedPurchase has copy, drop {
        presale_id: 0x2::object::ID,
        buyer: address,
        tokens_bought: u64,
        sui_spent: u64,
        fee_paid: u64,
        vesting_nft_id: 0x2::object::ID,
        unlock_timestamp_ms: u64,
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
        if (arg0.vesting_enabled) {
            let v5 = arg0.vesting_expiration;
            let v6 = 0x1::string::utf8(b"");
            0x1::string::append(&mut v6, arg0.nft_name_prefix);
            let v7 = 0x384a048d2853808ba6d2aa7acdf70f8208aca5c03d8c9e86dfea11079bd28a91::vesting_nft::mint<T0>(v4, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg0.tokens, v2, arg3)), v5, 0x2::object::id<Presale<T0>>(arg0), v6, arg0.nft_description, arg0.nft_base_url, arg3);
            0x384a048d2853808ba6d2aa7acdf70f8208aca5c03d8c9e86dfea11079bd28a91::vesting_nft::transfer_to_sender<T0>(v7, arg3);
            let v8 = LockedPurchase{
                presale_id          : 0x2::object::id<Presale<T0>>(arg0),
                buyer               : v4,
                tokens_bought       : v2,
                sui_spent           : v1,
                fee_paid            : v3,
                vesting_nft_id      : 0x2::object::id<0x384a048d2853808ba6d2aa7acdf70f8208aca5c03d8c9e86dfea11079bd28a91::vesting_nft::VestingNft<T0>>(&v7),
                unlock_timestamp_ms : v5,
                timestamp           : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<LockedPurchase>(v8);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.tokens, v2, arg3), v4);
            let v9 = Purchase{
                presale_id    : 0x2::object::id<Presale<T0>>(arg0),
                buyer         : v4,
                tokens_bought : v2,
                sui_spent     : v1,
                fee_paid      : v3,
                timestamp     : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<Purchase>(v9);
        };
        arg0.tokens_sold = arg0.tokens_sold + v2;
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

    public fun create_presale<T0>(arg0: &AdminCap, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: 0x2::coin::Coin<T0>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg14) == arg0.admin, 0);
        assert!(arg5 <= 10000, 6);
        if (arg7) {
            assert!(arg8 > 0, 7);
            assert!(!0x1::vector::is_empty<u8>(&arg9), 8);
            assert!(!0x1::vector::is_empty<u8>(&arg10), 8);
        } else {
            assert!(arg8 == 0, 7);
        };
        let v0 = 0x2::object::new(arg14);
        let v1 = 0x2::coin::into_balance<T0>(arg12);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 4);
        let v3 = 0x1::string::utf8(arg9);
        let v4 = 0x1::string::utf8(arg10);
        let v5 = 0x2::url::new_unsafe_from_bytes(arg11);
        let v6 = Presale<T0>{
            id                 : v0,
            admin              : 0x2::tx_context::sender(arg14),
            dev                : arg1,
            tokenType          : 0x1::string::utf8(arg2),
            tokens             : v1,
            sui_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            sale_price         : arg3,
            token_unit         : arg4,
            fee_bps            : arg5,
            total_tokens       : v2,
            tokens_sold        : 0,
            expiration         : arg6,
            vesting_enabled    : arg7,
            vesting_expiration : arg8,
            nft_name_prefix    : v3,
            nft_description    : v4,
            nft_base_url       : v5,
        };
        0x2::transfer::share_object<Presale<T0>>(v6);
        let v7 = NewPresale{
            presale_id         : 0x2::object::uid_to_inner(&v0),
            admin              : 0x2::tx_context::sender(arg14),
            dev                : arg1,
            tokenType          : 0x1::string::utf8(arg2),
            sale_price         : arg3,
            token_unit         : arg4,
            fee_bps            : arg5,
            total_tokens       : v2,
            expiration         : arg6,
            vesting_enabled    : arg7,
            vesting_expiration : arg8,
            nft_name_prefix    : v3,
            nft_description    : v4,
            nft_base_url       : v5,
            timestamp          : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<NewPresale>(v7);
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

    fun init(arg0: VESTED_PRESALE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VESTED_PRESALE>(arg0, arg1);
        let v0 = PresaleCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PresaleCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<AdminCap>(v1);
    }

    public fun nft_base_url<T0>(arg0: &Presale<T0>) : &0x2::url::Url {
        &arg0.nft_base_url
    }

    public fun nft_description<T0>(arg0: &Presale<T0>) : &0x1::string::String {
        &arg0.nft_description
    }

    public fun nft_name_prefix<T0>(arg0: &Presale<T0>) : &0x1::string::String {
        &arg0.nft_name_prefix
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

    public fun vesting_enabled<T0>(arg0: &Presale<T0>) : bool {
        arg0.vesting_enabled
    }

    public fun vesting_expiration<T0>(arg0: &Presale<T0>) : u64 {
        arg0.vesting_expiration
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

