module 0xa42189fbfc43325103aa328e5534bec8b38aad85874c7afd4079f0d8c06270fb::kin {
    struct AdminCap has key {
        id: 0x2::object::UID,
        treasury: address,
        registry: 0x1::option::Option<0x2::object::ID>,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        next_serial: u64,
        last_day: 0x2::table::Table<address, u32>,
        treasury: address,
        claim_raw: u64,
        mint_cost_raw: u64,
        coin_type: 0x1::ascii::String,
    }

    struct KinPage has store, key {
        id: 0x2::object::UID,
        serial: u64,
        kin: u16,
        seal: u8,
        tone: u8,
        moon: u8,
        moon_day: u8,
        year_start: u32,
        day_id: u32,
        minter: address,
    }

    struct KinMinted has copy, drop {
        page_id: 0x2::object::ID,
        serial: u64,
        kin: u16,
        minter: address,
        day_id: u32,
        paid: u64,
    }

    struct CostsSet has copy, drop {
        claim_raw: u64,
        mint_cost_raw: u64,
        price_raw: u64,
    }

    public fun kin(arg0: &KinPage) : u16 {
        arg0.kin
    }

    public fun cap_treasury(arg0: &AdminCap) : address {
        arg0.treasury
    }

    public fun civil_from_days(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 + 719468;
        let v1 = v0 / 146097;
        let v2 = v0 - v1 * 146097;
        let v3 = (v2 - v2 / 1460 + v2 / 36524 - v2 / 146096) / 365;
        let v4 = v2 - 365 * v3 + v3 / 4 - v3 / 100;
        let v5 = (5 * v4 + 2) / 153;
        let v6 = if (v5 < 10) {
            v5 + 3
        } else {
            v5 - 9
        };
        let v7 = if (v6 <= 2) {
            1
        } else {
            0
        };
        (v3 + v1 * 400 + v7, v6, v4 - (153 * v5 + 2) / 5 + 1)
    }

    public fun claim_raw(arg0: &Registry) : u64 {
        arg0.claim_raw
    }

    public fun coin_type(arg0: &Registry) : 0x1::ascii::String {
        arg0.coin_type
    }

    public fun create_registry(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        create_registry_impl(arg0, arg1, arg2, 0x1::ascii::string(b"46d2ff5170c0d2d82398410123b001274eb3abfa80679f892c7a1ec29864d1d6::soostone::SOOSTONE"), arg3);
    }

    fun create_registry_impl(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.registry), 4);
        assert!(price_of(arg1, arg2) > 0, 3);
        let v0 = Registry{
            id            : 0x2::object::new(arg4),
            next_serial   : 1,
            last_day      : 0x2::table::new<address, u32>(arg4),
            treasury      : arg0.treasury,
            claim_raw     : arg1,
            mint_cost_raw : arg2,
            coin_type     : arg3,
        };
        arg0.registry = 0x1::option::some<0x2::object::ID>(0x2::object::id<Registry>(&v0));
        let v1 = CostsSet{
            claim_raw     : arg1,
            mint_cost_raw : arg2,
            price_raw     : price_of(arg1, arg2),
        };
        0x2::event::emit<CostsSet>(v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun day_id(arg0: &KinPage) : u32 {
        arg0.day_id
    }

    public fun day_id_at(arg0: u64) : u32 {
        let (v0, v1, v2) = dreamspell_date(arg0);
        ymd_id(v0, v1, v2)
    }

    public fun days_from_civil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 <= 2) {
            arg0 - 1
        } else {
            arg0
        };
        let v1 = v0 / 400;
        let v2 = v0 - v1 * 400;
        let v3 = if (arg1 > 2) {
            arg1 - 3
        } else {
            arg1 + 9
        };
        v1 * 146097 + v2 * 365 + v2 / 4 - v2 / 100 + (153 * v3 + 2) / 5 + arg2 - 1 - 719468
    }

    public fun dreamspell_date(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 - 6 * 3600000;
        civil_from_days((v0 - la_offset_hours(v0) * 3600000) / 86400000)
    }

    fun ds_days(arg0: u64, arg1: u64) : u64 {
        arg1 - arg0 - leap_days_between(arg0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id       : 0x2::object::new(arg0),
            treasury : 0x2::tx_context::sender(arg0),
            registry : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_leap(arg0: u64) : bool {
        arg0 % 4 == 0 && arg0 % 100 != 0 || arg0 % 400 == 0
    }

    public fun kin_of(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = days_from_civil(2013, 7, 26);
        let v1 = days_from_civil(arg0, arg1, arg2);
        let v2 = v1;
        if (arg1 == 2 && arg2 == 29) {
            v2 = v1 - 1;
        };
        assert!(v2 >= v0, 6);
        (164 - 1 + ds_days(v0, v2)) % 260 + 1
    }

    public fun la_offset_hours(arg0: u64) : u64 {
        let (v0, _, _) = civil_from_days(arg0 / 86400000);
        if (arg0 >= nth_sunday(v0, 3, 2) * 86400000 + 10 * 3600000 && arg0 < nth_sunday(v0, 11, 1) * 86400000 + 9 * 3600000) {
            7
        } else {
            8
        }
    }

    public fun last_day_of(arg0: &Registry, arg1: address) : u32 {
        if (0x2::table::contains<address, u32>(&arg0.last_day, arg1)) {
            *0x2::table::borrow<address, u32>(&arg0.last_day, arg1)
        } else {
            0
        }
    }

    fun leap_days_between(arg0: u64, arg1: u64) : u64 {
        let (v0, _, _) = civil_from_days(arg0);
        let (v3, _, _) = civil_from_days(arg1);
        let v6 = 0;
        let v7 = v0;
        while (v7 <= v3) {
            if (is_leap(v7)) {
                let v8 = days_from_civil(v7, 2, 29);
                if (v8 > arg0 && v8 <= arg1) {
                    v6 = v6 + 1;
                };
            };
            v7 = v7 + 1;
        };
        v6
    }

    public fun mint<T0>(arg0: &mut Registry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()) == arg0.coin_type, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 == price(arg0), 1);
        let (v1, v2, v3) = dreamspell_date(0x2::clock::timestamp_ms(arg2));
        let v4 = ymd_id(v1, v2, v3);
        let v5 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u32>(&arg0.last_day, v5)) {
            let v6 = 0x2::table::borrow_mut<address, u32>(&mut arg0.last_day, v5);
            assert!(*v6 != v4, 0);
            *v6 = v4;
        } else {
            0x2::table::add<address, u32>(&mut arg0.last_day, v5, v4);
        };
        let v7 = kin_of(v1, v2, v3);
        let (v8, v9, v10) = moon_of(v1, v2, v3);
        let v11 = arg0.next_serial;
        arg0.next_serial = v11 + 1;
        let v12 = KinPage{
            id         : 0x2::object::new(arg3),
            serial     : v11,
            kin        : (v7 as u16),
            seal       : (((v7 - 1) % 20 + 1) as u8),
            tone       : (((v7 - 1) % 13 + 1) as u8),
            moon       : v8,
            moon_day   : v9,
            year_start : v10,
            day_id     : v4,
            minter     : v5,
        };
        let v13 = KinMinted{
            page_id : 0x2::object::id<KinPage>(&v12),
            serial  : v11,
            kin     : (v7 as u16),
            minter  : v5,
            day_id  : v4,
            paid    : v0,
        };
        0x2::event::emit<KinMinted>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury);
        0x2::transfer::transfer<KinPage>(v12, v5);
    }

    public fun mint_cost_raw(arg0: &Registry) : u64 {
        arg0.mint_cost_raw
    }

    public fun minter(arg0: &KinPage) : address {
        arg0.minter
    }

    public fun moon(arg0: &KinPage) : u8 {
        arg0.moon
    }

    public fun moon_day(arg0: &KinPage) : u8 {
        arg0.moon_day
    }

    public fun moon_of(arg0: u64, arg1: u64, arg2: u64) : (u8, u8, u32) {
        let v0 = if (arg1 > 7 || arg1 == 7 && arg2 >= 26) {
            arg0
        } else {
            arg0 - 1
        };
        if (arg1 == 2 && arg2 == 29) {
            return (0, 0, ymd_id(v0, 7, 26))
        };
        let v1 = ds_days(days_from_civil(v0, 7, 26), days_from_civil(arg0, arg1, arg2));
        if (v1 == 364) {
            return (0, 0, ymd_id(v0, 7, 26))
        };
        (((v1 / 28 + 1) as u8), ((v1 % 28 + 1) as u8), ymd_id(v0, 7, 26))
    }

    public fun next_serial(arg0: &Registry) : u64 {
        arg0.next_serial
    }

    fun nth_sunday(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = days_from_civil(arg0, arg1, 1);
        v0 + (7 - weekday(v0)) % 7 + (arg2 - 1) * 7
    }

    public fun price(arg0: &Registry) : u64 {
        price_of(arg0.claim_raw, arg0.mint_cost_raw)
    }

    public fun price_of(arg0: u64, arg1: u64) : u64 {
        (((((arg0 as u128) + (arg1 as u128)) * (1618 as u128) + ((1000 / 2) as u128)) / (1000 as u128)) as u64)
    }

    public fun seal(arg0: &KinPage) : u8 {
        arg0.seal
    }

    public fun serial(arg0: &KinPage) : u64 {
        arg0.serial
    }

    public fun set_costs(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: u64) {
        assert!(arg0.registry == 0x1::option::some<0x2::object::ID>(0x2::object::id<Registry>(arg1)), 5);
        assert!(price_of(arg2, arg3) > 0, 3);
        arg1.claim_raw = arg2;
        arg1.mint_cost_raw = arg3;
        let v0 = CostsSet{
            claim_raw     : arg2,
            mint_cost_raw : arg3,
            price_raw     : price_of(arg2, arg3),
        };
        0x2::event::emit<CostsSet>(v0);
    }

    public fun tone(arg0: &KinPage) : u8 {
        arg0.tone
    }

    public fun treasury(arg0: &Registry) : address {
        arg0.treasury
    }

    fun weekday(arg0: u64) : u64 {
        (arg0 + 4) % 7
    }

    public fun year_start(arg0: &KinPage) : u32 {
        arg0.year_start
    }

    fun ymd_id(arg0: u64, arg1: u64, arg2: u64) : u32 {
        ((arg0 * 10000 + arg1 * 100 + arg2) as u32)
    }

    // decompiled from Move bytecode v7
}

