module 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb {
    struct VSDB has drop {
        dummy_field: bool,
    }

    struct VSDBKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct Vsdb has store, key {
        id: 0x2::object::UID,
        img_url: 0x1::ascii::String,
        level: u8,
        experience: u64,
        scarcity: u8,
        name: 0x1::ascii::String,
        balance: 0x2::balance::Balance<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>,
        end: u64,
        player_epoch: u64,
        player_point_history: 0x2::table_vec::TableVec<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>,
        modules: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>,
    }

    struct VSDBCap has store, key {
        id: 0x2::object::UID,
    }

    struct VSDBRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        modules: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>,
        minted_vsdb: u64,
        locked_total: u64,
        epoch: u64,
        point_history: 0x2::table_vec::TableVec<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>,
        slope_changes: 0x2::table::Table<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>,
        arts: 0x2::table::Table<u8, vector<vector<0x1::ascii::String>>>,
    }

    fun new(arg0: 0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>, arg1: u64, arg2: &0x2::table::Table<u8, vector<vector<0x1::ascii::String>>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Vsdb {
        let v0 = 0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0);
        let v1 = unix_timestamp(arg3);
        let v2 = 0x2::object::new(arg4);
        let v3 = pick_scarcity(0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0), (arg1 - round_down_week(v1)) / 604800, &v2);
        Vsdb{
            id                   : v2,
            img_url              : img_url(&v2, 0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0), 0, v3, arg2),
            level                : 0,
            experience           : 0,
            scarcity             : (v3 as u8),
            name                 : pick_name(v3),
            balance              : 0x2::coin::into_balance<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(arg0),
            end                  : arg1,
            player_epoch         : 0,
            player_point_history : 0x2::table_vec::singleton<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::new(calculate_bias(v0, arg1, v1), calculate_slope(v0), v1), arg4),
            modules              : 0x2::vec_map::empty<0x1::type_name::TypeName, bool>(),
        }
    }

    public fun earn_xp<T0: drop>(arg0: T0, arg1: &mut Vsdb, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg1.modules, &v0), 106);
        arg1.experience = arg1.experience + arg2;
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event::earn_xp(0x2::object::id<Vsdb>(arg1), arg2);
    }

    fun withdraw(arg0: &mut Vsdb, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB> {
        arg0.end = 0;
        0x2::coin::from_balance<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(0x2::balance::withdraw_all<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance), arg1)
    }

    public entry fun add_art(arg0: &VSDBCap, arg1: &mut VSDBRegistry, arg2: u8, arg3: vector<vector<u8>>) {
        assert!(!0x2::table::contains<u8, vector<vector<0x1::ascii::String>>>(&arg1.arts, arg2), 110);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        let v1 = 0;
        assert!(v0 == 30, 112);
        let v2 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        while (v1 < v0) {
            let v3 = 0x1::vector::empty<0x1::ascii::String>();
            let v4 = 0;
            while (v4 < 6) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut arg3)));
                v4 = v4 + 1;
            };
            0x1::vector::reverse<0x1::ascii::String>(&mut v3);
            0x1::vector::push_back<vector<0x1::ascii::String>>(&mut v2, v3);
            v1 = v1 + 6;
        };
        0x1::vector::reverse<vector<0x1::ascii::String>>(&mut v2);
        0x2::table::add<u8, vector<vector<0x1::ascii::String>>>(&mut arg1.arts, arg2, v2);
    }

    public fun calculate_bias(arg0: u64, arg1: u64, arg2: u64) : 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128 {
        let v0 = calculate_slope(arg0);
        let v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::from((arg1 as u128) - (arg2 as u128));
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::mul(&v0, &v1)
    }

    public fun calculate_slope(arg0: u64) : 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128 {
        let v0 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::from((arg0 as u128));
        let v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::from((14515200 as u128));
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::div(&v0, &v1)
    }

    fun checkpoint_(arg0: bool, arg1: &mut VSDBRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = unix_timestamp(arg6);
        let v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
        let v2 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
        let v3 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
        let v4 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
        let v5 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
        let v6 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
        let v7 = arg1.epoch;
        let v8 = v7;
        if (arg0) {
            if (arg3 > v0 && arg2 > 0) {
                v3 = calculate_slope(arg2);
                v4 = calculate_bias(arg2, arg3, v0);
            };
            if (arg5 > v0 && arg4 > 0) {
                v5 = calculate_slope(arg4);
                v6 = calculate_bias(arg4, arg5, v0);
            };
            if (0x2::table::contains<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg1.slope_changes, arg3)) {
                v1 = *0x2::table::borrow<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg1.slope_changes, arg3);
            };
            if (arg5 != 0) {
                if (arg5 == arg3) {
                    v2 = v1;
                } else if (0x2::table::contains<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg1.slope_changes, arg5)) {
                    v2 = *0x2::table::borrow<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg1.slope_changes, arg5);
                };
            };
        };
        let v9 = if (v7 > 0) {
            *0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg1.point_history, v7)
        } else {
            0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::new(0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero(), 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero(), v0)
        };
        let v10 = v9;
        let v11 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::bias(&v10);
        let v12 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::slope(&v10);
        let v13 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::ts(&v10);
        let v14 = v13;
        let v15 = round_down_week(v13);
        let v16 = 0;
        while (v16 < 255) {
            let v17 = v15 + 604800;
            v15 = v17;
            let v18 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
            if (v17 > v0) {
                v15 = v0;
            } else if (0x2::table::contains<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg1.slope_changes, v17)) {
                v18 = *0x2::table::borrow<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg1.slope_changes, v17);
            };
            let v19 = &v11;
            let v20 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::from((v15 as u128));
            let v21 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::from((v13 as u128));
            let v22 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(&v20, &v21);
            let v23 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::mul(&v12, &v22);
            v11 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(v19, &v23);
            let v24 = &v12;
            v12 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::add(v24, &v18);
            if (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::is_neg(&v11)) {
                v11 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
            };
            if (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::is_neg(&v12)) {
                v12 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
            };
            v14 = v15;
            v8 = v8 + 1;
            if (v15 == v0) {
                break
            };
            0x2::table_vec::push_back<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&mut arg1.point_history, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::new(v11, v12, v15));
            v16 = v16 + 1;
        };
        if (arg0) {
            let v25 = &v12;
            let v26 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(&v5, &v3);
            v12 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::add(v25, &v26);
            let v27 = &v11;
            let v28 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(&v6, &v4);
            v11 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::add(v27, &v28);
            if (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::is_neg(&v12)) {
                v12 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
            };
            if (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::is_neg(&v11)) {
                v11 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
            };
        };
        if (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::ts(0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg1.point_history, arg1.epoch)) != v14 || !0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::is_zero(&v12) || !0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::is_zero(&v11)) {
            arg1.epoch = v8;
            0x2::table_vec::push_back<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&mut arg1.point_history, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::new(v11, v12, v14));
        };
        if (arg0) {
            if (arg3 > v0) {
                let v29 = &v1;
                v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::add(v29, &v3);
                if (arg5 == arg3) {
                    let v30 = &v1;
                    v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(v30, &v5);
                };
                if (0x2::table::contains<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg1.slope_changes, arg3)) {
                    *0x2::table::borrow_mut<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&mut arg1.slope_changes, arg3) = v1;
                } else {
                    0x2::table::add<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&mut arg1.slope_changes, arg3, v1);
                };
            };
            if (arg5 > v0) {
                if (arg5 > arg3) {
                    let v31 = &v2;
                    v2 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(v31, &v5);
                    if (0x2::table::contains<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg1.slope_changes, arg5)) {
                        *0x2::table::borrow_mut<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&mut arg1.slope_changes, arg5) = v2;
                    } else {
                        0x2::table::add<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&mut arg1.slope_changes, arg5, v2);
                    };
                };
            };
        };
    }

    fun destroy(arg0: Vsdb) {
        let Vsdb {
            id                   : v0,
            img_url              : _,
            level                : _,
            experience           : _,
            scarcity             : _,
            name                 : _,
            balance              : v6,
            end                  : _,
            player_epoch         : _,
            player_point_history : v9,
            modules              : v10,
        } = arg0;
        let (_, v12) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, bool>(v10);
        let v13 = v12;
        let v14 = true;
        assert!(!0x1::vector::contains<bool>(&v13, &v14), 107);
        0x2::table_vec::drop<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(v9);
        0x2::balance::destroy_zero<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(v6);
        0x2::object::delete(v0);
    }

    public fun df_add<T0: drop, T1: drop + store>(arg0: T0, arg1: &VSDBRegistry, arg2: &mut Vsdb, arg3: T1) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg1.modules, &v0), 106);
        0x2::vec_map::insert<0x1::type_name::TypeName, bool>(&mut arg2.modules, v0, *0x2::vec_map::get<0x1::type_name::TypeName, bool>(&arg1.modules, &v0));
        let v1 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<VSDBKey<T0>, T1>(&mut arg2.id, v1, arg3);
    }

    public fun df_borrow<T0: drop, T1: drop + store>(arg0: &Vsdb, arg1: T0) : &T1 {
        let v0 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<VSDBKey<T0>, T1>(&arg0.id, v0)
    }

    public fun df_borrow_mut<T0: drop, T1: drop + store>(arg0: &mut Vsdb, arg1: T0) : &mut T1 {
        let v0 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<VSDBKey<T0>, T1>(&mut arg0.id, v0)
    }

    public fun df_exists<T0: drop>(arg0: &Vsdb, arg1: T0) : bool {
        let v0 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<VSDBKey<T0>>(&arg0.id, v0)
    }

    public fun df_exists_with_type<T0: drop, T1: drop + store>(arg0: &Vsdb, arg1: T0) : bool {
        let v0 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<VSDBKey<T0>, T1>(&arg0.id, v0)
    }

    public fun df_remove<T0: drop, T1: drop + store>(arg0: T0, arg1: &mut Vsdb) : T1 {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, bool>(&mut arg1.modules, &v0);
        let v3 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<VSDBKey<T0>, T1>(&mut arg1.id, v3)
    }

    public fun df_remove_if_exists<T0: drop, T1: drop + store>(arg0: &mut Vsdb, arg1: T0) : 0x1::option::Option<T1> {
        let v0 = VSDBKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::remove_if_exists<VSDBKey<T0>, T1>(&mut arg0.id, v0);
        if (0x1::option::is_some<T1>(&v1)) {
            let v2 = 0x1::type_name::get<T0>();
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, bool>(&mut arg0.modules, &v2);
        };
        v1
    }

    public fun dof_add<T0: drop, T1: store + key>(arg0: T0, arg1: &VSDBRegistry, arg2: &mut Vsdb, arg3: T1) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg1.modules, &v0), 106);
        0x2::vec_map::insert<0x1::type_name::TypeName, bool>(&mut arg2.modules, v0, *0x2::vec_map::get<0x1::type_name::TypeName, bool>(&arg1.modules, &v0));
        let v1 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<VSDBKey<T0>, T1>(&mut arg2.id, v1, arg3);
    }

    public fun dof_borrow<T0: drop, T1: store + key>(arg0: &Vsdb, arg1: T0) : &T1 {
        let v0 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<VSDBKey<T0>, T1>(&arg0.id, v0)
    }

    public fun dof_borrow_mut<T0: drop, T1: store + key>(arg0: &mut Vsdb, arg1: T0) : &mut T1 {
        let v0 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<VSDBKey<T0>, T1>(&mut arg0.id, v0)
    }

    public fun dof_exists<T0: drop>(arg0: &Vsdb, arg1: T0) : bool {
        let v0 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::exists_<VSDBKey<T0>>(&arg0.id, v0)
    }

    public fun dof_exists_with_type<T0: drop, T1: store + key>(arg0: &Vsdb, arg1: T0) : bool {
        let v0 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<VSDBKey<T0>, T1>(&arg0.id, v0)
    }

    public fun dof_remove<T0: drop, T1: store + key>(arg0: &mut Vsdb, arg1: T0) : T1 {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, bool>(&mut arg0.modules, &v0);
        let v3 = VSDBKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::remove<VSDBKey<T0>, T1>(&mut arg0.id, v3)
    }

    public entry fun edit_art(arg0: &VSDBCap, arg1: &mut VSDBRegistry, arg2: u8, arg3: vector<vector<u8>>) {
        assert!(0x2::table::contains<u8, vector<vector<0x1::ascii::String>>>(&arg1.arts, arg2), 111);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        let v1 = 0;
        assert!(v0 == 30, 112);
        let v2 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        while (v1 < v0) {
            let v3 = 0x1::vector::empty<0x1::ascii::String>();
            let v4 = 0;
            while (v4 < 6) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut arg3)));
                v4 = v4 + 1;
            };
            0x1::vector::reverse<0x1::ascii::String>(&mut v3);
            0x1::vector::push_back<vector<0x1::ascii::String>>(&mut v2, v3);
            v1 = v1 + 6;
        };
        0x1::vector::reverse<vector<0x1::ascii::String>>(&mut v2);
        *0x2::table::borrow_mut<u8, vector<vector<0x1::ascii::String>>>(&mut arg1.arts, arg2) = v2;
    }

    public fun epoch(arg0: &VSDBRegistry) : u64 {
        arg0.epoch
    }

    public fun experience(arg0: &Vsdb) : u64 {
        arg0.experience
    }

    fun extend(arg0: &mut Vsdb, arg1: 0x1::option::Option<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>, arg2: u64, arg3: &0x2::clock::Clock) {
        if (0x1::option::is_some<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(&arg1)) {
            0x2::coin::put<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance, 0x1::option::extract<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(&mut arg1));
        };
        if (arg2 != 0) {
            arg0.end = arg2;
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(arg1);
        update_player_point_(arg0, arg3);
    }

    public fun get_bias(arg0: &Vsdb, arg1: u64) : 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128 {
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::bias(0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg0.player_point_history, arg1))
    }

    public fun get_global_point_history(arg0: &VSDBRegistry, arg1: u64) : &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point {
        0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg0.point_history, arg1)
    }

    public fun get_latest_bias(arg0: &Vsdb) : 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128 {
        get_bias(arg0, arg0.player_epoch)
    }

    public fun get_latest_slope(arg0: &Vsdb) : 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128 {
        get_slope(arg0, arg0.player_epoch)
    }

    public fun get_latest_ts(arg0: &Vsdb) : u64 {
        get_ts(arg0, arg0.player_epoch)
    }

    public fun get_slope(arg0: &Vsdb, arg1: u64) : 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128 {
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::slope(0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg0.player_point_history, arg1))
    }

    public fun get_ts(arg0: &Vsdb, arg1: u64) : u64 {
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::ts(0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg0.player_point_history, arg1))
    }

    public fun global_checkpoint(arg0: &mut VSDBRegistry, arg1: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 1);
        checkpoint_(false, arg0, 0, 0, 0, 0, arg1);
    }

    public fun img_url(arg0: &0x2::object::UID, arg1: u64, arg2: u8, arg3: u64, arg4: &0x2::table::Table<u8, vector<vector<0x1::ascii::String>>>) : 0x1::ascii::String {
        let v0 = 0x1::vector::borrow<vector<0x1::ascii::String>>(0x2::table::borrow<u8, vector<vector<0x1::ascii::String>>>(arg4, 0), arg3);
        while (arg2 > 0) {
            if (0x2::table::contains<u8, vector<vector<0x1::ascii::String>>>(arg4, arg2)) {
                v0 = 0x1::vector::borrow<vector<0x1::ascii::String>>(0x2::table::borrow<u8, vector<vector<0x1::ascii::String>>>(arg4, arg2), arg3);
            };
            arg2 = arg2 - 1;
        };
        *0x1::vector::borrow<0x1::ascii::String>(v0, pick_color(arg1, arg0))
    }

    public entry fun increase_unlock_amount(arg0: &mut VSDBRegistry, arg1: &mut Vsdb, arg2: 0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 1);
        let v0 = locked_balance(arg1);
        let v1 = locked_end(arg1);
        let v2 = 0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg2);
        assert!(v1 > unix_timestamp(arg3), 102);
        assert!(v0 > 0, 105);
        assert!(v2 > 0, 104);
        extend(arg1, 0x1::option::some<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(arg2), 0, arg3);
        arg0.locked_total = arg0.locked_total + v2;
        checkpoint_(true, arg0, v0, v1, locked_balance(arg1), v1, arg3);
        arg1.img_url = img_url(&arg1.id, locked_balance(arg1), arg1.level, (arg1.scarcity as u64), &arg0.arts);
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event::deposit(0x2::object::id<Vsdb>(arg1), locked_balance(arg1), v1);
    }

    public entry fun increase_unlock_time(arg0: &mut VSDBRegistry, arg1: &mut Vsdb, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 1);
        let v0 = unix_timestamp(arg3);
        let v1 = locked_balance(arg1);
        let v2 = locked_end(arg1);
        let v3 = round_down_week(v0 + arg2);
        assert!(v2 > v0, 102);
        assert!(v1 > 0, 105);
        assert!(v3 > v2, 101);
        assert!(v3 > v0 && v3 <= v0 + 14515200, 101);
        extend(arg1, 0x1::option::none<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(), v3, arg3);
        checkpoint_(true, arg0, v1, v2, locked_balance(arg1), locked_end(arg1), arg3);
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event::deposit(0x2::object::id<Vsdb>(arg1), locked_balance(arg1), v3);
    }

    fun init(arg0: VSDB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VSDB>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suidoubashi.io/vest"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"VSDB NFT is used for governance. Any SDB holders can lock their tokens for up to 24 weeks to receive NFTs. NFT holders gain access to the ecosystem and enjoy additional benefits for becoming SuiDouBashi members !"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suidoubashi.io"));
        let v5 = 0x2::display::new_with_fields<Vsdb>(&v0, v1, v3, arg1);
        0x2::display::update_version<Vsdb>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Vsdb>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = VSDBCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VSDBCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = VSDBRegistry{
            id            : 0x2::object::new(arg1),
            version       : 1,
            modules       : 0x2::vec_map::empty<0x1::type_name::TypeName, bool>(),
            minted_vsdb   : 0,
            locked_total  : 0,
            epoch         : 0,
            point_history : 0x2::table_vec::singleton<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::new(0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero(), 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero(), 0x2::tx_context::epoch_timestamp_ms(arg1) / 1000), arg1),
            slope_changes : 0x2::table::new<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(arg1),
            arts          : 0x2::table::new<u8, vector<vector<0x1::ascii::String>>>(arg1),
        };
        0x2::transfer::share_object<VSDBRegistry>(v7);
    }

    public fun is_expired(arg0: &Vsdb, arg1: &0x2::clock::Clock) : bool {
        unix_timestamp(arg1) > arg0.end
    }

    public fun level(arg0: &Vsdb) : u8 {
        arg0.level
    }

    public entry fun lock(arg0: &mut VSDBRegistry, arg1: 0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        lock_for(arg0, arg1, arg2, v0, arg3, arg4);
    }

    public entry fun lock_for(arg0: &mut VSDBRegistry, arg1: 0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = unix_timestamp(arg4);
        let v1 = round_down_week(arg2 + v0);
        assert!(0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg1) > 0, 104);
        assert!(v1 > v0 && v1 <= v0 + 14515200, 101);
        let v2 = 0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg1);
        let v3 = new(arg1, v1, &arg0.arts, arg4, arg5);
        arg0.minted_vsdb = arg0.minted_vsdb + 1;
        arg0.locked_total = arg0.locked_total + v2;
        checkpoint_(true, arg0, 0, 0, locked_balance(&v3), locked_end(&v3), arg4);
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event::deposit(0x2::object::id<Vsdb>(&v3), v2, v1);
        0x2::transfer::transfer<Vsdb>(v3, arg3);
    }

    public fun locked_balance(arg0: &Vsdb) : u64 {
        0x2::balance::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.balance)
    }

    public fun locked_end(arg0: &Vsdb) : u64 {
        arg0.end
    }

    public fun locked_total(arg0: &VSDBRegistry) : u64 {
        arg0.locked_total
    }

    public fun max_time() : u64 {
        14515200
    }

    public entry fun merge(arg0: &mut VSDBRegistry, arg1: &mut Vsdb, arg2: Vsdb, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let (_, v1) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, bool>(arg2.modules);
        let v2 = v1;
        let v3 = true;
        assert!(!0x1::vector::contains<bool>(&v2, &v3), 107);
        let v4 = locked_balance(arg1);
        let v5 = locked_end(arg1);
        let v6 = level(&arg2);
        let v7 = locked_balance(&arg2);
        let v8 = locked_end(&arg2);
        let v9 = level(&arg2);
        let v10 = unix_timestamp(arg3);
        assert!(v8 >= v10 && v5 >= v10, 102);
        assert!(v7 > 0 && v4 > 0, 105);
        let (v11, v12) = if (v6 > v9) {
            (v6, arg1.experience)
        } else if (v6 == v9) {
            let v13 = if (arg1.experience > arg2.experience) {
                arg1.experience
            } else {
                arg2.experience
            };
            (v6, v13)
        } else {
            (v9, arg2.experience)
        };
        arg1.level = v11;
        arg1.experience = v12;
        let v14 = if (arg1.scarcity > arg2.scarcity) {
            arg1.scarcity
        } else {
            arg2.scarcity
        };
        arg1.scarcity = v14;
        arg1.img_url = img_url(&arg1.id, v4 + v7, arg1.level, (v14 as u64), &arg0.arts);
        let v15 = &mut arg2;
        checkpoint_(true, arg0, v7, v8, locked_balance(&arg2), locked_end(&arg2), arg3);
        destroy(arg2);
        let v16 = if (v5 > v8) {
            v5
        } else {
            v8
        };
        arg0.minted_vsdb = arg0.minted_vsdb - 1;
        extend(arg1, 0x1::option::some<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(withdraw(v15, arg4)), v16, arg3);
        checkpoint_(true, arg0, v4, v5, locked_balance(arg1), locked_end(arg1), arg3);
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event::deposit(0x2::object::id<Vsdb>(arg1), locked_balance(arg1), v16);
    }

    public fun minted_vsdb(arg0: &VSDBRegistry) : u64 {
        arg0.minted_vsdb
    }

    public fun module_exists<T0>(arg0: &Vsdb) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.modules, &v0)
    }

    fun pick_color(arg0: u64, arg1: &0x2::object::UID) : u64 {
        if (arg0 < 2500000000000) {
            0
        } else if (arg0 < 5000000000000) {
            let v1 = 0x2::object::uid_to_bytes(arg1);
            let v2 = safe_selection(3, &v1);
            if (v2 < 1) {
                1
            } else if (v2 < 2) {
                2
            } else {
                3
            }
        } else if (arg0 < 10000000000000) {
            4
        } else {
            5
        }
    }

    fun pick_name(arg0: u64) : 0x1::ascii::String {
        if (arg0 == 0) {
            return 0x1::ascii::string(b"goldfish")
        };
        if (arg0 == 1) {
            return 0x1::ascii::string(b"ranchu")
        };
        if (arg0 == 2) {
            return 0x1::ascii::string(b"pearlscale")
        };
        if (arg0 == 3) {
            return 0x1::ascii::string(b"pop-eyed")
        };
        0x1::ascii::string(b"ryukin")
    }

    fun pick_scarcity(arg0: u64, arg1: u64, arg2: &0x2::object::UID) : u64 {
        assert!(arg1 <= 24, 101);
        let v0 = 0x2::object::uid_to_bytes(arg2);
        let v1 = safe_selection(100, &v0);
        if (arg1 == 24 && arg0 > 2400000000000) {
            if (v1 < 50) {
                0
            } else if (v1 < 75) {
                1
            } else if (v1 < 95) {
                2
            } else if (v1 < 98) {
                3
            } else {
                4
            }
        } else if (arg1 > 18 && arg0 > 1800000000000) {
            if (v1 < 60) {
                0
            } else if (v1 < 80) {
                1
            } else if (v1 < 95) {
                2
            } else if (v1 < 99) {
                3
            } else {
                4
            }
        } else if (arg1 > 12 && arg0 > 1200000000000) {
            if (v1 < 70) {
                0
            } else if (v1 < 90) {
                1
            } else if (v1 < 98) {
                2
            } else {
                3
            }
        } else if (v1 < 80) {
            0
        } else {
            1
        }
    }

    public fun player_epoch(arg0: &Vsdb) : u64 {
        arg0.player_epoch
    }

    public fun player_point_history(arg0: &Vsdb, arg1: u64) : &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point {
        0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg0.player_point_history, arg1)
    }

    public fun point_history(arg0: &VSDBRegistry) : &0x2::table_vec::TableVec<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point> {
        &arg0.point_history
    }

    public entry fun register_module<T0>(arg0: &VSDBCap, arg1: &mut VSDBRegistry, arg2: bool) {
        assert!(arg1.version == 1, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg1.modules, &v0), 103);
        0x2::vec_map::insert<0x1::type_name::TypeName, bool>(&mut arg1.modules, v0, arg2);
    }

    public entry fun remove_module<T0>(arg0: &VSDBCap, arg1: &mut VSDBRegistry) {
        assert!(arg1.version == 1, 1);
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, bool>(&mut arg1.modules, &v0);
    }

    public fun required_xp(arg0: u8, arg1: u8) : u64 {
        assert!(arg0 > arg1, 108);
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 as u64);
        let v1 = (arg1 as u64);
        25 * (v0 * v0 - v1 * v1)
    }

    public entry fun revive(arg0: &mut VSDBRegistry, arg1: &mut Vsdb, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 1);
        let v0 = locked_balance(arg1);
        let v1 = locked_end(arg1);
        let v2 = unix_timestamp(arg3);
        assert!(v2 >= v1, 102);
        assert!(v0 > 0, 105);
        checkpoint_(true, arg0, v0, v1, 0, 0, arg3);
        let v3 = round_down_week(v2 + arg2);
        extend(arg1, 0x1::option::none<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(), v3, arg3);
        checkpoint_(true, arg0, 0, 0, v0, locked_end(arg1), arg3);
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event::deposit(0x2::object::id<Vsdb>(arg1), v0, v3);
    }

    public fun round_down_week(arg0: u64) : u64 {
        arg0 / 604800 * 604800
    }

    public fun safe_selection(arg0: u64, arg1: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg1) >= 16, 109);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 16) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg1, v1) as u128);
            v1 = v1 + 1;
        };
        ((v0 % (arg0 as u128)) as u64)
    }

    public fun total_VeSDB(arg0: &VSDBRegistry, arg1: &0x2::clock::Clock) : u64 {
        total_VeSDB_at(arg0, unix_timestamp(arg1))
    }

    public fun total_VeSDB_at(arg0: &VSDBRegistry, arg1: u64) : u64 {
        let v0 = 0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg0.point_history, arg0.epoch);
        let v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::bias(v0);
        let v2 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::slope(v0);
        let v3 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::ts(v0);
        let v4 = round_down_week(v3);
        let v5 = 0;
        while (v5 < 255) {
            let v6 = v4 + 604800;
            v4 = v6;
            let v7 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
            if (v6 > arg1) {
                v4 = arg1;
            } else if (0x2::table::contains<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg0.slope_changes, v6)) {
                v7 = *0x2::table::borrow<u64, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128>(&arg0.slope_changes, v6);
            };
            let v8 = &v1;
            let v9 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::from((v4 as u128));
            let v10 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::from((v3 as u128));
            let v11 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(&v9, &v10);
            let v12 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::mul(&v2, &v11);
            v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(v8, &v12);
            if (v4 == arg1) {
                break
            };
            let v13 = &v2;
            v2 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::add(v13, &v7);
            v5 = v5 + 1;
        };
        if (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::is_neg(&v1)) {
            v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
        };
        (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::as_u128(&v1) as u64)
    }

    public fun unix_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun unlock(arg0: &mut VSDBRegistry, arg1: Vsdb, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        let v0 = locked_balance(&arg1);
        let v1 = locked_end(&arg1);
        let v2 = unix_timestamp(arg2);
        assert!(v2 >= v1, 102);
        assert!(v0 > 0, 105);
        let v3 = &mut arg1;
        let v4 = withdraw(v3, arg3);
        let v5 = 0x2::coin::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&v4);
        checkpoint_(true, arg0, v0, v1, locked_balance(&arg1), locked_end(&arg1), arg2);
        arg0.locked_total = arg0.locked_total - v5;
        destroy(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(v4, 0x2::tx_context::sender(arg3));
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event::withdraw(0x2::object::id<Vsdb>(&arg1), v5, v2);
    }

    fun update_player_point_(arg0: &mut Vsdb, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.balance);
        let v1 = unix_timestamp(arg1);
        arg0.player_epoch = arg0.player_epoch + 1;
        0x2::table_vec::push_back<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&mut arg0.player_point_history, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::new(calculate_bias(v0, arg0.end, v1), calculate_slope(v0), v1));
    }

    public fun upgrade(arg0: &VSDBRegistry, arg1: &mut Vsdb) {
        let v0 = required_xp(arg1.level + 1, arg1.level);
        while (arg1.experience >= v0) {
            arg1.experience = arg1.experience - v0;
            arg1.level = arg1.level + 1;
            v0 = required_xp(arg1.level + 1, arg1.level);
        };
        arg1.img_url = img_url(&arg1.id, locked_balance(arg1), arg1.level, (arg1.scarcity as u64), &arg0.arts);
        0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event::level_up(0x2::object::id<Vsdb>(arg1), arg1.level);
    }

    public fun voting_weight(arg0: &Vsdb, arg1: &0x2::clock::Clock) : u64 {
        voting_weight_at(arg0, unix_timestamp(arg1))
    }

    public fun voting_weight_at(arg0: &Vsdb, arg1: u64) : u64 {
        let v0 = *0x2::table_vec::borrow<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::Point>(&arg0.player_point_history, arg0.player_epoch);
        let v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::bias(&v0);
        if (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::ts(&v0) > arg1) {
            return 0
        };
        let v2 = &v1;
        let v3 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::slope(&v0);
        let v4 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::from(((arg1 - 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point::ts(&v0)) as u128));
        let v5 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::mul(&v3, &v4);
        v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::sub(v2, &v5);
        if (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::is_neg(&v1)) {
            v1 = 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::zero();
        };
        (0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::as_u128(&v1) as u64)
    }

    public fun whitelisted<T0: drop>(arg0: &VSDBRegistry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, bool>(&arg0.modules, &v0)
    }

    // decompiled from Move bytecode v6
}

