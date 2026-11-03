module 0xc75d61e531530a63e68aaf23dc360d2587dc902a5f5fc25e725e53a37f135296::zlink {
    struct GiveLink<phantom T0> has key {
        id: 0x2::object::UID,
        sender: address,
        claim_pubkey: vector<u8>,
        per_claim: u64,
        uses_left: u64,
        expires_at_ms: u64,
        app_id: vector<u8>,
        reference: vector<u8>,
        claimed_by: 0x2::table::Table<address, bool>,
        funds: 0x2::balance::Balance<T0>,
    }

    struct Created has copy, drop {
        link: 0x2::object::ID,
        sender: address,
        per_claim: u64,
        uses: u64,
        expires_at_ms: u64,
        app_id: vector<u8>,
        reference: vector<u8>,
    }

    struct Claimed has copy, drop {
        link: 0x2::object::ID,
        recipient: address,
        amount: u64,
        uses_left: u64,
    }

    struct Returned has copy, drop {
        link: 0x2::object::ID,
        sender: address,
        amount: u64,
        reason: u8,
    }

    public fun sender<T0>(arg0: &GiveLink<T0>) : address {
        arg0.sender
    }

    public fun claim<T0>(arg0: &mut GiveLink<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = claim_message(0x2::object::id<GiveLink<T0>>(arg0), v0);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.claim_pubkey, &v1), 10);
        pay_claim<T0>(arg0, v0, arg2);
    }

    public fun claim_message(arg0: 0x2::object::ID, arg1: address) : vector<u8> {
        let v0 = b"zend-zlink-claim-v1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        v0
    }

    fun close<T0>(arg0: GiveLink<T0>, arg1: u8) {
        let GiveLink {
            id            : v0,
            sender        : v1,
            claim_pubkey  : _,
            per_claim     : _,
            uses_left     : _,
            expires_at_ms : _,
            app_id        : _,
            reference     : _,
            claimed_by    : v8,
            funds         : v9,
        } = arg0;
        let v10 = v9;
        let v11 = 0x2::balance::value<T0>(&v10);
        if (v11 > 0) {
            0x2::balance::send_funds<T0>(v10, v1);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
        0x2::table::drop<address, bool>(v8);
        0x2::object::delete(v0);
        let v12 = Returned{
            link   : 0x2::object::id<GiveLink<T0>>(&arg0),
            sender : v1,
            amount : v11,
            reason : arg1,
        };
        0x2::event::emit<Returned>(v12);
    }

    public fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 0);
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 2);
        assert!((0x2::balance::value<T0>(&arg0) as u128) == (arg2 as u128) * (arg3 as u128), 3);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg7), 4);
        assert!(0x1::vector::length<u8>(&arg6) <= 64, 5);
        assert!(0x1::vector::length<u8>(&arg5) <= 64, 6);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = GiveLink<T0>{
            id            : 0x2::object::new(arg8),
            sender        : v0,
            claim_pubkey  : arg1,
            per_claim     : arg2,
            uses_left     : arg3,
            expires_at_ms : arg4,
            app_id        : arg5,
            reference     : arg6,
            claimed_by    : 0x2::table::new<address, bool>(arg8),
            funds         : arg0,
        };
        let v2 = Created{
            link          : 0x2::object::id<GiveLink<T0>>(&v1),
            sender        : v0,
            per_claim     : arg2,
            uses          : arg3,
            expires_at_ms : arg4,
            app_id        : v1.app_id,
            reference     : v1.reference,
        };
        0x2::event::emit<Created>(v2);
        0x2::transfer::share_object<GiveLink<T0>>(v1);
    }

    public fun expire<T0>(arg0: GiveLink<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms, 12);
        close<T0>(arg0, 1);
    }

    public fun expires_at_ms<T0>(arg0: &GiveLink<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun has_claimed<T0>(arg0: &GiveLink<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed_by, arg1)
    }

    fun pay_claim<T0>(arg0: &mut GiveLink<T0>, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_at_ms, 7);
        assert!(arg0.uses_left > 0, 8);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed_by, arg1), 9);
        0x2::table::add<address, bool>(&mut arg0.claimed_by, arg1, true);
        arg0.uses_left = arg0.uses_left - 1;
        let v0 = arg0.per_claim;
        0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0.funds, v0), arg1);
        let v1 = Claimed{
            link      : 0x2::object::id<GiveLink<T0>>(arg0),
            recipient : arg1,
            amount    : v0,
            uses_left : arg0.uses_left,
        };
        0x2::event::emit<Claimed>(v1);
    }

    public fun per_claim<T0>(arg0: &GiveLink<T0>) : u64 {
        arg0.per_claim
    }

    public fun reclaim<T0>(arg0: GiveLink<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.sender, 11);
        close<T0>(arg0, 0);
    }

    public fun remaining<T0>(arg0: &GiveLink<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun uses_left<T0>(arg0: &GiveLink<T0>) : u64 {
        arg0.uses_left
    }

    // decompiled from Move bytecode v7
}

