module 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gbet_distribution {
    struct ClaimRecord has store {
        last_claim: u64,
        creation_reward_remaining: u64,
    }

    struct Distributor has key {
        id: 0x2::object::UID,
        version: u64,
        d1: u64,
        d2: u64,
        d3: u64,
        d4: u64,
        r1: u64,
        r2: u64,
        r3: u64,
        time_divisor: u64,
        schedule_set: bool,
        records: 0x2::table::Table<u64, ClaimRecord>,
        minter_cap: 0x1::option::Option<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>,
    }

    struct Claimed has copy, drop {
        nft_id: 0x2::object::ID,
        number: u64,
        owner: address,
        amount: u64,
        daily_part: u64,
        creation_part: u64,
        new_last_claim: u64,
    }

    struct RecordSeeded has copy, drop {
        number: u64,
        last_claim: u64,
        creation_reward_remaining: u64,
    }

    struct RecordFixed has copy, drop {
        number: u64,
        old_last_claim: u64,
        new_last_claim: u64,
        old_reward: u64,
        new_reward: u64,
    }

    struct ScheduleSet has copy, drop {
        d1: u64,
        d2: u64,
        d3: u64,
        d4: u64,
        r1: u64,
        r2: u64,
        r3: u64,
    }

    struct MinterCapInstalled has copy, drop {
        dummy_field: bool,
    }

    struct MinterCapWithdrawn has copy, drop {
        dummy_field: bool,
    }

    fun accrue_daily(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (u64, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg2);
        0x1::vector::push_back<u64>(v1, arg3);
        0x1::vector::push_back<u64>(v1, arg4);
        0x1::vector::push_back<u64>(v1, arg5);
        0x1::vector::push_back<u64>(v1, 18446744073709551615);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0);
        0x1::vector::push_back<u64>(v3, arg6);
        0x1::vector::push_back<u64>(v3, arg7);
        0x1::vector::push_back<u64>(v3, arg8);
        0x1::vector::push_back<u64>(v3, 0);
        let v4 = 0;
        let v5 = arg0;
        let v6 = 0;
        while (v6 < 5) {
            let v7 = *0x1::vector::borrow<u64>(&v0, v6);
            let v8 = *0x1::vector::borrow<u64>(&v2, v6);
            v6 = v6 + 1;
            if (arg1 <= arg0) {
                break
            };
            if (v7 <= arg0) {
                continue
            };
            let v9 = if (arg1 < v7) {
                arg1
            } else {
                v7
            };
            let v10 = (v9 - arg0) / 86400000;
            if (v8 > 0 && v10 > 0) {
                v4 = v4 + (((v10 as u128) * (v8 as u128) * (1000000000 as u128)) as u64);
            };
            if (arg1 < v7) {
                v5 = arg0 + v10 * 86400000;
                break
            };
            v5 = v7;
        };
        (v4, v5)
    }

    fun assert_version(arg0: &Distributor) {
        assert!(arg0.version == 1, 13906834728395472917);
    }

    public fun claim(arg0: &mut Distributor, arg1: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet, arg2: &mut 0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::TreasuryCapHolder, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET> {
        assert_version(arg0);
        assert!(arg0.schedule_set, 13906834994682134529);
        assert!(0x1::option::is_some<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>(&arg0.minter_cap), 13906834998977232899);
        let v0 = 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_number(arg1);
        assert!(0x2::table::contains<u64, ClaimRecord>(&arg0.records, v0), 13906835007567429639);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::table::borrow<u64, ClaimRecord>(&arg0.records, v0);
        let v3 = v2.last_claim;
        let v4 = v2.creation_reward_remaining;
        assert!(v3 <= v1, 13906835033337757711);
        let (v5, v6) = accrue_daily(v3, v1, arg0.d1, arg0.d2, arg0.d3, arg0.d4, arg0.r1, arg0.r2, arg0.r3);
        let v7 = v5 + v4;
        assert!(v7 > 0, 13906835067697233931);
        let v8 = 0x2::table::borrow_mut<u64, ClaimRecord>(&mut arg0.records, v0);
        v8.last_claim = v6;
        v8.creation_reward_remaining = 0;
        let v9 = Claimed{
            nft_id         : 0x2::object::id<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet>(arg1),
            number         : v0,
            owner          : 0x2::tx_context::sender(arg4),
            amount         : v7,
            daily_part     : v5,
            creation_part  : v4,
            new_last_claim : v6,
        };
        0x2::event::emit<Claimed>(v9);
        0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::mint(arg2, 0x1::option::borrow<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>(&arg0.minter_cap), v7, arg4)
    }

    public fun fix_record(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut Distributor, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg1);
        assert!(0x2::table::contains<u64, ClaimRecord>(&arg1.records, arg2), 13906835595977949191);
        let v0 = 0x2::table::borrow_mut<u64, ClaimRecord>(&mut arg1.records, arg2);
        v0.last_claim = arg3;
        v0.creation_reward_remaining = arg4;
        let v1 = RecordFixed{
            number         : arg2,
            old_last_claim : v0.last_claim,
            new_last_claim : arg3,
            old_reward     : v0.creation_reward_remaining,
            new_reward     : arg4,
        };
        0x2::event::emit<RecordFixed>(v1);
    }

    public fun get_claimable(arg0: &Distributor, arg1: &0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::Gangstabet, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::get_number(arg1);
        assert!(0x2::table::contains<u64, ClaimRecord>(&arg0.records, v0), 13906835179366121479);
        let v1 = 0x2::table::borrow<u64, ClaimRecord>(&arg0.records, v0);
        let (v2, _) = accrue_daily(v1.last_claim, 0x2::clock::timestamp_ms(arg2), arg0.d1, arg0.d2, arg0.d3, arg0.d4, arg0.r1, arg0.r2, arg0.r3);
        v2 + v1.creation_reward_remaining
    }

    public fun get_last_claim(arg0: &Distributor, arg1: u64) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u64, ClaimRecord>(&arg0.records, arg1)) {
            0x1::option::some<u64>(0x2::table::borrow<u64, ClaimRecord>(&arg0.records, arg1).last_claim)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_time_divisor(arg0: &Distributor) : u64 {
        arg0.time_divisor
    }

    public fun has_minter_cap(arg0: &Distributor) : bool {
        0x1::option::is_some<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>(&arg0.minter_cap)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor{
            id           : 0x2::object::new(arg0),
            version      : 1,
            d1           : 0,
            d2           : 0,
            d3           : 0,
            d4           : 0,
            r1           : 0,
            r2           : 0,
            r3           : 0,
            time_divisor : 1,
            schedule_set : false,
            records      : 0x2::table::new<u64, ClaimRecord>(arg0),
            minter_cap   : 0x1::option::none<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>(),
        };
        0x2::transfer::share_object<Distributor>(v0);
    }

    public fun install_minter_cap(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut Distributor, arg2: 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>) {
        assert_version(arg1);
        assert!(0x1::option::is_none<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>(&arg1.minter_cap), 13906835724826836997);
        0x1::option::fill<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>(&mut arg1.minter_cap, arg2);
        let v0 = MinterCapInstalled{dummy_field: false};
        0x2::event::emit<MinterCapInstalled>(v0);
    }

    public fun is_schedule_set(arg0: &Distributor) : bool {
        arg0.schedule_set
    }

    public fun migrate(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut Distributor) {
        assert!(arg1.version < 1, 13906834758460375063);
        arg1.version = 1;
    }

    public fun seed_record(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut Distributor, arg2: u64, arg3: u64, arg4: u64) {
        assert_version(arg1);
        assert!(!0x2::table::contains<u64, ClaimRecord>(&arg1.records, arg2), 13906834831473901577);
        let v0 = arg3 / arg1.time_divisor;
        let v1 = ClaimRecord{
            last_claim                : v0,
            creation_reward_remaining : arg4,
        };
        0x2::table::add<u64, ClaimRecord>(&mut arg1.records, arg2, v1);
        let v2 = RecordSeeded{
            number                    : arg2,
            last_claim                : v0,
            creation_reward_remaining : arg4,
        };
        0x2::event::emit<RecordSeeded>(v2);
    }

    public fun seed_records(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut Distributor, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0 && 0x1::vector::length<u64>(&arg4) == v0, 13906834895898935313);
        let v1 = 0;
        while (v1 < v0) {
            seed_record(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), *0x1::vector::borrow<u64>(&arg4, v1));
            v1 = v1 + 1;
        };
    }

    public fun set_schedule(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut Distributor, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        assert_version(arg1);
        let v0 = if (arg2 <= arg3) {
            if (arg3 <= arg4) {
                arg4 <= arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906835437064552461);
        arg1.d1 = arg2;
        arg1.d2 = arg3;
        arg1.d3 = arg4;
        arg1.d4 = arg5;
        arg1.r1 = arg6;
        arg1.r2 = arg7;
        arg1.r3 = arg8;
        arg1.schedule_set = true;
        let v1 = ScheduleSet{
            d1 : arg2,
            d2 : arg3,
            d3 : arg4,
            d4 : arg5,
            r1 : arg6,
            r2 : arg7,
            r3 : arg8,
        };
        0x2::event::emit<ScheduleSet>(v1);
    }

    public fun set_time_divisor(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut Distributor, arg2: u64) {
        assert_version(arg1);
        assert!(arg2 > 0, 13906835673288146963);
        arg1.time_divisor = arg2;
    }

    public fun version(arg0: &Distributor) : u64 {
        arg0.version
    }

    public fun withdraw_minter_cap(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<0xe94e04c8fc9665877e8c007aa31cc4104787b7a94248d37a3ccf511295f7d706::gangstabet_nft::GANGSTABET_NFT>, arg1: &mut Distributor) : 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET> {
        assert_version(arg1);
        assert!(0x1::option::is_some<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>(&arg1.minter_cap), 13906835776366313475);
        let v0 = MinterCapWithdrawn{dummy_field: false};
        0x2::event::emit<MinterCapWithdrawn>(v0);
        0x1::option::extract<0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<0xb852c68bbbdedc941ace7e0fc62f83e7d0cedcc17ab977e814fe987733c1c0be::gbet::GBET>>(&mut arg1.minter_cap)
    }

    // decompiled from Move bytecode v7
}

