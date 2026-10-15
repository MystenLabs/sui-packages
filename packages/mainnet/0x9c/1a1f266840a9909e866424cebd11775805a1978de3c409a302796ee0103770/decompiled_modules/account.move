module 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::account {
    struct Registry has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct AccountKey has copy, drop, store {
        pos0: vector<u8>,
    }

    struct HoldingKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct Account has key {
        id: 0x2::object::UID,
        pubkey: vector<u8>,
        nonce: u64,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        holdings: 0x2::bag::Bag,
    }

    struct Ticket<phantom T0> {
        account: 0x2::object::ID,
        min_out: u64,
        relay_fee: u64,
        relayer: address,
    }

    struct AccountOpened has copy, drop {
        account: 0x2::object::ID,
        pubkey: vector<u8>,
    }

    struct Credited has copy, drop {
        account: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        source: u8,
    }

    struct Sent has copy, drop {
        account: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        to: address,
    }

    struct Authorized has copy, drop {
        account: 0x2::object::ID,
        nonce: u64,
        relay_fee: u64,
        relayer: address,
    }

    struct BridgeOut {
        account: 0x2::object::ID,
        sui_in: u64,
        min_usdc: u64,
        recipient: vector<u8>,
    }

    struct BridgedOut has copy, drop {
        account: 0x2::object::ID,
        sui_in: u64,
        usdc: u64,
        bridge_fee: u64,
        recipient: vector<u8>,
    }

    public fun exists(arg0: &Registry, arg1: vector<u8>) : bool {
        let v0 = AccountKey{pos0: arg1};
        0x2::derived_object::exists<AccountKey>(&arg0.id, v0)
    }

    public fun absorb_funds(arg0: &mut Account, arg1: u64) {
        let v0 = 0x2::balance::redeem_funds<0x2::sui::SUI>(0x2::balance::withdraw_funds_from_object<0x2::sui::SUI>(&mut arg0.id, arg1));
        credit_sui(arg0, v0, 2);
    }

    public fun address_for(arg0: &Registry, arg1: vector<u8>) : address {
        let v0 = AccountKey{pos0: arg1};
        0x2::derived_object::derive_address<AccountKey>(0x2::object::id<Registry>(arg0), v0)
    }

    public(friend) fun authorize(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut Account, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::assert_live(arg0);
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::assert_relayer(arg0, arg8);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 <= arg5, 13906835222316056587);
        assert!(arg5 - v0 <= 3600000, 13906835226611154957);
        assert!(arg4 == arg1.nonce, 13906835230906253327);
        0x1::vector::append<u8>(&mut arg2, footer(arg1, arg3, arg4, arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg1.pubkey, &arg2), 13906835243791286289);
        arg1.nonce = arg4 + 1;
        let v1 = Authorized{
            account   : 0x2::object::id<Account>(arg1),
            nonce     : arg4,
            relay_fee : arg3,
            relayer   : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<Authorized>(v1);
    }

    public(friend) fun begin_swap_from_sui<T0>(arg0: &mut Account, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Ticket<T0>) {
        let v0 = take_sui(arg0, arg1);
        (0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), new_ticket<T0>(arg0, arg2, arg3, 0x2::tx_context::sender(arg4)))
    }

    public(friend) fun begin_swap_from_token<T0>(arg0: &mut Account, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket<0x2::sui::SUI>) {
        let v0 = take_token<T0>(arg0, arg1);
        (0x2::coin::from_balance<T0>(v0, arg4), new_ticket<0x2::sui::SUI>(arg0, arg2, arg3, 0x2::tx_context::sender(arg4)))
    }

    public(friend) fun charge_relay_fee(arg0: &mut Account, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        0x2::balance::send_funds<0x2::sui::SUI>(take_sui(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun count(arg0: &Registry) : u64 {
        arg0.count
    }

    public(friend) fun credit_fees(arg0: &mut Account, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        credit_sui(arg0, arg1, 5);
    }

    public(friend) fun credit_fees_token<T0>(arg0: &mut Account, arg1: 0x2::balance::Balance<T0>) {
        credit_token<T0>(arg0, arg1, 5);
    }

    fun credit_sui(arg0: &mut Account, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u8) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            return
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, arg1);
        let v1 = Credited{
            account   : 0x2::object::id<Account>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            amount    : v0,
            source    : arg2,
        };
        0x2::event::emit<Credited>(v1);
    }

    fun credit_token<T0>(arg0: &mut Account, arg1: 0x2::balance::Balance<T0>, arg2: u8) {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 13906835041928347673);
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        put_token<T0>(arg0, arg1);
        let v1 = Credited{
            account   : 0x2::object::id<Account>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            source    : arg2,
        };
        0x2::event::emit<Credited>(v1);
    }

    public(friend) fun credit_trade_sui(arg0: &mut Account, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        credit_sui(arg0, arg1, 4);
    }

    public fun deposit_sui(arg0: &mut Account, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        credit_sui(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), 0);
    }

    public fun deposit_token<T0>(arg0: &mut Account, arg1: 0x2::coin::Coin<T0>) {
        credit_token<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), 0);
    }

    public(friend) fun emit_sent<T0>(arg0: &Account, arg1: u64, arg2: address) {
        let v0 = Sent{
            account   : 0x2::object::id<Account>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
            to        : arg2,
        };
        0x2::event::emit<Sent>(v0);
    }

    public fun finish_into_sui(arg0: &mut Account, arg1: Ticket<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let Ticket {
            account   : v0,
            min_out   : v1,
            relay_fee : v2,
            relayer   : v3,
        } = arg1;
        assert!(v0 == 0x2::object::id<Account>(arg0), 13906835591683899413);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 13906835595978997783);
        credit_sui(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg2), 3);
        if (v2 > 0) {
            0x2::balance::send_funds<0x2::sui::SUI>(take_sui(arg0, v2), v3);
        };
    }

    public fun finish_into_token<T0>(arg0: &mut Account, arg1: Ticket<T0>, arg2: 0x2::coin::Coin<T0>) {
        let Ticket {
            account   : v0,
            min_out   : v1,
            relay_fee : v2,
            relayer   : v3,
        } = arg1;
        assert!(v0 == 0x2::object::id<Account>(arg0), 13906835626043637781);
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 13906835630338736151);
        credit_token<T0>(arg0, 0x2::coin::into_balance<T0>(arg2), 3);
        if (v2 > 0) {
            0x2::balance::send_funds<0x2::sui::SUI>(take_sui(arg0, v2), v3);
        };
    }

    public fun footer(arg0: &Account, arg1: u64, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Relay fee", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(arg1, 9), b"SUI"));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Account", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::id(0x2::object::id<Account>(arg0))));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Nonce", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::dec(arg2)));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Expires", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::utc(arg3)));
        v0
    }

    public fun headline(arg0: vector<u8>) : vector<u8> {
        let v0 = b"Sluice: ";
        0x1::vector::append<u8>(&mut v0, arg0);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun new_ticket<T0>(arg0: &Account, arg1: u64, arg2: u64, arg3: address) : Ticket<T0> {
        Ticket<T0>{
            account   : 0x2::object::id<Account>(arg0),
            min_out   : arg1,
            relay_fee : arg2,
            relayer   : arg3,
        }
    }

    public fun nonce(arg0: &Account) : u64 {
        arg0.nonce
    }

    public fun open(arg0: &mut Registry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834689739980809);
        let v0 = AccountKey{pos0: arg1};
        let v1 = 0x2::derived_object::claim<AccountKey>(&mut arg0.id, v0);
        let v2 = 0x2::object::uid_to_inner(&v1);
        arg0.count = arg0.count + 1;
        let v3 = Account{
            id       : v1,
            pubkey   : arg1,
            nonce    : 0,
            sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            holdings : 0x2::bag::new(arg2),
        };
        0x2::transfer::share_object<Account>(v3);
        let v4 = AccountOpened{
            account : v2,
            pubkey  : arg1,
        };
        0x2::event::emit<AccountOpened>(v4);
        v2
    }

    public fun pubkey(arg0: &Account) : vector<u8> {
        arg0.pubkey
    }

    public(friend) fun put_sui(arg0: &mut Account, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, arg1);
    }

    public(friend) fun put_token<T0>(arg0: &mut Account, arg1: 0x2::balance::Balance<T0>) {
        let v0 = HoldingKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::bag::contains<HoldingKey>(&arg0.holdings, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<HoldingKey, 0x2::balance::Balance<T0>>(&mut arg0.holdings, v0), arg1);
        } else {
            0x2::bag::add<HoldingKey, 0x2::balance::Balance<T0>>(&mut arg0.holdings, v0, arg1);
        };
    }

    public fun receive_sui(arg0: &mut Account, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1));
        credit_sui(arg0, v0, 1);
    }

    public fun receive_token<T0>(arg0: &mut Account, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
        credit_token<T0>(arg0, v0, 1);
    }

    public fun send_sui(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut Account, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13906836021181022235);
        let v0 = headline(b"send SUI");
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Amount", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(arg2, 9), b"SUI")));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"To", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::addr(arg3)));
        authorize(arg0, arg1, v0, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = take_sui(arg1, arg2);
        charge_relay_fee(arg1, arg4, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg9), arg3);
        let v2 = Sent{
            account   : 0x2::object::id<Account>(arg1),
            coin_type : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            amount    : arg2,
            to        : arg3,
        };
        0x2::event::emit<Sent>(v2);
    }

    public fun settle_bridge_out<T0: drop>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: T0, arg2: BridgeOut, arg3: u64, arg4: u64) : vector<u8> {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::assert_bridge<T0>(arg0, &arg1);
        let BridgeOut {
            account   : v0,
            sui_in    : v1,
            min_usdc  : v2,
            recipient : v3,
        } = arg2;
        assert!(arg3 > arg4 && arg3 - arg4 >= v2, 13906835935281414167);
        let v4 = BridgedOut{
            account    : v0,
            sui_in     : v1,
            usdc       : arg3,
            bridge_fee : arg4,
            recipient  : v3,
        };
        0x2::event::emit<BridgedOut>(v4);
        v3
    }

    public fun sui_value(arg0: &Account) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun take_received<T0, T1: drop>(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: T1, arg2: &mut Account, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket<0x2::sui::SUI>) {
        0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::assert_bridge<T1>(arg0, &arg1);
        (0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg2.id, arg3), new_ticket<0x2::sui::SUI>(arg2, arg4, 0, 0x2::tx_context::sender(arg5)))
    }

    public(friend) fun take_sui(arg0: &mut Account, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg1, 13906835333985730579);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg1)
    }

    public(friend) fun take_token<T0>(arg0: &mut Account, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = HoldingKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::bag::contains<HoldingKey>(&arg0.holdings, v0), 13906835376935403539);
        let v1 = 0x2::bag::borrow_mut<HoldingKey, 0x2::balance::Balance<T0>>(&mut arg0.holdings, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 13906835385525338131);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::bag::remove<HoldingKey, 0x2::balance::Balance<T0>>(&mut arg0.holdings, v0));
        };
        0x2::balance::split<T0>(v1, arg1)
    }

    public fun ticket_account<T0>(arg0: &Ticket<T0>) : 0x2::object::ID {
        arg0.account
    }

    public fun ticket_min_out<T0>(arg0: &Ticket<T0>) : u64 {
        arg0.min_out
    }

    public fun token_value<T0>(arg0: &Account) : u64 {
        let v0 = HoldingKey{pos0: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::bag::contains<HoldingKey>(&arg0.holdings, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<HoldingKey, 0x2::balance::Balance<T0>>(&arg0.holdings, v0))
        } else {
            0
        }
    }

    public fun withdraw_to_solana(arg0: &0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config::Config, arg1: &mut Account, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BridgeOut) {
        assert!(arg2 > 0 && arg3 > 0, 13906835857972264987);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906835862266052617);
        let v0 = headline(b"withdraw to Solana");
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Sell", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(arg2, 9), b"SUI")));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"Get at least", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::with_unit(0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::amount(arg3, 6), b"USDC")));
        0x1::vector::append<u8>(&mut v0, 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::line(b"To", 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::fmt::base58(&arg4)));
        authorize(arg0, arg1, v0, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = take_sui(arg1, arg2);
        charge_relay_fee(arg1, arg5, arg10);
        let v2 = BridgeOut{
            account   : 0x2::object::id<Account>(arg1),
            sui_in    : arg2,
            min_usdc  : arg3,
            recipient : arg4,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(v1, arg10), v2)
    }

    // decompiled from Move bytecode v7
}

