module 0xbf654bef3c0177dfd909fe00bd133bba716efa47b6150dfbd7a5792484527541::refunds {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        ledger: 0x2::object::ID,
    }

    struct Ledger has key {
        id: 0x2::object::UID,
        operator: address,
        paused: bool,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        cards: 0x2::table::Table<vector<u8>, CardState>,
        requests: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct CardState has copy, drop, store {
        redeemed_jpy: u64,
        sequence: u64,
        head: vector<u8>,
        latest: address,
    }

    struct ReceiptData has copy, drop, store {
        domain: vector<u8>,
        ledger: 0x2::object::ID,
        card: vector<u8>,
        request: vector<u8>,
        recipient: address,
        amount_jpy: u64,
        amount_mist: u64,
        observed_jpy: u64,
        redeemed_jpy: u64,
        sequence: u64,
        previous_receipt: address,
        previous_hash: vector<u8>,
        claim_root: vector<u8>,
        timestamp_ms: u64,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        data: ReceiptData,
        hash: vector<u8>,
    }

    struct Refunded has copy, drop {
        receipt: 0x2::object::ID,
        card: vector<u8>,
        sequence: u64,
        hash: vector<u8>,
    }

    struct MarketPolicy has key {
        id: 0x2::object::UID,
        ledger: 0x2::object::ID,
        paused: bool,
    }

    public fun claim_root(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        node(node(leaf(0x1::bcs::to_bytes<vector<u8>>(&arg0)), leaf(0x1::bcs::to_bytes<address>(&arg1))), node(leaf(0x1::bcs::to_bytes<u64>(&arg2)), leaf(0x1::bcs::to_bytes<u64>(&arg3))))
    }

    public fun configure(arg0: &AdminCap, arg1: &mut Ledger, arg2: address, arg3: bool) {
        assert!(arg0.ledger == 0x2::object::id<Ledger>(arg1), 0);
        arg1.operator = arg2;
        arg1.paused = arg3;
    }

    public fun deposit(arg0: &mut Ledger, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun enable_market(arg0: &AdminCap, arg1: &mut Ledger, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ledger == 0x2::object::id<Ledger>(arg1), 0);
        arg1.paused = true;
        let v0 = MarketPolicy{
            id     : 0x2::object::new(arg2),
            ledger : 0x2::object::id<Ledger>(arg1),
            paused : false,
        };
        0x2::transfer::share_object<MarketPolicy>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ledger{
            id       : 0x2::object::new(arg0),
            operator : 0x2::tx_context::sender(arg0),
            paused   : false,
            pool     : 0x2::balance::zero<0x2::sui::SUI>(),
            cards    : 0x2::table::new<vector<u8>, CardState>(arg0),
            requests : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        let v1 = AdminCap{
            id     : 0x2::object::new(arg0),
            ledger : 0x2::object::id<Ledger>(&v0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Ledger>(v0);
    }

    public fun leaf(arg0: vector<u8>) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::hash::sha2_256(v0)
    }

    public fun node(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = x"01";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::hash::sha2_256(v0)
    }

    public fun pause_market(arg0: &AdminCap, arg1: &mut MarketPolicy, arg2: bool) {
        assert!(arg0.ledger == arg1.ledger, 0);
        arg1.paused = arg2;
    }

    public fun refund(arg0: &mut Ledger, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.operator, 0);
        assert!(!arg0.paused, 6);
        let v0 = if (0x1::vector::length<u8>(&arg1) == 32) {
            if (0x1::vector::length<u8>(&arg2) == 32) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg5 <= 20000 && arg3 != @0x0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(v1 <= arg7 && arg7 - v1 <= 300000, 5);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.requests, arg2), 2);
        if (!0x2::table::contains<vector<u8>, CardState>(&arg0.cards, arg1)) {
            let v2 = CardState{
                redeemed_jpy : 0,
                sequence     : 0,
                head         : b"",
                latest       : @0x0,
            };
            0x2::table::add<vector<u8>, CardState>(&mut arg0.cards, arg1, v2);
        };
        let v3 = 0x2::table::borrow_mut<vector<u8>, CardState>(&mut arg0.cards, arg1);
        assert!(arg6 == v3.sequence, 4);
        assert!(v3.redeemed_jpy <= arg5 && arg4 <= arg5 - v3.redeemed_jpy, 3);
        let v4 = arg4 * 100000 * (10000 - 200) / 10000;
        let v5 = ReceiptData{
            domain           : b"UNSUI_RECEIPT_V2",
            ledger           : 0x2::object::id<Ledger>(arg0),
            card             : arg1,
            request          : arg2,
            recipient        : arg3,
            amount_jpy       : arg4,
            amount_mist      : v4,
            observed_jpy     : arg5,
            redeemed_jpy     : v3.redeemed_jpy + arg4,
            sequence         : v3.sequence + 1,
            previous_receipt : v3.latest,
            previous_hash    : v3.head,
            claim_root       : claim_root(arg1, arg3, arg4, arg5),
            timestamp_ms     : v1,
        };
        let v6 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<ReceiptData>(&v5));
        let v7 = Receipt{
            id   : 0x2::object::new(arg9),
            data : v5,
            hash : v6,
        };
        let v8 = 0x2::object::id<Receipt>(&v7);
        v3.redeemed_jpy = v5.redeemed_jpy;
        v3.sequence = v5.sequence;
        v3.head = v6;
        v3.latest = 0x2::object::id_address<Receipt>(&v7);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.requests, arg2, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, v4), arg9), arg3);
        let v9 = Refunded{
            receipt  : v8,
            card     : arg1,
            sequence : v5.sequence,
            hash     : v6,
        };
        0x2::event::emit<Refunded>(v9);
        0x2::transfer::freeze_object<Receipt>(v7);
    }

    public fun refund_market(arg0: &MarketPolicy, arg1: &mut Ledger, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == arg1.operator, 0);
        let v0 = if (arg0.ledger == 0x2::object::id<Ledger>(arg1)) {
            if (!arg0.paused) {
                arg1.paused
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        assert!(arg2 > 0 && arg2 <= 200000000000, 1);
        let v1 = if (0x1::vector::length<u8>(&arg3) == 32) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                arg6 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        assert!(arg7 <= 20000 && arg5 != @0x0, 1);
        let v2 = 0x2::clock::timestamp_ms(arg10);
        assert!(v2 <= arg9 && arg9 - v2 <= 300000, 5);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.requests, arg4), 2);
        if (!0x2::table::contains<vector<u8>, CardState>(&arg1.cards, arg3)) {
            let v3 = CardState{
                redeemed_jpy : 0,
                sequence     : 0,
                head         : b"",
                latest       : @0x0,
            };
            0x2::table::add<vector<u8>, CardState>(&mut arg1.cards, arg3, v3);
        };
        let v4 = 0x2::table::borrow_mut<vector<u8>, CardState>(&mut arg1.cards, arg3);
        assert!(arg8 == v4.sequence, 4);
        assert!(v4.redeemed_jpy <= arg7 && arg6 <= arg7 - v4.redeemed_jpy, 3);
        let v5 = ReceiptData{
            domain           : b"UNSUI_RECEIPT_V3",
            ledger           : 0x2::object::id<Ledger>(arg1),
            card             : arg3,
            request          : arg4,
            recipient        : arg5,
            amount_jpy       : arg6,
            amount_mist      : arg2,
            observed_jpy     : arg7,
            redeemed_jpy     : v4.redeemed_jpy + arg6,
            sequence         : v4.sequence + 1,
            previous_receipt : v4.latest,
            previous_hash    : v4.head,
            claim_root       : claim_root(arg3, arg5, arg6, arg7),
            timestamp_ms     : v2,
        };
        let v6 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<ReceiptData>(&v5));
        let v7 = Receipt{
            id   : 0x2::object::new(arg11),
            data : v5,
            hash : v6,
        };
        let v8 = 0x2::object::id<Receipt>(&v7);
        v4.redeemed_jpy = v5.redeemed_jpy;
        v4.sequence = v5.sequence;
        v4.head = v6;
        v4.latest = 0x2::object::id_address<Receipt>(&v7);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg1.requests, arg4, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pool, arg2), arg11), arg5);
        let v9 = Refunded{
            receipt  : v8,
            card     : arg3,
            sequence : v5.sequence,
            hash     : v6,
        };
        0x2::event::emit<Refunded>(v9);
        0x2::transfer::freeze_object<Receipt>(v7);
    }

    // decompiled from Move bytecode v7
}

