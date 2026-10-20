module 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::governance {
    struct Governance has key {
        id: 0x2::object::UID,
        version: u64,
        cap: 0x1::option::Option<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>,
        first_ballot_epoch: u64,
        board_id: 0x1::option::Option<0x2::object::ID>,
        config_id: 0x1::option::Option<0x2::object::ID>,
        dist_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        ballots: 0x2::table::Table<u64, Ballot>,
    }

    struct Ballot has store {
        total: u64,
        counts: vector<vector<u64>>,
        circulating: u64,
        executed: bool,
    }

    struct VoteReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        ballot_epoch: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct VotedEvent has copy, drop {
        ballot_epoch: u64,
        voter: address,
        amount: u64,
        choices: vector<u8>,
    }

    struct BallotExecutedEvent has copy, drop {
        ballot_epoch: u64,
        quorum_met: bool,
        applied: vector<bool>,
    }

    public(friend) fun assert_version(arg0: &Governance) {
        assert!(arg0.version == 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::version(), 0);
    }

    fun apply_choice(arg0: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap, arg1: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config, arg2: u64, arg3: u64) : bool {
        if (arg2 == 0) {
            0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::gov_set_prize_shape(arg0, arg1, (arg3 as u8))
        } else if (arg2 == 1) {
            let v1 = vector[600, 800, 1000];
            0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::gov_set_buyback(arg0, arg1, *0x1::vector::borrow<u64>(&v1, arg3))
        } else if (arg2 == 2) {
            let v2 = vector[2500, 3500, 4500];
            0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::gov_set_drain(arg0, arg1, *0x1::vector::borrow<u64>(&v2, arg3))
        } else {
            let v3 = vector[5000, 7000, 9000];
            0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::gov_set_decay_midpoint(arg0, arg1, *0x1::vector::borrow<u64>(&v3, arg3))
        }
    }

    fun assert_board(arg0: &Governance, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.board_id), 1);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.board_id) == 0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard>(arg1), 2);
    }

    public fun ballot_circulating(arg0: &Governance, arg1: u64) : u64 {
        0x2::table::borrow<u64, Ballot>(&arg0.ballots, arg1).circulating
    }

    public fun ballot_count(arg0: &Governance, arg1: u64, arg2: u64, arg3: u64) : u64 {
        *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&0x2::table::borrow<u64, Ballot>(&arg0.ballots, arg1).counts, arg2), arg3)
    }

    public fun ballot_executed(arg0: &Governance, arg1: u64) : bool {
        0x2::table::borrow<u64, Ballot>(&arg0.ballots, arg1).executed
    }

    public fun ballot_total(arg0: &Governance, arg1: u64) : u64 {
        0x2::table::borrow<u64, Ballot>(&arg0.ballots, arg1).total
    }

    public(friend) fun bootstrap(arg0: &mut Governance, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.board_id), 11);
        arg0.first_ballot_epoch = arg1 + 4;
        arg0.board_id = 0x1::option::some<0x2::object::ID>(arg2);
        arg0.config_id = 0x1::option::some<0x2::object::ID>(arg3);
    }

    public fun circulating<T0>(arg0: &0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::Distributor<T0>, arg1: &0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::OperatorLock<T0>) : u64 {
        100000000000000000 - 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::pool_value<T0>(arg0) - 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::locked_value<T0>(arg1)
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Governance{
            id                 : 0x2::object::new(arg2),
            version            : 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::version(),
            cap                : 0x1::option::none<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(),
            first_ballot_epoch : 0,
            board_id           : 0x1::option::none<0x2::object::ID>(),
            config_id          : 0x1::option::none<0x2::object::ID>(),
            dist_id            : arg0,
            lock_id            : arg1,
            ballots            : 0x2::table::new<u64, Ballot>(arg2),
        };
        0x2::transfer::share_object<Governance>(v0);
    }

    public fun dist_id(arg0: &Governance) : 0x2::object::ID {
        arg0.dist_id
    }

    public fun execute(arg0: &mut Governance, arg1: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg2: &mut 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config) {
        assert_version(arg0);
        assert_board(arg0, arg1);
        assert!(0x2::object::id<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::Config>(arg2) == *0x1::option::borrow<0x2::object::ID>(&arg0.config_id), 2);
        let v0 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg1);
        let v1 = arg0.first_ballot_epoch;
        assert!(v0 > v1, 5);
        let v2 = v1 + (v0 - 1 - v1) / 4 * 4;
        assert!(v0 - v2 < 4, 6);
        assert!(0x2::table::contains<u64, Ballot>(&arg0.ballots, v2), 8);
        assert!(0x1::option::is_some<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&arg0.cap), 10);
        let v3 = 0x2::table::borrow_mut<u64, Ballot>(&mut arg0.ballots, v2);
        assert!(!v3.executed, 7);
        v3.executed = true;
        let v4 = (v3.total as u128) * (10000 as u128) >= (v3.circulating as u128) * (1000 as u128) && v3.total >= 1000000000000000;
        let v5 = vector[false, false, false, false];
        if (v4) {
            let v6 = 0x1::option::borrow<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&arg0.cap);
            let v7 = 0;
            while (v7 < 4) {
                let v8 = winner(0x1::vector::borrow<vector<u64>>(&v3.counts, v7));
                if (0x1::option::is_some<u64>(&v8)) {
                    *0x1::vector::borrow_mut<bool>(&mut v5, v7) = apply_choice(v6, arg2, v7, 0x1::option::destroy_some<u64>(v8));
                };
                v7 = v7 + 1;
            };
        };
        let v9 = BallotExecutedEvent{
            ballot_epoch : v2,
            quorum_met   : v4,
            applied      : v5,
        };
        0x2::event::emit<BallotExecutedEvent>(v9);
    }

    public fun first_ballot_epoch(arg0: &Governance) : u64 {
        arg0.first_ballot_epoch
    }

    public fun governor_generation(arg0: &Governance) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&arg0.cap)) {
            0x1::option::some<u64>(0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::governor_cap_generation(0x1::option::borrow<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&arg0.cap)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun has_ballot(arg0: &Governance, arg1: u64) : bool {
        0x2::table::contains<u64, Ballot>(&arg0.ballots, arg1)
    }

    public fun has_governor(arg0: &Governance) : bool {
        0x1::option::is_some<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&arg0.cap)
    }

    public fun install(arg0: &mut Governance, arg1: 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap) {
        assert_version(arg0);
        if (0x1::option::is_none<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&arg0.cap)) {
            0x1::option::fill<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&mut arg0.cap, arg1);
            return
        };
        assert!(0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::governor_cap_generation(&arg1) > 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::governor_cap_generation(0x1::option::borrow<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&arg0.cap)), 9);
        0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::destroy_governor_cap(0x1::option::swap<0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::GovernorCap>(&mut arg0.cap, arg1));
    }

    public fun is_ballot_epoch(arg0: &Governance, arg1: u64) : bool {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.board_id)) {
            if (arg1 >= arg0.first_ballot_epoch) {
                (arg1 - arg0.first_ballot_epoch) % 4 == 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun lock_id(arg0: &Governance) : 0x2::object::ID {
        arg0.lock_id
    }

    public(friend) fun migrate(arg0: &mut Governance) {
        assert!(arg0.version < 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::version(), 0);
        arg0.version = 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::version();
    }

    fun new_ballot() : Ballot {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 4) {
            0x1::vector::push_back<vector<u64>>(&mut v0, vector[0, 0, 0]);
            v1 = v1 + 1;
        };
        Ballot{
            total       : 0,
            counts      : v0,
            circulating : 0,
            executed    : false,
        }
    }

    public fun receipt_ballot_epoch<T0>(arg0: &VoteReceipt<T0>) : u64 {
        arg0.ballot_epoch
    }

    public fun receipt_value<T0>(arg0: &VoteReceipt<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun vote<T0>(arg0: &mut Governance, arg1: &0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::Distributor<T0>, arg2: &0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::OperatorLock<T0>, arg3: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg4: 0x2::coin::Coin<T0>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::assert_version<T0>(arg1);
        0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::assert_version<T0>(arg2);
        assert_board(arg0, arg3);
        assert!(0x2::object::id<0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::Distributor<T0>>(arg1) == arg0.dist_id && 0x2::object::id<0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::OperatorLock<T0>>(arg2) == arg0.lock_id, 2);
        let v0 = 0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg3);
        assert!(is_ballot_epoch(arg0, v0), 3);
        assert!(0x1::vector::length<u8>(&arg5) == 4, 4);
        let v1 = &arg5;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            let v3 = 0x1::vector::borrow<u8>(v1, v2);
            assert!((*v3 as u64) < 3 || *v3 == 255, 4);
            v2 = v2 + 1;
        };
        if (!0x2::table::contains<u64, Ballot>(&arg0.ballots, v0)) {
            0x2::table::add<u64, Ballot>(&mut arg0.ballots, v0, new_ballot());
        };
        let v4 = 0x2::coin::value<T0>(&arg4);
        let v5 = 0x2::table::borrow_mut<u64, Ballot>(&mut arg0.ballots, v0);
        v5.total = v5.total + v4;
        let v6 = 0;
        while (v6 < 4) {
            let v7 = *0x1::vector::borrow<u8>(&arg5, v6);
            if (v7 != 255) {
                let v8 = 0x1::vector::borrow_mut<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut v5.counts, v6), (v7 as u64));
                *v8 = *v8 + v4;
            };
            v6 = v6 + 1;
        };
        v5.circulating = 100000000000000000 - 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::distributor::pool_value<T0>(arg1) - 0x2b56cac54d40b764383602c155833cc13d645f61a4cb29f06d1d97419fc4c19e::lock::locked_value<T0>(arg2);
        let v9 = 0x2::tx_context::sender(arg6);
        let v10 = VoteReceipt<T0>{
            id           : 0x2::object::new(arg6),
            ballot_epoch : v0,
            balance      : 0x2::coin::into_balance<T0>(arg4),
        };
        0x2::transfer::public_transfer<VoteReceipt<T0>>(v10, v9);
        let v11 = VotedEvent{
            ballot_epoch : v0,
            voter        : v9,
            amount       : v4,
            choices      : arg5,
        };
        0x2::event::emit<VotedEvent>(v11);
    }

    fun winner(arg0: &vector<u64>) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1 = v0;
        let v2 = false;
        let v3 = 0;
        while (v3 < 3) {
            let v4 = *0x1::vector::borrow<u64>(arg0, v3);
            if (v4 > v0) {
                v1 = v4;
                v2 = false;
            } else if (v4 == v0) {
                v2 = true;
            };
            v3 = v3 + 1;
        };
        if (v1 == 0 || v2) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0)
        }
    }

    public fun withdraw<T0>(arg0: &Governance, arg1: VoteReceipt<T0>, arg2: &0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::EpochBoard, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg0);
        assert_board(arg0, arg2);
        assert!(0xc8921698a36dac5e48048d782608e62e00f3ed0f2e21f2e0c17b898457d4825::economy::epoch(arg2) > arg1.ballot_epoch, 5);
        let VoteReceipt {
            id           : v0,
            ballot_epoch : _,
            balance      : v2,
        } = arg1;
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v2, arg3)
    }

    // decompiled from Move bytecode v7
}

