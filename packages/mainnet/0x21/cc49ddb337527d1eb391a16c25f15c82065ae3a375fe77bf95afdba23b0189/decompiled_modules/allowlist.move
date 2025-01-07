module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::allowlist {
    struct Allowlist has store, key {
        id: 0x2::object::UID,
        authorities: 0x2::table::Table<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>,
    }

    fun remove<T0>(arg0: &mut Allowlist, arg1: 0x1::ascii::String) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&mut arg0.authorities, arg1);
        0x2::vec_set::remove<0x1::ascii::String>(v1, 0x1::type_name::borrow_string(&v0));
        if (0x2::vec_set::is_empty<0x1::ascii::String>(v1)) {
            0x2::table::remove<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&mut arg0.authorities, arg1);
        };
    }

    fun insert<T0>(arg0: &mut Allowlist, arg1: 0x1::ascii::String) {
        if (!0x2::table::contains<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.authorities, arg1)) {
            0x2::table::add<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&mut arg0.authorities, arg1, 0x2::vec_set::empty<0x1::ascii::String>());
        };
        0x2::vec_set::insert<0x1::ascii::String>(0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&mut arg0.authorities, arg1), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
    }

    public fun authorities(arg0: &Allowlist) : &0x2::table::Table<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>> {
        &arg0.authorities
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Allowlist{
            id          : 0x2::object::new(arg0),
            authorities : 0x2::table::new<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(arg0),
        };
        0x2::transfer::share_object<Allowlist>(v0);
    }

    public entry fun insert_collection_config<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut Allowlist) {
        insert<T1>(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
    }

    public entry fun insert_default_config<T0>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut Allowlist) {
        insert<T0>(arg1, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::default_config_key());
    }

    public entry fun remove_collection_config<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut Allowlist) {
        remove<T1>(arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
    }

    public entry fun remove_default_config<T0>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut Allowlist) {
        remove<T0>(arg1, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::default_config_key());
    }

    public(friend) fun validate_currency<T0: store + key, T1>(arg0: &Allowlist) {
        let v0 = if (0x2::table::contains<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.authorities, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) {
            0x2::table::borrow<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.authorities, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
        } else if (0x2::table::contains<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.authorities, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::default_config_key())) {
            0x2::table::borrow<0x1::ascii::String, 0x2::vec_set::VecSet<0x1::ascii::String>>(&arg0.authorities, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::default_config_key())
        } else {
            let v1 = 0x2::vec_set::empty<0x1::ascii::String>();
            &v1
        };
        let v2 = 0x1::type_name::get<T1>();
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::verifier::verify_currency(v0, 0x1::type_name::borrow_string(&v2), true);
    }

    // decompiled from Move bytecode v6
}

