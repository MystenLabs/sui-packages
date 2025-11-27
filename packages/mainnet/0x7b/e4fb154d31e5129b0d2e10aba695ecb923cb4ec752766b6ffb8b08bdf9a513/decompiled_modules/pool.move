module 0x7be4fb154d31e5129b0d2e10aba695ecb923cb4ec752766b6ffb8b08bdf9a513::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        denomination: u64,
        pool_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        gas_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_address: address,
        gas_address: address,
        nullifiers: 0x2::table::Table<u256, bool>,
        deposit_count: u64,
        withdrawal_count: u64,
        current_root: u256,
        filled_subtrees: 0x2::table::Table<u64, u256>,
        root_history: 0x2::table::Table<u64, u256>,
        current_root_index: u64,
        next_leaf_index: u64,
    }

    struct PoolAdmin has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        commitment: u256,
        leaf_index: u64,
        timestamp: u64,
    }

    struct WithdrawalEvent has copy, drop {
        pool_id: 0x2::object::ID,
        nullifier: u256,
        recipient: address,
        timestamp: u64,
    }

    struct TreasuryWithdrawalEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct GasWithdrawalEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct TreeCapacityWarningEvent has copy, drop {
        pool_id: 0x2::object::ID,
        current_leaves: u64,
        max_leaves: u64,
        timestamp: u64,
    }

    fun append_u256_le(arg0: &mut vector<u8>, arg1: u256) {
        let v0 = 0;
        while (v0 < 32) {
            0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
            arg1 = arg1 >> 8;
            v0 = v0 + 1;
        };
    }

    fun bytes_to_u256_be(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    fun construct_public_inputs(arg0: u256, arg1: u256, arg2: address, arg3: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        append_u256_le(v1, arg0);
        let v2 = &mut v0;
        append_u256_le(v2, arg1);
        let v3 = 0x2::address::to_bytes(arg2);
        assert!(0x1::vector::length<u8>(&v3) == 32, 10);
        let v4 = &mut v0;
        append_u256_le(v4, bytes_to_u256_be(&v3));
        let v5 = &mut v0;
        append_u256_le(v5, (arg3 as u256));
        v0
    }

    public fun create_pool(arg0: u64, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : PoolAdmin {
        let v0 = if (arg0 == 1000000000) {
            true
        } else if (arg0 == 10000000000) {
            true
        } else {
            arg0 == 100000000000
        };
        assert!(v0, 1);
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::table::new<u64, u256>(arg3);
        let v3 = 0;
        while (v3 < 20) {
            0x2::table::add<u64, u256>(&mut v2, v3, get_zero_hash(v3));
            v3 = v3 + 1;
        };
        let v4 = get_zero_hash(20);
        let v5 = 0x2::table::new<u64, u256>(arg3);
        0x2::table::add<u64, u256>(&mut v5, 0, v4);
        let v6 = Pool{
            id                 : v1,
            denomination       : arg0,
            pool_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            gas_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_address   : arg1,
            gas_address        : arg2,
            nullifiers         : 0x2::table::new<u256, bool>(arg3),
            deposit_count      : 0,
            withdrawal_count   : 0,
            current_root       : v4,
            filled_subtrees    : v2,
            root_history       : v5,
            current_root_index : 0,
            next_leaf_index    : 0,
        };
        0x2::transfer::share_object<Pool>(v6);
        PoolAdmin{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::uid_to_inner(&v1),
        }
    }

    public fun current_root(arg0: &Pool) : u256 {
        arg0.current_root
    }

    public fun denomination(arg0: &Pool) : u64 {
        arg0.denomination
    }

    public fun deposit(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.denomination + arg0.denomination * 500 / 10000, 2);
        assert!(arg2 != 0, 9);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.denomination * 400 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.denomination * 100 / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_balance, v0);
        let v1 = arg0.next_leaf_index;
        insert_leaf(arg0, arg2, arg3);
        arg0.deposit_count = arg0.deposit_count + 1;
        let v2 = DepositEvent{
            pool_id    : 0x2::object::id<Pool>(arg0),
            commitment : arg2,
            leaf_index : v1,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun deposit_count(arg0: &Pool) : u64 {
        arg0.deposit_count
    }

    public fun gas_balance(arg0: &Pool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance)
    }

    fun get_zero_hash(arg0: u64) : u256 {
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            14744269619966411208579211824598458697587494354926760081771325075741142829156
        } else if (arg0 == 2) {
            7423237065226347324353380772367382631490014989348495481811164164159255474657
        } else if (arg0 == 3) {
            11286972368698509976183087595462810875513684078608517520839298933882497716792
        } else if (arg0 == 4) {
            3607627140608796879659380071776844901612302623152076817094415224584923813162
        } else if (arg0 == 5) {
            19712377064642672829441595136074946683621277828620209496774504837737984048981
        } else if (arg0 == 6) {
            20775607673010627194014556968476266066927294572720319469184847051418138353016
        } else if (arg0 == 7) {
            3396914609616007258851405644437304192397291162432396347162513310381425243293
        } else if (arg0 == 8) {
            21551820661461729022865262380882070649935529853313286572328683688269863701601
        } else if (arg0 == 9) {
            6573136701248752079028194407151022595060682063033565181951145966236778420039
        } else if (arg0 == 10) {
            12413880268183407374852357075976609371175688755676981206018884971008854919922
        } else if (arg0 == 11) {
            14271763308400718165336499097156975241954733520325982997864342600795471836726
        } else if (arg0 == 12) {
            20066985985293572387227381049700832219069292839614107140851619262827735677018
        } else if (arg0 == 13) {
            9394776414966240069580838672673694685292165040808226440647796406499139370960
        } else if (arg0 == 14) {
            11331146992410411304059858900317123658895005918277453009197229807340014528524
        } else if (arg0 == 15) {
            15819538789928229930262697811477882737253464456578333862691129291651619515538
        } else if (arg0 == 16) {
            19217088683336594659449020493828377907203207941212636669271704950158751593251
        } else if (arg0 == 17) {
            21035245323335827719745544373081896983162834604456827698288649288827293579666
        } else if (arg0 == 18) {
            6939770416153240137322503476966641397417391950902474480970945462551409848591
        } else if (arg0 == 19) {
            10941962436777715901943463195175331263348098796018438960955633645115732864202
        } else {
            15019797232609675441998260052101280400536945603062888308240081994073687793470
        }
    }

    fun insert_leaf(arg0: &mut Pool, arg1: u256, arg2: &0x2::tx_context::TxContext) : u256 {
        let v0 = 1 << (20 as u8);
        assert!(arg0.next_leaf_index < v0, 6);
        if (arg0.next_leaf_index >= v0 * 9 / 10) {
            let v1 = TreeCapacityWarningEvent{
                pool_id        : 0x2::object::id<Pool>(arg0),
                current_leaves : arg0.next_leaf_index,
                max_leaves     : v0,
                timestamp      : 0x2::tx_context::epoch(arg2),
            };
            0x2::event::emit<TreeCapacityWarningEvent>(v1);
        };
        let v2 = arg0.next_leaf_index;
        let v3 = arg1;
        let v4 = 0;
        while (v4 < 20) {
            if (v2 % 2 == 0) {
                *0x2::table::borrow_mut<u64, u256>(&mut arg0.filled_subtrees, v4) = v3;
                v3 = 0x7be4fb154d31e5129b0d2e10aba695ecb923cb4ec752766b6ffb8b08bdf9a513::poseidon::hash2(v3, get_zero_hash(v4));
            } else {
                v3 = 0x7be4fb154d31e5129b0d2e10aba695ecb923cb4ec752766b6ffb8b08bdf9a513::poseidon::hash2(*0x2::table::borrow<u64, u256>(&arg0.filled_subtrees, v4), v3);
            };
            v2 = v2 / 2;
            v4 = v4 + 1;
        };
        let v5 = (arg0.current_root_index + 1) % 1000;
        if (0x2::table::contains<u64, u256>(&arg0.root_history, v5)) {
            *0x2::table::borrow_mut<u64, u256>(&mut arg0.root_history, v5) = v3;
        } else {
            0x2::table::add<u64, u256>(&mut arg0.root_history, v5, v3);
        };
        arg0.current_root_index = v5;
        arg0.current_root = v3;
        arg0.next_leaf_index = arg0.next_leaf_index + 1;
        v3
    }

    public fun is_known_root(arg0: &Pool, arg1: u256) : bool {
        if (arg1 == 0) {
            return false
        };
        if (arg1 == arg0.current_root) {
            return true
        };
        let v0 = 0;
        while (v0 < 1000) {
            if (0x2::table::contains<u64, u256>(&arg0.root_history, v0)) {
                if (*0x2::table::borrow<u64, u256>(&arg0.root_history, v0) == arg1) {
                    return true
                };
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_nullifier_spent(arg0: &Pool, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.nullifiers, arg1)
    }

    public fun next_leaf_index(arg0: &Pool) : u64 {
        arg0.next_leaf_index
    }

    public fun pool_balance(arg0: &Pool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool_balance)
    }

    public fun root_slots_remaining(arg0: &Pool, arg1: u256) : u64 {
        if (!is_known_root(arg0, arg1)) {
            return 0
        };
        let v0 = 0;
        while (v0 < 1000) {
            if (0x2::table::contains<u64, u256>(&arg0.root_history, v0) && *0x2::table::borrow<u64, u256>(&arg0.root_history, v0) == arg1) {
                if (v0 >= arg0.current_root_index) {
                    return v0 - arg0.current_root_index + 1
                };
                return 1000 - arg0.current_root_index + v0 + 1
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun treasury_balance(arg0: &Pool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_balance)
    }

    public fun tree_capacity_info(arg0: &Pool) : (u64, u64) {
        (arg0.next_leaf_index, 1 << (20 as u8))
    }

    public fun withdraw(arg0: &mut Pool, arg1: vector<u8>, arg2: vector<u8>, arg3: u256, arg4: u256, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == construct_public_inputs(arg3, arg4, arg5, arg0.denomination), 7);
        assert!(is_known_root(arg0, arg3), 5);
        assert!(!0x2::table::contains<u256, bool>(&arg0.nullifiers, arg4), 3);
        let v0 = arg0.denomination;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pool_balance) >= v0, 8);
        let v1 = 0x2::groth16::proof_points_from_bytes(arg1);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        assert!(0x7be4fb154d31e5129b0d2e10aba695ecb923cb4ec752766b6ffb8b08bdf9a513::verifier::verify_withdrawal_proof(&v1, &v2), 4);
        0x2::table::add<u256, bool>(&mut arg0.nullifiers, arg4, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool_balance, v0), arg6), arg5);
        arg0.withdrawal_count = arg0.withdrawal_count + 1;
        let v3 = WithdrawalEvent{
            pool_id   : 0x2::object::id<Pool>(arg0),
            nullifier : arg4,
            recipient : arg5,
            timestamp : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<WithdrawalEvent>(v3);
    }

    public fun withdraw_gas_fees(arg0: &mut Pool, arg1: &PoolAdmin, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, v0), arg2), arg0.gas_address);
            let v1 = GasWithdrawalEvent{
                pool_id   : 0x2::object::id<Pool>(arg0),
                amount    : v0,
                recipient : arg0.gas_address,
                timestamp : 0x2::tx_context::epoch(arg2),
            };
            0x2::event::emit<GasWithdrawalEvent>(v1);
        };
    }

    public fun withdraw_treasury(arg0: &mut Pool, arg1: &PoolAdmin, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury_balance, v0), arg2), arg0.treasury_address);
            let v1 = TreasuryWithdrawalEvent{
                pool_id   : 0x2::object::id<Pool>(arg0),
                amount    : v0,
                recipient : arg0.treasury_address,
                timestamp : 0x2::tx_context::epoch(arg2),
            };
            0x2::event::emit<TreasuryWithdrawalEvent>(v1);
        };
    }

    public fun withdrawal_count(arg0: &Pool) : u64 {
        arg0.withdrawal_count
    }

    // decompiled from Move bytecode v6
}

