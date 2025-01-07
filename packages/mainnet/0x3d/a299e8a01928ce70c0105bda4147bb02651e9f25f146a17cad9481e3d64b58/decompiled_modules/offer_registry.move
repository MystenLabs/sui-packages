module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry {
    struct OfferKey<phantom T0> has copy, drop, store {
        offer_id: 0x2::object::ID,
    }

    struct Offer<phantom T0> has store, key {
        id: 0x2::object::UID,
        asset_tier: 0x2::object::ID,
        amount: u64,
        duration: u64,
        interest: u64,
        status: 0x1::string::String,
        lender: address,
    }

    struct NewOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        asset_tier_id: 0x2::object::ID,
        asset_tier_name: 0x1::string::String,
        amount: u64,
        duration: u64,
        interest: u64,
        status: 0x1::string::String,
        lender: address,
    }

    struct RequestCancelOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        amount: u64,
        duration: u64,
        interest: u64,
        lender: address,
    }

    struct CancelledOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        amount: u64,
        duration: u64,
        interest: u64,
        lender: address,
    }

    struct EditedOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        amount: u64,
        duration: u64,
        interest: u64,
        lender: address,
    }

    public fun amount<T0>(arg0: &Offer<T0>) : u64 {
        arg0.amount
    }

    public fun asset_tier<T0>(arg0: &Offer<T0>) : 0x2::object::ID {
        arg0.asset_tier
    }

    public(friend) fun cancel_offer<T0>(arg0: &mut Offer<T0>, arg1: address) {
        assert!(arg1 == arg0.lender, 2);
        assert!(arg0.status == 0x1::string::utf8(b"Created"), 1);
        arg0.status = 0x1::string::utf8(b"Cancelling");
        let v0 = RequestCancelOfferEvent{
            offer_id : 0x2::object::id<Offer<T0>>(arg0),
            amount   : arg0.amount,
            duration : arg0.duration,
            interest : arg0.interest,
            lender   : arg1,
        };
        0x2::event::emit<RequestCancelOfferEvent>(v0);
    }

    fun do_cancel_offer<T0>(arg0: &mut Offer<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.lender;
        let v1 = 0x2::coin::zero<T0>(arg3);
        0x2::coin::join<T0>(&mut v1, arg1);
        0x2::coin::join<T0>(&mut v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        arg0.status = 0x1::string::utf8(b"Cancelled");
        let v2 = CancelledOfferEvent{
            offer_id : 0x2::object::id<Offer<T0>>(arg0),
            amount   : arg0.amount,
            duration : arg0.duration,
            interest : arg0.interest,
            lender   : v0,
        };
        0x2::event::emit<CancelledOfferEvent>(v2);
    }

    public fun duration<T0>(arg0: &Offer<T0>) : u64 {
        arg0.duration
    }

    public(friend) fun edit_offer<T0>(arg0: &mut Offer<T0>, arg1: u64, arg2: address) {
        assert!(arg2 == arg0.lender, 2);
        assert!(arg0.status == 0x1::string::utf8(b"Created"), 1);
        arg0.interest = arg1;
        let v0 = EditedOfferEvent{
            offer_id : 0x2::object::id<Offer<T0>>(arg0),
            amount   : arg0.amount,
            duration : arg0.duration,
            interest : arg0.interest,
            lender   : arg2,
        };
        0x2::event::emit<EditedOfferEvent>(v0);
    }

    public fun interest<T0>(arg0: &Offer<T0>) : u64 {
        arg0.interest
    }

    public fun is_available<T0>(arg0: &Offer<T0>) : bool {
        arg0.status == 0x1::string::utf8(b"Created")
    }

    public fun lender<T0>(arg0: &Offer<T0>) : address {
        arg0.lender
    }

    public(friend) fun new_offer<T0>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : Offer<T0> {
        let v0 = Offer<T0>{
            id         : 0x2::object::new(arg6),
            asset_tier : arg0,
            amount     : arg2,
            duration   : arg3,
            interest   : arg4,
            status     : 0x1::string::utf8(b"Created"),
            lender     : arg5,
        };
        let v1 = NewOfferEvent{
            offer_id        : 0x2::object::id<Offer<T0>>(&v0),
            asset_tier_id   : arg0,
            asset_tier_name : arg1,
            amount          : arg2,
            duration        : arg3,
            interest        : arg4,
            status          : 0x1::string::utf8(b"Created"),
            lender          : arg5,
        };
        0x2::event::emit<NewOfferEvent>(v1);
        v0
    }

    public fun new_offer_key<T0>(arg0: 0x2::object::ID) : OfferKey<T0> {
        OfferKey<T0>{offer_id: arg0}
    }

    public(friend) fun system_cancel_offer<T0>(arg0: &mut Offer<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"Cancelling"), 1);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.amount, 3);
        do_cancel_offer<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun system_force_cancel_offer<T0>(arg0: &mut Offer<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) == arg0.amount, 3);
        do_cancel_offer<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun take_loan<T0>(arg0: &mut Offer<T0>) {
        arg0.status = 0x1::string::utf8(b"Loaned");
    }

    // decompiled from Move bytecode v6
}

