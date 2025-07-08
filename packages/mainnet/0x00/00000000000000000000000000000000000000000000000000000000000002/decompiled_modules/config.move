module 0x2::config {
    struct Config<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct Setting<T0: copy + drop + store> has drop, store {
        data: 0x1::option::Option<SettingData<T0>>,
    }

    struct SettingData<T0: copy + drop + store> has drop, store {
        newer_value_epoch: u64,
        newer_value: 0x1::option::Option<T0>,
        older_value_opt: 0x1::option::Option<T0>,
    }

    public(friend) fun add_for_next_epoch<T0, T1: copy + drop + store, T2: copy + drop + store>(arg0: &mut Config<T0>, arg1: &mut T0, arg2: T1, arg3: T2, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<T2> {
        let v0 = 0x2::tx_context::epoch(arg4);
        if (!0x2::dynamic_field::exists_<T1>(&arg0.id, arg2)) {
            let v2 = SettingData<T2>{
                newer_value_epoch : v0,
                newer_value       : 0x1::option::some<T2>(arg3),
                older_value_opt   : 0x1::option::none<T2>(),
            };
            let v3 = Setting<T2>{data: 0x1::option::some<SettingData<T2>>(v2)};
            0x2::dynamic_field::add<T1, Setting<T2>>(&mut arg0.id, arg2, v3);
            0x1::option::none<T2>()
        } else {
            let v4 = 0x2::dynamic_field::borrow_mut<T1, Setting<T2>>(&mut arg0.id, arg2);
            let SettingData {
                newer_value_epoch : v5,
                newer_value       : v6,
                older_value_opt   : v7,
            } = 0x1::option::extract<SettingData<T2>>(&mut v4.data);
            let v8 = v6;
            let (v9, v10) = if (v0 > v5) {
                (v8, v7)
            } else {
                assert!(v0 == v5, 13906834543710568447);
                assert!(0x1::option::is_none<T2>(&v8), 0);
                (v7, 0x1::option::none<T2>())
            };
            let v11 = SettingData<T2>{
                newer_value_epoch : v0,
                newer_value       : 0x1::option::some<T2>(arg3),
                older_value_opt   : v9,
            };
            0x1::option::fill<SettingData<T2>>(&mut v4.data, v11);
            v10
        }
    }

    public(friend) fun borrow_for_next_epoch_mut<T0, T1: copy + drop + store, T2: copy + drop + store>(arg0: &mut Config<T0>, arg1: &mut T0, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) : &mut T2 {
        let v0 = 0x1::option::borrow_mut<SettingData<T2>>(&mut 0x2::dynamic_field::borrow_mut<T1, Setting<T2>>(&mut arg0.id, arg2).data);
        assert!(v0.newer_value_epoch == 0x2::tx_context::epoch(arg3), 1);
        assert!(0x1::option::is_some<T2>(&v0.newer_value), 1);
        0x1::option::borrow_mut<T2>(&mut v0.newer_value)
    }

    public(friend) fun exists_with_type<T0, T1: copy + drop + store, T2: copy + drop + store>(arg0: &Config<T0>, arg1: T1) : bool {
        0x2::dynamic_field::exists_with_type<T1, Setting<T2>>(&arg0.id, arg1)
    }

    public(friend) fun exists_with_type_for_next_epoch<T0, T1: copy + drop + store, T2: copy + drop + store>(arg0: &Config<T0>, arg1: T1, arg2: &0x2::tx_context::TxContext) : bool {
        if (0x2::dynamic_field::exists_with_type<T1, Setting<T2>>(&arg0.id, arg1)) {
            let v1 = 0x2::dynamic_field::borrow<T1, Setting<T2>>(&arg0.id, arg1);
            0x2::tx_context::epoch(arg2) == 0x1::option::borrow<SettingData<T2>>(&v1.data).newer_value_epoch && 0x1::option::is_some<T2>(&0x1::option::borrow<SettingData<T2>>(&v1.data).newer_value)
        } else {
            false
        }
    }

    public(friend) fun new<T0>(arg0: &mut T0, arg1: &mut 0x2::tx_context::TxContext) : Config<T0> {
        Config<T0>{id: 0x2::object::new(arg1)}
    }

    public(friend) fun read_setting<T0: copy + drop + store, T1: copy + drop + store>(arg0: 0x2::object::ID, arg1: T0, arg2: &0x2::tx_context::TxContext) : 0x1::option::Option<T1> {
        let v0 = 0x2::object::id_to_address(&arg0);
        read_setting_impl<0x2::dynamic_field::Field<T0, Setting<T1>>, Setting<T1>, SettingData<T1>, T1>(v0, 0x2::dynamic_field::hash_type_and_key<T0>(v0, arg1), 0x2::tx_context::epoch(arg2))
    }

    public(friend) fun read_setting_for_next_epoch<T0, T1: copy + drop + store, T2: copy + drop + store>(arg0: &Config<T0>, arg1: T1) : 0x1::option::Option<T2> {
        if (!0x2::dynamic_field::exists_with_type<T1, Setting<T2>>(&arg0.id, arg1)) {
            return 0x1::option::none<T2>()
        };
        0x1::option::borrow<SettingData<T2>>(&0x2::dynamic_field::borrow<T1, Setting<T2>>(&arg0.id, arg1).data).newer_value
    }

    native fun read_setting_impl<T0: key, T1: store, T2: store, T3: copy + drop + store>(arg0: address, arg1: address, arg2: u64) : 0x1::option::Option<T3>;
    public(friend) fun remove_for_next_epoch<T0, T1: copy + drop + store, T2: copy + drop + store>(arg0: &mut Config<T0>, arg1: &mut T0, arg2: T1, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<T2> {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::dynamic_field::exists_<T1>(&arg0.id, arg2)) {
            return 0x1::option::none<T2>()
        };
        let v1 = 0x2::dynamic_field::borrow_mut<T1, Setting<T2>>(&mut arg0.id, arg2);
        let SettingData {
            newer_value_epoch : v2,
            newer_value       : v3,
            older_value_opt   : v4,
        } = 0x1::option::extract<SettingData<T2>>(&mut v1.data);
        let (v5, v6) = if (v0 > v2) {
            (v3, 0x1::option::none<T2>())
        } else {
            assert!(v0 == v2, 13906834715509260287);
            (v4, v3)
        };
        let v7 = v5;
        let v8 = SettingData<T2>{
            newer_value_epoch : v0,
            newer_value       : 0x1::option::none<T2>(),
            older_value_opt   : v7,
        };
        0x1::option::fill<SettingData<T2>>(&mut v1.data, v8);
        if (0x1::option::is_none<T2>(&v7)) {
            0x2::dynamic_field::remove<T1, Setting<T2>>(&mut arg0.id, arg2);
        };
        v6
    }

    public(friend) fun share<T0>(arg0: Config<T0>) {
        0x2::transfer::share_object<Config<T0>>(arg0);
    }

    public(friend) fun transfer<T0>(arg0: Config<T0>, arg1: address) {
        0x2::transfer::transfer<Config<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

