module 0xd5cd31f4bf84a2c280c9ed20cbb20345cbe5c1ebe63014c406f97b20edd4ac63::quest {
    struct Quest<T0: store> has store, key {
        id: 0x2::object::UID,
        required_tasks: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        completed_tasks: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        reward: T0,
    }

    public fun new<T0: store>(arg0: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : Quest<T0> {
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&arg0) != 0, 0);
        Quest<T0>{
            id              : 0x2::object::new(arg2),
            required_tasks  : arg0,
            completed_tasks : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            reward          : arg1,
        }
    }

    public fun complete<T0: store, T1: drop>(arg0: &mut Quest<T0>, arg1: T1) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.completed_tasks, 0x1::type_name::get<T1>());
    }

    public fun completed_tasks<T0: store>(arg0: &Quest<T0>) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.completed_tasks)
    }

    public fun finish<T0: store>(arg0: Quest<T0>) : T0 {
        let Quest {
            id              : v0,
            required_tasks  : v1,
            completed_tasks : v2,
            reward          : v3,
        } = arg0;
        let v4 = v1;
        0x2::object::delete(v0);
        let v5 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v4);
        let v6 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v2);
        let v7 = 0;
        while (0x2::vec_set::size<0x1::type_name::TypeName>(&v4) > v7) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v7);
            assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v6, &v8), 1);
            v7 = v7 + 1;
        };
        v3
    }

    public fun required_tasks<T0: store>(arg0: &Quest<T0>) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.required_tasks)
    }

    // decompiled from Move bytecode v6
}

