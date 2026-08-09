module 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::opening {
    struct Opening<phantom T0> has key {
        id: 0x2::object::UID,
        buyer: address,
        escrow: 0x2::balance::Balance<T0>,
        amount: u64,
        fee_bps: u64,
        spec_hash: vector<u8>,
        open_until_ms: u64,
        sla_ms: u64,
        review_window_ms: u64,
        reject_split_bps: u64,
        claim_policy: u8,
        created_at_ms: u64,
    }

    struct OpeningCreated has copy, drop {
        opening_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        fee_bps: u64,
        spec_hash: vector<u8>,
        open_until_ms: u64,
        sla_ms: u64,
        review_window_ms: u64,
        reject_split_bps: u64,
        claim_policy: u8,
        timestamp_ms: u64,
    }

    struct OpeningClaimed has copy, drop {
        opening_id: 0x2::object::ID,
        job_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct OpeningCancelled has copy, drop {
        opening_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct OpeningRefunded has copy, drop {
        opening_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        timestamp_ms: u64,
    }

    public fun amount<T0>(arg0: &Opening<T0>) : u64 {
        arg0.amount
    }

    public fun buyer<T0>(arg0: &Opening<T0>) : address {
        arg0.buyer
    }

    public fun cancel_open<T0>(arg0: Opening<T0>, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg0.buyer, 10);
        let (v0, v1, v2) = repay_buyer<T0>(arg0, arg3);
        let v3 = OpeningCancelled{
            opening_id   : v0,
            buyer        : v1,
            amount       : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OpeningCancelled>(v3);
    }

    public fun claim<T0>(arg0: Opening<T0>, arg1: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg2: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let Opening {
            id               : v2,
            buyer            : v3,
            escrow           : v4,
            amount           : v5,
            fee_bps          : v6,
            spec_hash        : v7,
            open_until_ms    : v8,
            sla_ms           : v9,
            review_window_ms : v10,
            reject_split_bps : v11,
            claim_policy     : v12,
            created_at_ms    : _,
        } = arg0;
        let v14 = v2;
        assert!(v0 <= v8, 7);
        assert!(v12 == 0, 1);
        assert!(v1 != v3, 8);
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_registered(arg1, v1), 9);
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_active(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::borrow_record(arg1, v1)), 9);
        0x2::object::delete(v14);
        let v15 = 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::create_claimed<T0>(v3, v1, v4, v6, v7, v0 + v9, v10, v11, arg2, arg3, arg4);
        let v16 = OpeningClaimed{
            opening_id   : 0x2::object::uid_to_inner(&v14),
            job_id       : v15,
            buyer        : v3,
            seller       : v1,
            amount       : v5,
            timestamp_ms : v0,
        };
        0x2::event::emit<OpeningClaimed>(v16);
        v15
    }

    public fun claim_policy<T0>(arg0: &Opening<T0>) : u8 {
        arg0.claim_policy
    }

    public fun claim_policy_any_active() : u8 {
        0
    }

    public fun create_open<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg7);
        assert!(arg6 == 0, 1);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_amount_in_bounds_pkg(arg7, v0);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg2 > v1, 2);
        assert!(arg2 <= v1 + 2592000000, 3);
        assert!(arg3 > 0 && arg3 <= 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::max_deliver_horizon_ms_pkg(), 4);
        assert!(arg4 <= 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::max_review_window_ms_pkg(), 5);
        assert!(arg5 <= 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::bps_denominator_pkg(), 6);
        let v2 = Opening<T0>{
            id               : 0x2::object::new(arg9),
            buyer            : 0x2::tx_context::sender(arg9),
            escrow           : 0x2::coin::into_balance<T0>(arg0),
            amount           : v0,
            fee_bps          : 0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::config_fee_bps(arg7),
            spec_hash        : arg1,
            open_until_ms    : arg2,
            sla_ms           : arg3,
            review_window_ms : arg4,
            reject_split_bps : arg5,
            claim_policy     : arg6,
            created_at_ms    : v1,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = OpeningCreated{
            opening_id       : v3,
            buyer            : v2.buyer,
            amount           : v0,
            fee_bps          : v2.fee_bps,
            spec_hash        : v2.spec_hash,
            open_until_ms    : arg2,
            sla_ms           : arg3,
            review_window_ms : arg4,
            reject_split_bps : arg5,
            claim_policy     : arg6,
            timestamp_ms     : v1,
        };
        0x2::event::emit<OpeningCreated>(v4);
        0x2::transfer::share_object<Opening<T0>>(v2);
        v3
    }

    public fun created_at_ms<T0>(arg0: &Opening<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun fee_bps<T0>(arg0: &Opening<T0>) : u64 {
        arg0.fee_bps
    }

    public fun max_open_window_ms() : u64 {
        2592000000
    }

    public fun open_until_ms<T0>(arg0: &Opening<T0>) : u64 {
        arg0.open_until_ms
    }

    public fun refund_unclaimed<T0>(arg0: Opening<T0>, arg1: &0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::FeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x358a819c1c016e2cc84ef5fbea81cba90c31f7f8a62bf45cb5e5276acf198bdd::escrow::assert_version_pkg(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg0.open_until_ms, 11);
        let (v1, v2, v3) = repay_buyer<T0>(arg0, arg3);
        let v4 = OpeningRefunded{
            opening_id   : v1,
            buyer        : v2,
            amount       : v3,
            timestamp_ms : v0,
        };
        0x2::event::emit<OpeningRefunded>(v4);
    }

    public fun reject_split_bps<T0>(arg0: &Opening<T0>) : u64 {
        arg0.reject_split_bps
    }

    fun repay_buyer<T0>(arg0: Opening<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address, u64) {
        let Opening {
            id               : v0,
            buyer            : v1,
            escrow           : v2,
            amount           : v3,
            fee_bps          : _,
            spec_hash        : _,
            open_until_ms    : _,
            sla_ms           : _,
            review_window_ms : _,
            reject_split_bps : _,
            claim_policy     : _,
            created_at_ms    : _,
        } = arg0;
        let v12 = v2;
        let v13 = v0;
        0x2::object::delete(v13);
        0x2::balance::destroy_zero<T0>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v12), arg1), v1);
        (0x2::object::uid_to_inner(&v13), v1, v3)
    }

    public fun review_window_ms<T0>(arg0: &Opening<T0>) : u64 {
        arg0.review_window_ms
    }

    public fun sla_ms<T0>(arg0: &Opening<T0>) : u64 {
        arg0.sla_ms
    }

    public fun spec_hash<T0>(arg0: &Opening<T0>) : vector<u8> {
        arg0.spec_hash
    }

    // decompiled from Move bytecode v7
}

