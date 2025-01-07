module 0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::stats {
    struct StatsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Stats has store {
        fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct StatLimits has store, key {
        id: 0x2::object::UID,
        max_fields: u64,
        max_length: u64,
    }

    fun new() : Stats {
        Stats{fields: 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()}
    }

    public entry fun add_field(arg0: &mut 0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::Hero, arg1: &StatLimits, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        if (!stats_exist(arg0)) {
            attach_fields(arg0, new());
        };
        let v0 = StatsKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<StatsKey, Stats>(0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::hero_uid_mut(arg0), v0);
        assert!(0x2::vec_map::size<0x1::string::String, 0x1::string::String>(&v1.fields) < fields_limit(arg1), 3);
        stats_insert(v1, arg1, arg2, arg3);
    }

    fun attach_fields(arg0: &mut 0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::Hero, arg1: Stats) {
        assert!(!stats_exist(arg0), 0);
        let v0 = StatsKey{dummy_field: false};
        0x2::dynamic_field::add<StatsKey, Stats>(0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::hero_uid_mut(arg0), v0, arg1);
    }

    public entry fun attach_new_with_fields(arg0: &mut 0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::Hero, arg1: &StatLimits, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        attach_fields(arg0, new_with_fields(arg1, arg2, arg3));
    }

    public fun fields_limit(arg0: &StatLimits) : u64 {
        arg0.max_fields
    }

    public entry fun initialize_limit_configuration(arg0: &mut 0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::genesis::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StatLimits{
            id         : 0x2::object::new(arg1),
            max_fields : 10,
            max_length : 32,
        };
        0x2::transfer::public_share_object<StatLimits>(v0);
    }

    public fun length_limit(arg0: &StatLimits) : u64 {
        arg0.max_length
    }

    fun new_with_fields(arg0: &StatLimits, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) : Stats {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 2);
        assert!(v0 <= fields_limit(arg0), 3);
        let v1 = new();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = &mut v1;
            stats_insert(v3, arg0, *0x1::vector::borrow<0x1::string::String>(&arg1, v2), *0x1::vector::borrow<0x1::string::String>(&arg2, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun stat_fields(arg0: &0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::Hero) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(stats_exist(arg0), 1);
        let v0 = StatsKey{dummy_field: false};
        0x2::dynamic_field::borrow<StatsKey, Stats>(0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::hero_uid(arg0), v0).fields
    }

    fun stats_exist(arg0: &0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::Hero) : bool {
        let v0 = StatsKey{dummy_field: false};
        0x2::dynamic_field::exists_<StatsKey>(0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::hero_uid(arg0), v0)
    }

    fun stats_insert(arg0: &mut Stats, arg1: &StatLimits, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0x1::string::length(&arg2) <= length_limit(arg1), 4);
        assert!(0x1::string::length(&arg3) <= length_limit(arg1), 4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.fields, arg2, arg3);
    }

    public entry fun update_fields_limit(arg0: &mut 0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::genesis::AdminCap, arg1: &mut StatLimits, arg2: u64) {
        arg1.max_fields = arg2;
    }

    public entry fun update_length_limit(arg0: &mut 0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::genesis::AdminCap, arg1: &mut StatLimits, arg2: u64) {
        arg1.max_length = arg2;
    }

    public entry fun upsert_field(arg0: &mut 0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::Hero, arg1: &StatLimits, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        if (stats_exist(arg0)) {
            let v0 = StatsKey{dummy_field: false};
            let v1 = 0x2::dynamic_field::borrow_mut<StatsKey, Stats>(0xf09c99aa87a706c4f010c8c6b86d0249ccf670a138dcbcc7af9f4da8573019fe::arcade_champion::hero_uid_mut(arg0), v0);
            if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1.fields, &arg2)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1.fields, &arg2);
            };
            assert!(0x2::vec_map::size<0x1::string::String, 0x1::string::String>(&v1.fields) < fields_limit(arg1), 3);
            stats_insert(v1, arg1, arg2, arg3);
        } else {
            add_field(arg0, arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

