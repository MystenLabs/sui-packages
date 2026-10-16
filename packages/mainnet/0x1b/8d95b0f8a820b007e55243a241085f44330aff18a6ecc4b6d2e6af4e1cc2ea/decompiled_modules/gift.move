module 0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::gift {
    struct ClaimFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ClaimFeeBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GiftFeePaid has copy, drop {
        gift_id: 0x2::object::ID,
        claimer: address,
        fee: u64,
    }

    struct GiftAuthority has key {
        id: 0x2::object::UID,
        pubkey: vector<u8>,
    }

    struct Gift has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total: u64,
        per_claim: u64,
        max_claims: u64,
        claims: u64,
        expires_ms: u64,
        flags: u8,
        message: 0x1::string::String,
        claimed: 0x2::table::Table<address, bool>,
        active: bool,
    }

    struct GiftCreated has copy, drop {
        gift_id: 0x2::object::ID,
        creator: address,
        total: u64,
        per_claim: u64,
        max_claims: u64,
        flags: u8,
    }

    struct GiftClaimed has copy, drop {
        gift_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        claims: u64,
        remaining: u64,
    }

    struct GiftReclaimed has copy, drop {
        gift_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    entry fun claim(arg0: &mut Gift, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        abort 11
    }

    public fun claim_fee(arg0: &GiftAuthority) : u64 {
        let v0 = ClaimFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ClaimFeeKey>(&arg0.id, v0)) {
            let v2 = ClaimFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ClaimFeeKey, u64>(&arg0.id, v2)
        } else {
            4000000
        }
    }

    public fun claim_fee_bps(arg0: &GiftAuthority) : u64 {
        let v0 = ClaimFeeBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ClaimFeeBpsKey>(&arg0.id, v0)) {
            let v2 = ClaimFeeBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ClaimFeeBpsKey, u64>(&arg0.id, v2)
        } else {
            100
        }
    }

    entry fun claim_v2(arg0: &mut Gift, arg1: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::Config, arg2: &GiftAuthority, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.flags == 0, 7);
        let v0 = 0x2::tx_context::sponsor(arg4);
        do_claim(arg0, arg1, arg2, 0x1::option::is_some<address>(&v0), arg3, arg4);
    }

    entry fun claim_with_ticket(arg0: &mut Gift, arg1: &GiftAuthority, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 11
    }

    entry fun claim_with_ticket_v2(arg0: &mut Gift, arg1: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::Config, arg2: &GiftAuthority, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) < arg4, 9);
        let v0 = ticket_message(0x2::object::id<Gift>(arg0), 0x2::tx_context::sender(arg6), arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg2.pubkey, &v0), 8);
        let v1 = 0x2::tx_context::sponsor(arg6);
        do_claim(arg0, arg1, arg2, 0x1::option::is_some<address>(&v1), arg5, arg6);
    }

    public fun claims(arg0: &Gift) : u64 {
        arg0.claims
    }

    public fun create_authority(arg0: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GiftAuthority{
            id     : 0x2::object::new(arg2),
            pubkey : arg1,
        };
        0x2::transfer::share_object<GiftAuthority>(v0);
    }

    public fun create_gift(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0 && arg1 > 0, 1);
        assert!(arg1 >= 100000000, 13);
        assert!(arg3 <= 1 | 2, 10);
        let v1 = (v0 + arg1 - 1) / arg1;
        let v2 = Gift{
            id         : 0x2::object::new(arg5),
            creator    : 0x2::tx_context::sender(arg5),
            balance    : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            total      : v0,
            per_claim  : arg1,
            max_claims : v1,
            claims     : 0,
            expires_ms : arg2,
            flags      : arg3,
            message    : arg4,
            claimed    : 0x2::table::new<address, bool>(arg5),
            active     : true,
        };
        let v3 = 0x2::object::id<Gift>(&v2);
        let v4 = GiftCreated{
            gift_id    : v3,
            creator    : v2.creator,
            total      : v0,
            per_claim  : arg1,
            max_claims : v1,
            flags      : arg3,
        };
        0x2::event::emit<GiftCreated>(v4);
        0x2::transfer::share_object<Gift>(v2);
        v3
    }

    fun do_claim(arg0: &mut Gift, arg1: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::Config, arg2: &GiftAuthority, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(arg0.expires_ms == 0 || 0x2::clock::timestamp_ms(arg4) < arg0.expires_ms, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > 0, 5);
        let (v1, v2) = quote_claim(arg0, arg2, arg3);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        arg0.claims = arg0.claims + 1;
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2), arg5), 0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::fee_recipient(arg1));
            let v4 = GiftFeePaid{
                gift_id : 0x2::object::id<Gift>(arg0),
                claimer : v0,
                fee     : v2,
            };
            0x2::event::emit<GiftFeePaid>(v4);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg5), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) == 0) {
            arg0.active = false;
        };
        let v5 = GiftClaimed{
            gift_id   : 0x2::object::id<Gift>(arg0),
            claimer   : v0,
            amount    : v1,
            claims    : arg0.claims,
            remaining : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<GiftClaimed>(v5);
    }

    public fun has_claimed(arg0: &Gift, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public fun is_active(arg0: &Gift) : bool {
        arg0.active
    }

    public fun quote_claim(arg0: &Gift, arg1: &GiftAuthority, arg2: bool) : (u64, u64) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v1 = if (v0 < arg0.per_claim) {
            v0
        } else {
            arg0.per_claim
        };
        let v2 = (((v1 as u128) * (claim_fee_bps(arg1) as u128) / 10000) as u64);
        let v3 = claim_fee(arg1);
        let v4 = if (!arg2) {
            0
        } else if (v2 > v3) {
            v2
        } else {
            v3
        };
        let v5 = if (v4 > v1) {
            v1
        } else {
            v4
        };
        (v1, v5)
    }

    entry fun reclaim(arg0: &mut Gift, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        arg0.active = false;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), arg0.creator);
        };
        let v1 = GiftReclaimed{
            gift_id : 0x2::object::id<Gift>(arg0),
            creator : arg0.creator,
            amount  : v0,
        };
        0x2::event::emit<GiftReclaimed>(v1);
    }

    public fun remaining(arg0: &Gift) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun set_authority_key(arg0: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::AdminCap, arg1: &mut GiftAuthority, arg2: vector<u8>) {
        arg1.pubkey = arg2;
    }

    public fun set_claim_fee(arg0: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::AdminCap, arg1: &mut GiftAuthority, arg2: u64) {
        assert!(arg2 <= 10000000, 12);
        let v0 = ClaimFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ClaimFeeKey>(&arg1.id, v0)) {
            let v1 = ClaimFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ClaimFeeKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = ClaimFeeKey{dummy_field: false};
            0x2::dynamic_field::add<ClaimFeeKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_claim_fee_bps(arg0: &0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tip::AdminCap, arg1: &mut GiftAuthority, arg2: u64) {
        assert!(arg2 <= 500, 12);
        let v0 = ClaimFeeBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ClaimFeeBpsKey>(&arg1.id, v0)) {
            let v1 = ClaimFeeBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ClaimFeeBpsKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = ClaimFeeBpsKey{dummy_field: false};
            0x2::dynamic_field::add<ClaimFeeBpsKey, u64>(&mut arg1.id, v2, arg2);
        };
    }

    public fun ticket_message(arg0: 0x2::object::ID, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    // decompiled from Move bytecode v7
}

