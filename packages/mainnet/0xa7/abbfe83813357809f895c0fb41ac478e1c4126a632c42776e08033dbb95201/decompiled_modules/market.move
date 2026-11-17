module 0xa7abbfe83813357809f895c0fb41ac478e1c4126a632c42776e08033dbb95201::market {
    struct Registry has key {
        id: 0x2::object::UID,
    }

    struct MarketKey has copy, drop, store {
        package: 0x1::string::String,
        version: 0x1::string::String,
        deadline_ms: u64,
    }

    struct Position has drop, store {
        yes: u64,
        yes_time: u128,
        no: u64,
        no_time: u128,
    }

    struct Market has key {
        id: 0x2::object::UID,
        package: 0x1::string::String,
        version: 0x1::string::String,
        deadline_ms: u64,
        created_ms: u64,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        yes: u64,
        yes_time: u128,
        no: u64,
        no_time: u128,
        outcome: u8,
        settled_ms: u64,
        positions: 0x2::table::Table<address, Position>,
        integrity: 0x1::string::String,
    }

    struct Created has copy, drop {
        market: address,
        package: 0x1::string::String,
        version: 0x1::string::String,
        deadline_ms: u64,
        creator: address,
    }

    struct Staked has copy, drop {
        market: address,
        who: address,
        yes: bool,
        amount: u64,
        yes_total: u64,
        no_total: u64,
    }

    struct Settled has copy, drop {
        market: address,
        outcome: u8,
        integrity: 0x1::string::String,
        by: address,
    }

    struct Claimed has copy, drop {
        market: address,
        who: address,
        amount: u64,
    }

    public fun claim(arg0: &mut Market, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.outcome != 0, 13906835368345337873);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, arg1), 13906835372640436243);
        let v0 = 0x2::table::remove<address, Position>(&mut arg0.positions, arg1);
        let v1 = payout(arg0, &v0);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, v1), arg2), arg1);
        };
        let v2 = Claimed{
            market : 0x2::object::uid_to_address(&arg0.id),
            who    : arg1,
            amount : v1,
        };
        0x2::event::emit<Claimed>(v2);
    }

    public fun create(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(valid_package(0x1::string::as_bytes(&arg1)), 13906834870128082945);
        assert!(valid_version(0x1::string::as_bytes(&arg2)), 13906834874423181315);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 >= v0 + 3600000 && arg3 <= v0 + 34560000000, 13906834883013246981);
        let v1 = MarketKey{
            package     : arg1,
            version     : arg2,
            deadline_ms : arg3,
        };
        let v2 = 0x2::derived_object::claim<MarketKey>(&mut arg0.id, v1);
        let v3 = Created{
            market      : 0x2::object::uid_to_address(&v2),
            package     : arg1,
            version     : arg2,
            deadline_ms : arg3,
            creator     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Created>(v3);
        let v4 = Market{
            id          : v2,
            package     : arg1,
            version     : arg2,
            deadline_ms : arg3,
            created_ms  : v0,
            pool        : 0x2::balance::zero<0x2::sui::SUI>(),
            yes         : 0,
            yes_time    : 0,
            no          : 0,
            no_time     : 0,
            outcome     : 0,
            settled_ms  : 0,
            positions   : 0x2::table::new<address, Position>(arg5),
            integrity   : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<Market>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
    }

    fun is_alnum(arg0: u8) : bool {
        is_lower_alnum(arg0) || arg0 >= 65 && arg0 <= 90
    }

    fun is_lower_alnum(arg0: u8) : bool {
        arg0 >= 97 && arg0 <= 122 || arg0 >= 48 && arg0 <= 57
    }

    public fun market_address(arg0: &Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) : address {
        let v0 = MarketKey{
            package     : arg1,
            version     : arg2,
            deadline_ms : arg3,
        };
        0x2::derived_object::derive_address<MarketKey>(0x2::object::uid_to_inner(&arg0.id), v0)
    }

    public fun outcome(arg0: &Market) : u8 {
        arg0.outcome
    }

    fun payout(arg0: &Market, arg1: &Position) : u64 {
        let (v0, v1, v2, v3, v4, v5) = if (arg0.outcome == 1) {
            (arg1.yes, arg1.yes_time, arg0.yes, arg0.yes_time, arg0.no, arg1.no)
        } else {
            (arg1.no, arg1.no_time, arg0.no, arg0.no_time, arg0.yes, arg1.yes)
        };
        if (v2 == 0) {
            return v5
        };
        if (v0 == 0) {
            return 0
        };
        let v6 = (arg0.settled_ms as u256);
        let v7 = (v2 as u256) * v6 - (v3 as u256);
        let v8 = if (v7 > 0) {
            (v4 as u256) * ((v0 as u256) * v6 - (v1 as u256)) / v7
        } else {
            (v4 as u256) * (v0 as u256) / (v2 as u256)
        };
        v0 + (v8 as u64)
    }

    public fun position(arg0: &Market, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, Position>(&arg0.positions, arg1);
        (v0.yes, v0.no)
    }

    public fun settle_no(arg0: &mut Market, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.outcome == 0, 13906835299625205767);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.deadline_ms, 13906835303920697359);
        arg0.outcome = 2;
        arg0.settled_ms = arg0.deadline_ms;
        let v0 = Settled{
            market    : 0x2::object::uid_to_address(&arg0.id),
            outcome   : 2,
            integrity : 0x1::string::utf8(b""),
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Settled>(v0);
    }

    public fun settle_yes(arg0: &mut Market, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.outcome == 0 && v0 < arg0.deadline_ms, 13906835213725859847);
        assert!(valid_integrity(0x1::string::as_bytes(&arg1)), 13906835218021220365);
        let v1 = *0x1::string::as_bytes(&arg0.package);
        0x1::vector::push_back<u8>(&mut v1, 64);
        0x1::vector::append<u8>(&mut v1, *0x1::string::as_bytes(&arg0.version));
        0x1::vector::push_back<u8>(&mut v1, 58);
        0x1::vector::append<u8>(&mut v1, *0x1::string::as_bytes(&arg1));
        let v2 = x"0263a61aed6fbeeda50fcef313adecc7e98731ddcf8738a60270d1b26c9652089a";
        assert!(0x2::ecdsa_r1::secp256r1_verify(&arg2, &v2, &v1, 1), 13906835256675794955);
        arg0.outcome = 1;
        arg0.settled_ms = v0;
        arg0.integrity = arg1;
        let v3 = Settled{
            market    : 0x2::object::uid_to_address(&arg0.id),
            outcome   : 1,
            integrity : arg1,
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Settled>(v3);
    }

    public fun stake(arg0: &mut Market, arg1: bool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.outcome == 0 && v0 < arg0.deadline_ms, 13906835024747298823);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 >= 10000000, 13906835033337364489);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v2 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, Position>(&arg0.positions, v2)) {
            let v3 = Position{
                yes      : 0,
                yes_time : 0,
                no       : 0,
                no_time  : 0,
            };
            0x2::table::add<address, Position>(&mut arg0.positions, v2, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v2);
        let v5 = (v1 as u128) * (v0 as u128);
        if (arg1) {
            v4.yes = v4.yes + v1;
            v4.yes_time = v4.yes_time + v5;
            arg0.yes = arg0.yes + v1;
            arg0.yes_time = arg0.yes_time + v5;
        } else {
            v4.no = v4.no + v1;
            v4.no_time = v4.no_time + v5;
            arg0.no = arg0.no + v1;
            arg0.no_time = arg0.no_time + v5;
        };
        let v6 = Staked{
            market    : 0x2::object::uid_to_address(&arg0.id),
            who       : v2,
            yes       : arg1,
            amount    : v1,
            yes_total : arg0.yes,
            no_total  : arg0.no,
        };
        0x2::event::emit<Staked>(v6);
    }

    public fun totals(arg0: &Market) : (u64, u64) {
        (arg0.yes, arg0.no)
    }

    fun valid_integrity(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0 || v0 > 200) {
            return false
        };
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v3 = 0x1::vector::borrow<u8>(arg0, v1);
            let v4 = if (is_alnum(*v3)) {
                true
            } else if (*v3 == 43) {
                true
            } else if (*v3 == 47) {
                true
            } else if (*v3 == 61) {
                true
            } else {
                *v3 == 45
            };
            if (!v4) {
                v2 = false;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = true;
        v2
    }

    fun valid_package(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0 || v0 > 214) {
            return false
        };
        let v1 = *0x1::vector::borrow<u8>(arg0, 0) == 64;
        let v2 = 0;
        let v3 = if (v1) {
            1
        } else {
            0
        };
        let v4 = v3;
        if (v3 == v0) {
            return false
        };
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u8>(arg0, v4);
            if (v5 == 47) {
                v2 = v2 + 1;
            } else {
                let v6 = if (is_lower_alnum(v5)) {
                    true
                } else if (v5 == 45) {
                    true
                } else if (v5 == 46) {
                    true
                } else if (v5 == 95) {
                    true
                } else {
                    v5 == 126
                };
                if (!v6) {
                    return false
                };
            };
            v4 = v4 + 1;
        };
        v1 && v2 == 1 || v2 == 0
    }

    fun valid_version(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0 || v0 > 64) {
            return false
        };
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v3 = 0x1::vector::borrow<u8>(arg0, v1);
            let v4 = if (is_alnum(*v3)) {
                true
            } else if (*v3 == 46) {
                true
            } else if (*v3 == 45) {
                true
            } else {
                *v3 == 43
            };
            if (!v4) {
                v2 = false;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = true;
        v2
    }

    // decompiled from Move bytecode v7
}

