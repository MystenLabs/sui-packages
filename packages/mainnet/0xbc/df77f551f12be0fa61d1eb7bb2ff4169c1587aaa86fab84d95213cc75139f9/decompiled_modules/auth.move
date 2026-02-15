module 0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::auth {
    struct Auth has store {
        member_permissions: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        config: 0x2::versioned::Versioned,
    }

    struct EditPermissions has drop {
        dummy_field: bool,
    }

    public(friend) fun config(arg0: &Auth) : &0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::Config {
        0x2::versioned::load_value<0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::Config>(&arg0.config)
    }

    public(friend) fun grant_permission<T0: drop>(arg0: &mut Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(has_permission<EditPermissions>(arg0, arg1), 0);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.member_permissions, &arg2)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.member_permissions, &arg2), 0x1::type_name::get<T0>());
        } else {
            assert!(!(0x2::vec_map::size<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.member_permissions) == 0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::config_max_channel_members(0x2::versioned::load_value<0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::Config>(&arg0.config))), 420);
            0x2::vec_map::insert<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.member_permissions, arg2, 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::get<T0>()));
        };
    }

    public(friend) fun has_permission<T0: drop>(arg0: &Auth, arg1: 0x2::object::ID) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(0x2::vec_map::get<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.member_permissions, &arg1), &v0)
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::Config>, arg2: &mut 0x2::tx_context::TxContext) : Auth {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>();
        0x2::vec_map::insert<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut v0, arg0, 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::get<EditPermissions>()));
        let v1 = if (0x1::option::is_none<0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::Config>(&arg1)) {
            0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::default()
        } else {
            0x1::option::extract<0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::Config>(&mut arg1)
        };
        Auth{
            member_permissions : v0,
            config             : 0x2::versioned::create<0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::config::Config>(0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::admin::version(), v1, arg2),
        }
    }

    public(friend) fun remove_member_entry(arg0: &mut Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(has_permission<EditPermissions>(arg0, arg1), 0);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.member_permissions, &arg2);
    }

    public(friend) fun revoke_permission<T0: drop>(arg0: &mut Auth, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(has_permission<EditPermissions>(arg0, arg1), 0);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.member_permissions, &arg2);
        let v1 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(v0, &v1);
        if (0x2::vec_set::is_empty<0x1::type_name::TypeName>(v0)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.member_permissions, &arg2);
        };
    }

    // decompiled from Move bytecode v6
}

