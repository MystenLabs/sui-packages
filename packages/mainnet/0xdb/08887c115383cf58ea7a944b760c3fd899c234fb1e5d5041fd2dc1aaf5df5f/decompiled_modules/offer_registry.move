module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry {
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

    public fun duration<T0>(arg0: &Offer<T0>) : u64 {
        arg0.duration
    }

    public(friend) fun edit_offer<T0>(arg0: &mut Offer<T0>, arg1: u64, arg2: address) {
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

    public fun is_cancelled_status<T0>(arg0: &Offer<T0>) : bool {
        arg0.status == 0x1::string::utf8(b"Cancelled")
    }

    public fun is_cancelling_status<T0>(arg0: &Offer<T0>) : bool {
        arg0.status == 0x1::string::utf8(b"Cancelling")
    }

    public fun is_created_status<T0>(arg0: &Offer<T0>) : bool {
        arg0.status == 0x1::string::utf8(b"Created")
    }

    public fun is_loaned_status<T0>(arg0: &Offer<T0>) : bool {
        arg0.status == 0x1::string::utf8(b"Loaned")
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

    public(friend) fun system_cancel_offer<T0>(arg0: &mut Offer<T0>) {
        arg0.status = 0x1::string::utf8(b"Cancelled");
        let v0 = CancelledOfferEvent{
            offer_id : 0x2::object::id<Offer<T0>>(arg0),
            amount   : arg0.amount,
            duration : arg0.duration,
            interest : arg0.interest,
            lender   : arg0.lender,
        };
        0x2::event::emit<CancelledOfferEvent>(v0);
    }

    public(friend) fun system_open_offer<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : Offer<T0> {
        Offer<T0>{
            id         : 0x2::object::new(arg5),
            asset_tier : arg0,
            amount     : arg1,
            duration   : arg2,
            interest   : arg3,
            status     : 0x1::string::utf8(b"Created"),
            lender     : arg4,
        }
    }

    public(friend) fun take_loan<T0>(arg0: &mut Offer<T0>) {
        arg0.status = 0x1::string::utf8(b"Loaned");
    }

    // decompiled from Move bytecode v6
}

