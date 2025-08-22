module 0x2e2fab2ef5df6bc02a82c708b532100c7b5f140ffef12e79c066e667fcf67eb4::vesting {
    struct VESTING has drop {
        dummy_field: bool,
    }

    struct VestingStatus has store, key {
        id: 0x2::object::UID,
    }

    struct VestingSchedule has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        total_balance: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
        amount_per_period: u64,
        total_claimed: u64,
        claimed_timestamps: 0x2::vec_map::VecMap<u64, bool>,
        claimed_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VestingScheduleCreated has copy, drop {
        beneficiary: address,
        total_amount: u64,
        schedule_count: u64,
    }

    struct CoinReleased has copy, drop {
        beneficiary: address,
        amount: u64,
    }

    fun calculate_claimable_tokens(arg0: &VestingSchedule, arg1: u64) : (u64, vector<u64>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = arg0.claimed_count;
        let v3 = 0x2::vec_map::size<u64, bool>(&arg0.claimed_timestamps);
        while (v2 < v3) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<u64, bool>(&arg0.claimed_timestamps, v2);
            if (*v4 > arg1) {
                break
            };
            if (!*v5) {
                v0 = v0 + arg0.amount_per_period;
                0x1::vector::push_back<u64>(&mut v1, *v4);
            };
            v2 = v2 + 1;
        };
        if (arg0.claimed_count + v2 - arg0.claimed_count == v3) {
            v0 = 0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg0.total_balance);
        };
        (v0, v1)
    }

    public fun claim_tokens(arg0: &mut VestingStatus, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow_mut<address, VestingSchedule>(&mut arg0.id, v0);
        let (v2, v3) = calculate_claimable_tokens(v1, 0x2::clock::timestamp_ms(arg1));
        let v4 = v3;
        assert!(v2 > 0, 4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v4)) {
            let v6 = *0x1::vector::borrow<u64>(&v4, v5);
            *0x2::vec_map::get_mut<u64, bool>(&mut v1.claimed_timestamps, &v6) = true;
            v5 = v5 + 1;
        };
        v1.claimed_count = v1.claimed_count + v5;
        v1.total_claimed = v1.total_claimed + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>>(0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut v1.total_balance, v2), arg2), v0);
        let v7 = CoinReleased{
            beneficiary : v0,
            amount      : v2,
        };
        0x2::event::emit<CoinReleased>(v7);
    }

    public entry fun create_vesting_schedule(arg0: &AdminCap, arg1: &mut VestingStatus, arg2: 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg3: address, arg4: vector<u64>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 1);
        assert!(0x1::vector::length<u64>(&arg4) > 0, 6);
        assert!(arg5 > 0, 2);
        assert!(0x2::coin::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg2) >= arg5 * 0x1::vector::length<u64>(&arg4), 8);
        let v0 = 1;
        while (v0 < 0x1::vector::length<u64>(&arg4)) {
            assert!(*0x1::vector::borrow<u64>(&arg4, v0 - 1) < *0x1::vector::borrow<u64>(&arg4, v0), 7);
            v0 = v0 + 1;
        };
        let v1 = 0x2::coin::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg2);
        assert!(v1 > 0, 2);
        let v2 = 0x2::vec_map::empty<u64, bool>();
        v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg4)) {
            0x2::vec_map::insert<u64, bool>(&mut v2, *0x1::vector::borrow<u64>(&arg4, v0), false);
            v0 = v0 + 1;
        };
        let v3 = VestingSchedule{
            id                 : 0x2::object::new(arg6),
            beneficiary        : arg3,
            total_balance      : 0x2::coin::into_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(arg2),
            amount_per_period  : arg5,
            total_claimed      : 0,
            claimed_timestamps : v2,
            claimed_count      : 0,
        };
        0x2::dynamic_field::add<address, VestingSchedule>(&mut arg1.id, arg3, v3);
        let v4 = VestingScheduleCreated{
            beneficiary    : arg3,
            total_amount   : v1,
            schedule_count : 0x1::vector::length<u64>(&arg4),
        };
        0x2::event::emit<VestingScheduleCreated>(v4);
    }

    public fun get_claimable_amount(arg0: &VestingStatus, arg1: address, arg2: u64) : u64 {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            return 0
        };
        let (v0, _) = calculate_claimable_tokens(0x2::dynamic_field::borrow<address, VestingSchedule>(&arg0.id, arg1), arg2);
        v0
    }

    public fun get_vesting_info(arg0: &VestingStatus, arg1: address) : (u64, u64, u64, u64, vector<u64>, vector<u64>, vector<bool>) {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            return (0, 0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>())
        };
        let v0 = 0x2::dynamic_field::borrow<address, VestingSchedule>(&arg0.id, arg1);
        let v1 = 0x2::vec_map::size<u64, bool>(&v0.claimed_timestamps);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<bool>();
        let v5 = 0;
        while (v5 < v1) {
            let (v6, v7) = 0x2::vec_map::get_entry_by_idx<u64, bool>(&v0.claimed_timestamps, v5);
            0x1::vector::push_back<u64>(&mut v2, *v6);
            0x1::vector::push_back<u64>(&mut v3, v0.amount_per_period);
            0x1::vector::push_back<bool>(&mut v4, *v7);
            v5 = v5 + 1;
        };
        (0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&v0.total_balance), v0.total_claimed, v0.amount_per_period * v1, v1, v2, v3, v4)
    }

    fun init(arg0: VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = VestingStatus{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<VestingStatus>(v1);
    }

    // decompiled from Move bytecode v6
}

