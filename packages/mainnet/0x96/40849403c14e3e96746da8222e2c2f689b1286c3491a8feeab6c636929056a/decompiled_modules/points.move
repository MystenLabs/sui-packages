module 0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::points {
    struct POINTS has drop {
        dummy_field: bool,
    }

    struct PointsData has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: 0x2::coin::TreasuryCap<POINTS>,
    }

    struct Volume<phantom T0> has store, key {
        id: 0x2::object::UID,
        cycle: u64,
        value: u64,
    }

    struct Config<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        point_capacity: u64,
        interval_ms: u64,
    }

    struct TotalVolume<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        cycle: u64,
        value: u64,
        completion_time_ms: u64,
    }

    struct RateRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        value: 0x2::table::Table<u64, Rate<T0>>,
    }

    struct VolumeRewardRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        rewards: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, u64>>,
    }

    struct Rate<phantom T0> has store {
        points: u64,
        volume: u64,
    }

    public fun mint(arg0: &0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::admin::AdminCap, arg1: &mut PointsData, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POINTS> {
        assert!(arg1.version == 1, 2);
        0x2::coin::mint<POINTS>(&mut arg1.treasury, arg2, arg3)
    }

    public(friend) fun add<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &mut TotalVolume<T0>, arg2: &mut Volume<T0>) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.cycle == arg2.cycle, 3);
        arg1.value = arg1.value + 0x2::coin::value<T0>(arg0);
        arg2.value = arg2.value + 0x2::coin::value<T0>(arg0);
    }

    public(friend) fun add_ref<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::player::Player, arg2: &TotalVolume<T0>, arg3: &mut VolumeRewardRegistry<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 2);
        assert!(arg3.version == 1, 2);
        let v0 = 0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::player::referrer(arg1);
        if (0x1::option::is_some<address>(v0)) {
            mint_and_deposit<T0>(arg3, arg2.cycle, (((0x2::coin::value<T0>(arg0) as u128) * 10 / 100) as u64), *0x1::option::borrow<address>(v0), arg4);
        };
    }

    public fun claim<T0>(arg0: vector<Volume<T0>>, arg1: &RateRegistry<T0>, arg2: &mut PointsData, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POINTS> {
        assert!(arg1.version == 1, 2);
        assert!(arg2.version == 1, 2);
        let v0 = 0;
        0x1::vector::reverse<Volume<T0>>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Volume<T0>>(&arg0)) {
            let v2 = 0x1::vector::pop_back<Volume<T0>>(&mut arg0);
            let v3 = if (!0x2::table::contains<u64, Rate<T0>>(&arg1.value, v2.cycle)) {
                0x2::transfer::transfer<Volume<T0>>(v2, 0x2::tx_context::sender(arg3));
                v0
            } else {
                let Volume {
                    id    : v4,
                    cycle : v5,
                    value : v6,
                } = v2;
                let v7 = 0x2::table::borrow<u64, Rate<T0>>(&arg1.value, v5);
                0x2::object::delete(v4);
                v0 + (((v6 as u128) * (v7.points as u128) / (v7.volume as u128)) as u64)
            };
            v0 = v3;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Volume<T0>>(arg0);
        0x2::coin::mint<POINTS>(&mut arg2.treasury, v0, arg3)
    }

    public fun claim_ref_volume<T0>(arg0: &mut VolumeRewardRegistry<T0>, arg1: &mut 0x2::tx_context::TxContext) : vector<Volume<T0>> {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.rewards, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<Volume<T0>>();
        while (!0x2::linked_table::is_empty<u64, u64>(v0)) {
            let (v2, v3) = 0x2::linked_table::pop_front<u64, u64>(v0);
            let v4 = Volume<T0>{
                id    : 0x2::object::new(arg1),
                cycle : v2,
                value : v3,
            };
            0x1::vector::push_back<Volume<T0>>(&mut v1, v4);
        };
        v1
    }

    public fun create_volume<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Volume<T0> {
        Volume<T0>{
            id    : 0x2::object::new(arg1),
            cycle : arg0,
            value : 0,
        }
    }

    fun init(arg0: POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POINTS>(arg0, 9, b"POINT", b"LemonJet Point", b"LemonJet Point", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POINTS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POINTS>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = PointsData{
            id       : 0x2::object::new(arg1),
            version  : 1,
            treasury : v0,
        };
        0x2::transfer::share_object<PointsData>(v3);
    }

    public fun is_completed<T0>(arg0: &TotalVolume<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.completion_time_ms < 0x2::clock::timestamp_ms(arg1)
    }

    public(friend) fun mint_and_deposit<T0>(arg0: &mut VolumeRewardRegistry<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.rewards, arg3)) {
            let v0 = 0x2::linked_table::new<u64, u64>(arg4);
            0x2::linked_table::push_back<u64, u64>(&mut v0, arg1, arg2);
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.rewards, arg3, v0);
        } else if (!0x2::linked_table::contains<u64, u64>(0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, u64>>(&arg0.rewards, arg3), arg1)) {
            0x2::linked_table::push_back<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.rewards, arg3), arg1, arg2);
        } else {
            let v1 = 0x2::linked_table::borrow_mut<u64, u64>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, u64>>(&mut arg0.rewards, arg3), arg1);
            *v1 = *v1 + arg2;
        };
    }

    public fun next_cycle<T0>(arg0: &0x2::clock::Clock, arg1: &Config<T0>, arg2: &mut TotalVolume<T0>, arg3: &mut RateRegistry<T0>) {
        assert!(arg1.version == 1, 2);
        assert!(arg2.version == 1, 2);
        assert!(arg3.version == 1, 2);
        assert!(is_completed<T0>(arg2, arg0), 4);
        let v0 = Rate<T0>{
            points : arg1.point_capacity,
            volume : arg2.value,
        };
        0x2::table::add<u64, Rate<T0>>(&mut arg3.value, arg2.cycle, v0);
        arg2.cycle = arg2.cycle + 1;
        arg2.value = 0;
        arg2.completion_time_ms = 0x2::clock::timestamp_ms(arg0) + arg1.interval_ms;
    }

    public fun setup<T0>(arg0: &0x9640849403c14e3e96746da8222e2c2f689b1286c3491a8feeab6c636929056a::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Config<T0>{
            id             : 0x2::object::new(arg4),
            version        : 1,
            point_capacity : arg2,
            interval_ms    : arg3,
        };
        0x2::transfer::share_object<Config<T0>>(v0);
        let v1 = TotalVolume<T0>{
            id                 : 0x2::object::new(arg4),
            version            : 1,
            cycle              : 1,
            value              : 0,
            completion_time_ms : 0x2::clock::timestamp_ms(arg1) + arg3,
        };
        0x2::transfer::share_object<TotalVolume<T0>>(v1);
        let v2 = RateRegistry<T0>{
            id      : 0x2::object::new(arg4),
            version : 1,
            value   : 0x2::table::new<u64, Rate<T0>>(arg4),
        };
        0x2::transfer::share_object<RateRegistry<T0>>(v2);
        let v3 = VolumeRewardRegistry<T0>{
            id      : 0x2::object::new(arg4),
            version : 1,
            rewards : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, u64>>(arg4),
        };
        0x2::transfer::share_object<VolumeRewardRegistry<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

