module 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::offers {
    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        buyer: address,
        title: 0x1::string::String,
        brief: 0x1::string::String,
        kind: u8,
        min_followers: u64,
        fee_free: bool,
        waived: bool,
        amount: u64,
        escrow: 0x2::balance::Balance<T0>,
        contact: vector<u8>,
        seller: address,
        handle: 0x1::string::String,
        followers: u64,
        proof: 0x1::string::String,
        reason: 0x1::string::String,
        status: u8,
        created_ms: u64,
        claimed_ms: u64,
        deliver_ms: u64,
        deadline_ms: u64,
        delivered_ms: u64,
        review_ms: u64,
        version: u64,
    }

    struct OfferPosted has copy, drop {
        offer: 0x2::object::ID,
        buyer: address,
        amount: u64,
        min_followers: u64,
        coin: 0x1::ascii::String,
    }

    struct OfferClaimed has copy, drop {
        offer: 0x2::object::ID,
        seller: address,
        handle: 0x1::string::String,
        followers: u64,
    }

    struct OfferDecided has copy, drop {
        offer: 0x2::object::ID,
        approved: bool,
    }

    struct OfferDelivered has copy, drop {
        offer: 0x2::object::ID,
        proof: 0x1::string::String,
    }

    struct OfferDisputed has copy, drop {
        offer: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct OfferReleased has copy, drop {
        offer: 0x2::object::ID,
        seller: address,
        seller_amount: u64,
        fee_amount: u64,
        how: u8,
    }

    struct OfferSplit has copy, drop {
        offer: 0x2::object::ID,
        seller: address,
        seller_amount: u64,
        buyer: address,
        buyer_amount: u64,
    }

    struct OfferRefunded has copy, drop {
        offer: 0x2::object::ID,
        buyer: address,
        amount: u64,
        how: u8,
    }

    struct TipJarCredit has drop {
        dummy_field: bool,
    }

    public fun approve<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: &mut Offer<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.buyer, 3);
        assert!(arg1.status == 2 || arg1.status == 3, 2);
        release<T0>(arg0, arg1, 1, arg2);
    }

    public fun cancel<T0>(arg0: &mut Offer<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.buyer, 3);
        assert!(arg0.status == 0 || arg0.status == 1, 2);
        refund<T0>(arg0, 0, arg1);
    }

    fun check_len(arg0: &0x1::string::String, arg1: u64, arg2: bool) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 <= arg1 && (arg2 || v0 > 0), 1);
    }

    fun check_ticket(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg5) < arg4, 6);
        assert!(0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::verify_sig(arg0, 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::ticket_message(arg1, arg2, arg4), arg3), 6);
    }

    public fun claim<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: &mut Offer<T0>, arg2: 0x1::string::String, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg1.status == 0, 2);
        assert!(v0 != arg1.buyer, 5);
        assert!(0x2::clock::timestamp_ms(arg6) < arg5, 6);
        check_len(&arg2, 32, false);
        assert!(0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::verify_sig(arg0, claim_message(0x2::object::id<Offer<T0>>(arg1), v0, arg3, arg2, arg5), arg4), 6);
        assert!(arg3 >= arg1.min_followers, 7);
        arg1.seller = v0;
        arg1.handle = arg2;
        arg1.followers = arg3;
        arg1.claimed_ms = 0x2::clock::timestamp_ms(arg6);
        arg1.status = 1;
        let v1 = OfferClaimed{
            offer     : 0x2::object::id<Offer<T0>>(arg1),
            seller    : v0,
            handle    : arg2,
            followers : arg3,
        };
        0x2::event::emit<OfferClaimed>(v1);
    }

    public fun claim_message(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: u64) : vector<u8> {
        let v0 = b"tapdrop-offer-claim";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        v0
    }

    public fun decide<T0>(arg0: &mut Offer<T0>, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.buyer, 3);
        assert!(arg0.status == 1, 2);
        if (arg1) {
            arg0.status = 2;
            arg0.deadline_ms = 0x2::clock::timestamp_ms(arg2) + arg0.deliver_ms;
        } else {
            arg0.status = 0;
            arg0.seller = @0x0;
            arg0.handle = 0x1::string::utf8(b"");
            arg0.followers = 0;
            arg0.claimed_ms = 0;
        };
        let v0 = OfferDecided{
            offer    : 0x2::object::id<Offer<T0>>(arg0),
            approved : arg1,
        };
        0x2::event::emit<OfferDecided>(v0);
    }

    public fun dispute<T0>(arg0: &mut Offer<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.buyer, 3);
        assert!(arg0.status == 3, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.delivered_ms + arg0.review_ms, 8);
        check_len(&arg1, 500, false);
        arg0.reason = arg1;
        arg0.status = 4;
        let v0 = OfferDisputed{
            offer  : 0x2::object::id<Offer<T0>>(arg0),
            reason : arg1,
        };
        0x2::event::emit<OfferDisputed>(v0);
    }

    public fun escrow_value<T0>(arg0: &Offer<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun mark_delivered<T0>(arg0: &mut Offer<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 4);
        assert!(arg0.status == 2 || arg0.status == 3, 2);
        check_len(&arg1, 500, arg0.kind != 0);
        if (arg0.status == 2) {
            assert!(0x2::clock::timestamp_ms(arg2) < arg0.deadline_ms, 8);
            arg0.delivered_ms = 0x2::clock::timestamp_ms(arg2);
            arg0.status = 3;
        };
        arg0.proof = arg1;
        let v0 = OfferDelivered{
            offer : 0x2::object::id<Offer<T0>>(arg0),
            proof : arg1,
        };
        0x2::event::emit<OfferDelivered>(v0);
    }

    public fun post<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: bool, arg6: u64, arg7: vector<u8>, arg8: 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_len(&arg1, 80, false);
        check_len(&arg2, 500, false);
        assert!(arg3 <= 2, 12);
        assert!(!arg5 || arg3 == 0, 12);
        assert!(0x1::vector::length<u8>(&arg7) <= 300, 1);
        assert!(arg6 >= 60000 && arg6 <= 5184000000, 13);
        let v0 = 0x2::coin::value<T0>(&arg8);
        assert!(v0 > 0, 11);
        let v1 = Offer<T0>{
            id            : 0x2::object::new(arg10),
            buyer         : 0x2::tx_context::sender(arg10),
            title         : arg1,
            brief         : arg2,
            kind          : arg3,
            min_followers : arg4,
            fee_free      : arg5,
            waived        : false,
            amount        : v0,
            escrow        : 0x2::coin::into_balance<T0>(arg8),
            contact       : arg7,
            seller        : @0x0,
            handle        : 0x1::string::utf8(b""),
            followers     : 0,
            proof         : 0x1::string::utf8(b""),
            reason        : 0x1::string::utf8(b""),
            status        : 0,
            created_ms    : 0x2::clock::timestamp_ms(arg9),
            claimed_ms    : 0,
            deliver_ms    : arg6,
            deadline_ms   : 0,
            delivered_ms  : 0,
            review_ms     : 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::review_ms(arg0),
            version       : 1,
        };
        let v2 = 0x2::object::id<Offer<T0>>(&v1);
        let v3 = OfferPosted{
            offer         : v2,
            buyer         : v1.buyer,
            amount        : v0,
            min_followers : arg4,
            coin          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<OfferPosted>(v3);
        0x2::transfer::share_object<Offer<T0>>(v1);
        v2
    }

    fun refund<T0>(arg0: &mut Offer<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg2), arg0.buyer);
        arg0.status = 6;
        let v0 = OfferRefunded{
            offer  : 0x2::object::id<Offer<T0>>(arg0),
            buyer  : arg0.buyer,
            amount : 0x2::balance::value<T0>(&arg0.escrow),
            how    : arg1,
        };
        0x2::event::emit<OfferRefunded>(v0);
    }

    public fun refund_timeout<T0>(arg0: &mut Offer<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms, 9);
        refund<T0>(arg0, 1, arg2);
    }

    fun release<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: &mut Offer<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1.waived) {
            true
        } else if (0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::exempt::is_exempt(arg1.seller)) {
            true
        } else {
            0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::exempt::is_exempt(arg1.buyer)
        };
        let (v1, v2) = 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::quote(arg0, 0x2::balance::value<T0>(&arg1.escrow), v0);
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.escrow), arg3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v2, arg3), 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::fee_recipient(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg1.seller);
        arg1.status = 5;
        let v4 = OfferReleased{
            offer         : 0x2::object::id<Offer<T0>>(arg1),
            seller        : arg1.seller,
            seller_amount : v1,
            fee_amount    : v2,
            how           : arg2,
        };
        0x2::event::emit<OfferReleased>(v4);
    }

    public fun release_after_window<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: &mut Offer<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 3, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.delivered_ms + arg1.review_ms, 9);
        release<T0>(arg0, arg1, 2, arg3);
    }

    public fun release_with_sig<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: &mut Offer<T0>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 3 && arg1.kind == 0, 2);
        check_ticket(arg0, b"tapdrop-offer-release", 0x2::object::id<Offer<T0>>(arg1), arg2, arg3, arg4);
        release<T0>(arg0, arg1, 0, arg5);
    }

    public fun request<T0>(arg0: &mut Offer<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 0, 2);
        assert!(v0 != arg0.buyer, 5);
        check_len(&arg1, 32, false);
        arg0.seller = v0;
        arg0.handle = arg1;
        arg0.followers = 0;
        arg0.claimed_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.status = 1;
        let v1 = OfferClaimed{
            offer     : 0x2::object::id<Offer<T0>>(arg0),
            seller    : v0,
            handle    : arg1,
            followers : 0,
        };
        0x2::event::emit<OfferClaimed>(v1);
    }

    public fun resolve<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: &mut Offer<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::arbiter(arg0), 10);
        assert!(arg1.status == 4, 2);
        if (arg2) {
            release<T0>(arg0, arg1, 3, arg3);
        } else {
            refund<T0>(arg1, 2, arg3);
        };
    }

    public fun seller<T0>(arg0: &Offer<T0>) : address {
        arg0.seller
    }

    public fun split_after_dispute_timeout<T0>(arg0: &mut Offer<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 4, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.delivered_ms + arg0.review_ms + 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::dispute_timeout_ms(), 9);
        let (v0, v1) = 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::split_timeout<T0>(&mut arg0.escrow, arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.seller);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg0.buyer);
        arg0.status = 7;
        let v4 = OfferSplit{
            offer         : 0x2::object::id<Offer<T0>>(arg0),
            seller        : arg0.seller,
            seller_amount : 0x2::coin::value<T0>(&v3),
            buyer         : arg0.buyer,
            buyer_amount  : 0x2::coin::value<T0>(&v2),
        };
        0x2::event::emit<OfferSplit>(v4);
    }

    public fun status<T0>(arg0: &Offer<T0>) : u8 {
        arg0.status
    }

    public fun tip_jar_credit<T0>(arg0: &Offer<T0>, arg1: &0x2::tx_context::TxContext) : TipJarCredit {
        assert!(0x2::tx_context::sender(arg1) == arg0.buyer, 3);
        assert!(arg0.fee_free, 14);
        assert!(arg0.status == 5, 2);
        assert!(arg0.waived, 15);
        TipJarCredit{dummy_field: false}
    }

    public fun waive_with_sig<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::shoutout::Config, arg1: &mut Offer<T0>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg1.fee_free, 14);
        let v0 = if (arg1.status == 2) {
            true
        } else if (arg1.status == 3) {
            true
        } else {
            arg1.status == 4
        };
        assert!(v0, 2);
        check_ticket(arg0, b"tapdrop-offer-waive", 0x2::object::id<Offer<T0>>(arg1), arg2, arg3, arg4);
        arg1.waived = true;
    }

    public fun withdraw<T0>(arg0: &mut Offer<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 4);
        assert!(arg0.status == 1 || arg0.status == 2, 2);
        arg0.status = 0;
        arg0.seller = @0x0;
        arg0.handle = 0x1::string::utf8(b"");
        arg0.followers = 0;
        arg0.claimed_ms = 0;
        arg0.deadline_ms = 0;
    }

    // decompiled from Move bytecode v7
}

