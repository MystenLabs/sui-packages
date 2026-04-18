module 0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::collector {
    struct PriceCollector<phantom T0> has drop {
        contents: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>,
    }

    public(friend) fun remove<T0>(arg0: &mut PriceCollector<T0>, arg1: &0x1::type_name::TypeName) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(contents<T0>(arg0), arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(&mut arg0.contents, arg1);
        };
    }

    public fun collect<T0, T1: drop>(arg0: &mut PriceCollector<T0>, arg1: T1, arg2: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(contents<T0>(arg0), &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(&mut arg0.contents, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(&mut arg0.contents, &v0) = arg2;
        };
    }

    public fun contents<T0>(arg0: &PriceCollector<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>> {
        &arg0.contents
    }

    public fun new<T0>() : PriceCollector<T0> {
        PriceCollector<T0>{contents: 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>()}
    }

    // decompiled from Move bytecode v7
}

