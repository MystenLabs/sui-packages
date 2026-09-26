module 0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::referral_escrow {
    struct Receipt<phantom T0> has key {
        id: 0x2::object::UID,
        referrer: address,
        funds: 0x2::balance::Balance<T0>,
    }

    struct ReferralEscrowDeposited has copy, drop {
        receipt: 0x2::object::ID,
        trader: address,
        referrer: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        timestamp_ms: u64,
    }

    struct ReferralEscrowClaimed has copy, drop {
        receipt: 0x2::object::ID,
        referrer: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun claim<T0>(arg0: Receipt<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Receipt {
            id       : v0,
            referrer : v1,
            funds    : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 0);
        let v5 = ReferralEscrowClaimed{
            receipt      : 0x2::object::uid_to_inner(&v4),
            referrer     : v1,
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount       : 0x2::balance::value<T0>(&v3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ReferralEscrowClaimed>(v5);
        0x2::object::delete(v4);
        0x2::coin::from_balance<T0>(v3, arg2)
    }

    public fun claim_to_sender<T0>(arg0: Receipt<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = Receipt<T0>{
            id       : 0x2::object::new(arg3),
            referrer : arg1,
            funds    : 0x2::coin::into_balance<T0>(arg0),
        };
        let v2 = ReferralEscrowDeposited{
            receipt      : 0x2::object::id<Receipt<T0>>(&v1),
            trader       : 0x2::tx_context::sender(arg3),
            referrer     : arg1,
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            amount       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ReferralEscrowDeposited>(v2);
        0x2::transfer::transfer<Receipt<T0>>(v1, arg1);
    }

    // decompiled from Move bytecode v7
}

