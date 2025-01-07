module 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::extension {
    struct Extension has store, key {
        id: 0x2::object::UID,
    }

    struct EXTENSION has drop {
        dummy_field: bool,
    }

    public fun add_tax_config<T0>(arg0: &0x2::package::Publisher, arg1: &mut Extension, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        assert!(0x2::package::from_package<EXTENSION>(arg0), 1);
        assert!(!0x2::dynamic_field::exists_with_type<0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::Marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>(&arg1.id, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>()), 1);
        0x2::dynamic_field::add<0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::Marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>(&mut arg1.id, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>(), 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::new_tax<T0>(arg2, arg3, arg4, arg5));
    }

    public fun calc_tax<T0>(arg0: &Extension, arg1: u64) : (bool, u64, address) {
        if (!0x2::dynamic_field::exists_with_type<0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::Marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>(&arg0.id, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>())) {
            (false, 0, @0xff29c1854f97ddd25745959f692e5544f907cd974a3e249f0dabed21173acbed)
        } else {
            let v3 = 0x2::dynamic_field::borrow<0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::Marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>(&arg0.id, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>());
            let (v4, v5) = 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::calc_tax<T0>(v3, arg1);
            (v4, v5, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::get_beneficiary<T0>(v3))
        }
    }

    fun init(arg0: EXTENSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Extension{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<EXTENSION>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Extension>(v0);
    }

    public fun remove_tax_config<T0>(arg0: &0x2::package::Publisher, arg1: &mut Extension) {
        assert!(0x2::package::from_package<EXTENSION>(arg0), 1);
        assert!(0x2::dynamic_field::exists_with_type<0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::Marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>(&arg1.id, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>()), 1);
        0x2::dynamic_field::remove<0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::Marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>(&mut arg1.id, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::utils::marker<T0, 0x10372c49ca2b98b44fa4d47194305d7bf2903b50256aab421da4dccefa120def::tax::Tax<T0>>());
    }

    // decompiled from Move bytecode v6
}

