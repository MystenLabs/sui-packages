module 0xc2687f84b990b62c917a287eb69226675ade37a462191497f68dd5a6970abf8f::offer {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        fee_recipient: address,
        early_withdraw_fee_bps: u64,
        min_hold_ms: u64,
    }

    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        provider: address,
        balance: 0x2::balance::Balance<T0>,
        deposited: u64,
        taken: u64,
        created_at_ms: u64,
        fee_recipient: address,
        early_withdraw_fee_bps: u64,
        min_hold_ms: u64,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        provider: address,
        amount: u64,
    }

    struct OfferToppedUp has copy, drop {
        offer_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct TokensTaken has copy, drop {
        offer_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        remaining: u64,
    }

    struct Withdrawn has copy, drop {
        offer_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        fee: u64,
        remaining: u64,
    }

    public fun take<T0>(arg0: &AdminCap, arg1: &mut Offer<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 2);
        arg1.taken = arg1.taken + arg2;
        let v0 = TokensTaken{
            offer_id  : 0x2::object::id<Offer<T0>>(arg1),
            provider  : arg1.provider,
            amount    : arg2,
            remaining : 0x2::balance::value<T0>(&arg1.balance),
        };
        0x2::event::emit<TokensTaken>(v0);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    public fun balance_of<T0>(arg0: &Offer<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun can_withdraw_free<T0>(arg0: &Offer<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - arg0.created_at_ms >= arg0.min_hold_ms
    }

    public fun close_offer<T0>(arg0: Offer<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.provider == 0x2::tx_context::sender(arg1), 1);
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 4);
        let Offer {
            id                     : v0,
            provider               : _,
            balance                : v2,
            deposited              : _,
            taken                  : _,
            created_at_ms          : _,
            fee_recipient          : _,
            early_withdraw_fee_bps : _,
            min_hold_ms            : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v0);
    }

    public fun create_offer<T0>(arg0: &Registry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Offer<T0>{
            id                     : 0x2::object::new(arg3),
            provider               : v1,
            balance                : 0x2::coin::into_balance<T0>(arg1),
            deposited              : v0,
            taken                  : 0,
            created_at_ms          : 0x2::clock::timestamp_ms(arg2),
            fee_recipient          : arg0.fee_recipient,
            early_withdraw_fee_bps : arg0.early_withdraw_fee_bps,
            min_hold_ms            : arg0.min_hold_ms,
        };
        let v3 = OfferCreated{
            offer_id : 0x2::object::id<Offer<T0>>(&v2),
            provider : v1,
            amount   : v0,
        };
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::share_object<Offer<T0>>(v2);
    }

    public fun created_at_ms<T0>(arg0: &Offer<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun deposited<T0>(arg0: &Offer<T0>) : u64 {
        arg0.deposited
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Registry{
            id                     : 0x2::object::new(arg0),
            fee_recipient          : v0,
            early_withdraw_fee_bps : 0,
            min_hold_ms            : 0,
        };
        0x2::transfer::share_object<Registry>(v2);
    }

    public fun provider<T0>(arg0: &Offer<T0>) : address {
        arg0.provider
    }

    public fun registry_terms(arg0: &Registry) : (address, u64, u64) {
        (arg0.fee_recipient, arg0.early_withdraw_fee_bps, arg0.min_hold_ms)
    }

    public fun set_terms(arg0: &AdminCap, arg1: &mut Registry, arg2: address, arg3: u64, arg4: u64) {
        assert!(arg3 <= 2000, 5);
        assert!(arg4 <= 2592000000, 6);
        arg1.fee_recipient = arg2;
        arg1.early_withdraw_fee_bps = arg3;
        arg1.min_hold_ms = arg4;
    }

    public fun taken<T0>(arg0: &Offer<T0>) : u64 {
        arg0.taken
    }

    public fun terms<T0>(arg0: &Offer<T0>) : (address, u64, u64) {
        (arg0.fee_recipient, arg0.early_withdraw_fee_bps, arg0.min_hold_ms)
    }

    public fun top_up<T0>(arg0: &mut Offer<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.provider == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.deposited = arg0.deposited + v0;
        let v1 = OfferToppedUp{
            offer_id    : 0x2::object::id<Offer<T0>>(arg0),
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<OfferToppedUp>(v1);
    }

    public fun withdraw<T0>(arg0: &mut Offer<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.provider == 0x2::tx_context::sender(arg3), 1);
        assert!(arg1 > 0, 3);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 2);
        let v0 = withdrawal_fee<T0>(arg0, arg1, arg2);
        assert!(arg1 > v0, 7);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg3), arg0.fee_recipient);
        };
        let v1 = Withdrawn{
            offer_id  : 0x2::object::id<Offer<T0>>(arg0),
            provider  : arg0.provider,
            amount    : arg1 - v0,
            fee       : v0,
            remaining : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::coin::take<T0>(&mut arg0.balance, arg1 - v0, arg3)
    }

    public fun withdrawal_fee<T0>(arg0: &Offer<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg2) - arg0.created_at_ms >= arg0.min_hold_ms) {
            0
        } else {
            let v1 = arg1 * arg0.early_withdraw_fee_bps;
            if (v1 == 0) {
                0
            } else {
                (v1 + 10000 - 1) / 10000
            }
        }
    }

    // decompiled from Move bytecode v7
}

