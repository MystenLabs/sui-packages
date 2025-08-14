module 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector {
    struct PriceCollector<phantom T0> has drop {
        contents: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>,
    }

    public(friend) fun remove<T0>(arg0: &mut PriceCollector<T0>, arg1: &0x1::type_name::TypeName) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(contents<T0>(arg0), arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(&mut arg0.contents, arg1);
        };
    }

    public fun collect<T0, T1: drop>(arg0: &mut PriceCollector<T0>, arg1: T1, arg2: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float) {
        let v0 = 0x1::type_name::get<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(contents<T0>(arg0), &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(&mut arg0.contents, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(&mut arg0.contents, &v0) = arg2;
        };
    }

    public fun contents<T0>(arg0: &PriceCollector<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float> {
        &arg0.contents
    }

    public fun new<T0>() : PriceCollector<T0> {
        PriceCollector<T0>{contents: 0x2::vec_map::empty<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>()}
    }

    // decompiled from Move bytecode v6
}

