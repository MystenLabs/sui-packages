module 0xe0db9682d171dcda99bfcb443d7b1f9b8dc576741c0430f0b979cce006c8aa8c::presale {
    struct Presale<phantom T0> has key {
        id: 0x2::object::UID,
        token_balance: 0x2::balance::Balance<T0>,
        reserved_balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens_for_sale: u64,
        price_per_token: u64,
        is_active: bool,
        owner: address,
        claims_enabled: bool,
        purchases: 0x2::table::Table<address, u64>,
    }

    struct TokensPurchased has copy, drop {
        buyer: address,
        amount: u64,
        cost: u64,
    }

    struct TokensClaimed has copy, drop {
        claimer: address,
        amount: u64,
    }

    struct ClaimsStatusChanged has copy, drop {
        claims_enabled: bool,
    }

    struct PresaleStatusChanged has copy, drop {
        is_active: bool,
    }

    struct SuiWithdrawn has copy, drop {
        amount: u64,
    }

    struct TokensWithdrawn has copy, drop {
        amount: u64,
    }

    public fun buy_tokens<T0>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 <= 1000000000000, 9);
        let v1 = (v0 as u128) * 1000000000 / (arg0.price_per_token as u128);
        assert!(v1 <= 18446744073709551615, 10);
        let v2 = (v1 as u64);
        assert!(v2 > 0, 2);
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.token_balance), 3);
        0x2::balance::join<T0>(&mut arg0.reserved_balance, 0x2::balance::split<T0>(&mut arg0.token_balance, v2));
        let v3 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.purchases, v3)) {
            0x2::table::add<address, u64>(&mut arg0.purchases, v3, 0x2::table::remove<address, u64>(&mut arg0.purchases, v3) + v2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.purchases, v3, v2);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v4 = TokensPurchased{
            buyer  : 0x2::tx_context::sender(arg2),
            amount : v2,
            cost   : v0,
        };
        0x2::event::emit<TokensPurchased>(v4);
    }

    public fun claim_tokens<T0>(arg0: &mut Presale<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claims_enabled, 7);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.purchases, v0), 8);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.purchases, v0);
        assert!(v1 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserved_balance, v1), arg1), v0);
        let v2 = TokensClaimed{
            claimer : v0,
            amount  : v1,
        };
        0x2::event::emit<TokensClaimed>(v2);
    }

    public fun create_presale<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= 200000000000000000, 3);
        let v0 = 200000000000000000;
        let v1 = 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg0), v0);
        assert!(0x2::balance::value<T0>(&v1) == v0, 11);
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
        let v2 = Presale<T0>{
            id               : 0x2::object::new(arg1),
            token_balance    : v1,
            reserved_balance : 0x2::balance::zero<T0>(),
            sui_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens_for_sale  : v0,
            price_per_token  : 250000,
            is_active        : false,
            owner            : 0x2::tx_context::sender(arg1),
            claims_enabled   : false,
            purchases        : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<Presale<T0>>(v2);
    }

    entry fun entry_buy_tokens<T0>(arg0: &mut Presale<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        buy_tokens<T0>(arg0, arg1, arg2);
    }

    entry fun entry_claim_tokens<T0>(arg0: &mut Presale<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        claim_tokens<T0>(arg0, arg1);
    }

    entry fun entry_create_presale<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        create_presale<T0>(arg0, arg1);
    }

    entry fun entry_set_claims_enabled<T0>(arg0: &mut Presale<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        set_claims_enabled<T0>(arg0, arg1, arg2);
    }

    entry fun entry_set_presale_active<T0>(arg0: &mut Presale<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        set_presale_active<T0>(arg0, arg1, arg2);
    }

    entry fun entry_withdraw_remaining_tokens<T0>(arg0: &mut Presale<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        withdraw_remaining_tokens<T0>(arg0, arg1);
    }

    entry fun entry_withdraw_sui<T0>(arg0: &mut Presale<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        withdraw_sui<T0>(arg0, arg1);
    }

    public fun get_available_tokens<T0>(arg0: &Presale<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_balance)
    }

    public fun get_claimable_amount<T0>(arg0: &Presale<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.purchases, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.purchases, arg1)
        } else {
            0
        }
    }

    public fun get_claims_enabled<T0>(arg0: &Presale<T0>) : bool {
        arg0.claims_enabled
    }

    public fun get_is_active<T0>(arg0: &Presale<T0>) : bool {
        arg0.is_active
    }

    public fun get_owner<T0>(arg0: &Presale<T0>) : address {
        arg0.owner
    }

    public fun get_price_per_token<T0>(arg0: &Presale<T0>) : u64 {
        arg0.price_per_token
    }

    public fun get_reserved_tokens<T0>(arg0: &Presale<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserved_balance)
    }

    public fun get_sui_balance<T0>(arg0: &Presale<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun get_tokens_for_sale<T0>(arg0: &Presale<T0>) : u64 {
        arg0.tokens_for_sale
    }

    public fun set_claims_enabled<T0>(arg0: &mut Presale<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.claims_enabled = arg1;
        let v0 = ClaimsStatusChanged{claims_enabled: arg1};
        0x2::event::emit<ClaimsStatusChanged>(v0);
    }

    public fun set_presale_active<T0>(arg0: &mut Presale<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.is_active = arg1;
        let v0 = PresaleStatusChanged{is_active: arg1};
        0x2::event::emit<PresaleStatusChanged>(v0);
    }

    public fun withdraw_remaining_tokens<T0>(arg0: &mut Presale<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        assert!(!arg0.is_active, 5);
        let v0 = 0x2::balance::value<T0>(&arg0.token_balance);
        assert!(v0 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v0), arg1), 0x2::tx_context::sender(arg1));
        let v1 = TokensWithdrawn{amount: v0};
        0x2::event::emit<TokensWithdrawn>(v1);
    }

    public fun withdraw_sui<T0>(arg0: &mut Presale<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        assert!(!arg0.is_active, 5);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        assert!(v0 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0), arg1), 0x2::tx_context::sender(arg1));
        let v1 = SuiWithdrawn{amount: v0};
        0x2::event::emit<SuiWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

