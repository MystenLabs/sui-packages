module 0x7c7ca3da6bad849a02d9f888b2f8cab40d507b2c01bbcab3f2d816334c17aa07::sluice {
    struct VestingSchedule<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        beneficiary: address,
        balance: 0x2::balance::Balance<T0>,
        total_amount: u64,
        released_amount: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        interval_ms: u64,
        target_marketcap: 0x1::option::Option<u64>,
        oracle_pubkey: vector<u8>,
        milestone_status: u8,
        revocable: bool,
    }

    struct ScheduleCreated has copy, drop {
        schedule_id: address,
        creator: address,
        beneficiary: address,
        total_amount: u64,
        target_marketcap: 0x1::option::Option<u64>,
    }

    struct VestingActivated has copy, drop {
        schedule_id: address,
        activated_at: u64,
    }

    struct TokensClaimed has copy, drop {
        schedule_id: address,
        beneficiary: address,
        amount: u64,
    }

    struct ScheduleCancelled has copy, drop {
        schedule_id: address,
        returned_amount: u64,
    }

    public entry fun activate_vesting<T0>(arg0: &mut VestingSchedule<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        assert!(arg0.milestone_status == 1, 4);
        let v0 = 0x2::object::uid_to_bytes(&arg0.id);
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.oracle_pubkey, &v0), 5);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg0.start_time_ms = v1;
        arg0.end_time_ms = v1 + arg0.end_time_ms - arg0.start_time_ms;
        arg0.milestone_status = 0;
        let v2 = VestingActivated{
            schedule_id  : 0x2::object::uid_to_address(&arg0.id),
            activated_at : v1,
        };
        0x2::event::emit<VestingActivated>(v2);
    }

    public fun calculate_vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg4 < arg1) {
            return 0
        };
        if (arg4 >= arg2) {
            return arg0
        };
        (((arg0 as u128) * (((arg4 - arg1) / arg3 * arg3) as u128) / ((arg2 - arg1) as u128)) as u64)
    }

    public entry fun cancel_schedule<T0>(arg0: &mut VestingSchedule<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 0);
        assert!(arg0.revocable, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1), arg0.creator);
        let v0 = ScheduleCancelled{
            schedule_id     : 0x2::object::uid_to_address(&arg0.id),
            returned_amount : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<ScheduleCancelled>(v0);
    }

    public entry fun claim_vested<T0>(arg0: &mut VestingSchedule<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.milestone_status == 0, 4);
        let v0 = calculate_vested_amount(arg0.total_amount, arg0.start_time_ms, arg0.end_time_ms, arg0.interval_ms, 0x2::clock::timestamp_ms(arg1)) - arg0.released_amount;
        assert!(v0 > 0, 2);
        arg0.released_amount = arg0.released_amount + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2), arg0.beneficiary);
        let v1 = TokensClaimed{
            schedule_id : 0x2::object::uid_to_address(&arg0.id),
            beneficiary : arg0.beneficiary,
            amount      : v0,
        };
        0x2::event::emit<TokensClaimed>(v1);
    }

    public entry fun create_schedule<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: vector<u8>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > arg2, 1);
        assert!(arg4 > 0, 1);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = if (0x1::option::is_some<u64>(&arg5)) {
            1
        } else {
            0
        };
        let v2 = VestingSchedule<T0>{
            id               : 0x2::object::new(arg8),
            creator          : 0x2::tx_context::sender(arg8),
            beneficiary      : arg1,
            balance          : 0x2::coin::into_balance<T0>(arg0),
            total_amount     : v0,
            released_amount  : 0,
            start_time_ms    : arg2,
            end_time_ms      : arg3,
            interval_ms      : arg4,
            target_marketcap : arg5,
            oracle_pubkey    : arg6,
            milestone_status : v1,
            revocable        : arg7,
        };
        let v3 = ScheduleCreated{
            schedule_id      : 0x2::object::uid_to_address(&v2.id),
            creator          : v2.creator,
            beneficiary      : arg1,
            total_amount     : v0,
            target_marketcap : arg5,
        };
        0x2::event::emit<ScheduleCreated>(v3);
        0x2::transfer::share_object<VestingSchedule<T0>>(v2);
    }

    public entry fun reassign_beneficiary<T0>(arg0: &mut VestingSchedule<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, arg1);
        assert!(0x2::address::from_bytes(0x2::hash::blake2b256(&v0)) == arg0.beneficiary, 0);
        let v1 = 0x2::object::uid_to_bytes(&arg0.id);
        0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1, &v1), 5);
        arg0.beneficiary = arg3;
    }

    // decompiled from Move bytecode v7
}

